// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerinax/pricefx.oas;

# Your regular Pricefx login, which the connector turns into a reusable session token.
#
# Pricefx charges a deliberate penalty on Basic authenticated requests - roughly 500ms, because
# "the password verification is intentionally slow to mitigate brute-force password guess attacks"
# - and hands back an `X-PriceFx-jwt` session token on the first such call. The connector therefore
# authenticates once when the client is created and uses that token for everything afterwards, so
# the penalty is paid once per client rather than on every request. When the token expires the
# connector obtains a new one and replays the request, so nothing is required of the caller.
public type BasicCredentials record {|
    # Your Pricefx username
    string username;
    # Your Pricefx password
    string password;
    # The partition to authenticate against. Pricefx requires the Basic auth credential to be
    # `<partition>/<username>:<password>`; the connector assembles that for you
    string partition;
|};

# A Pricefx-issued JWT you already hold.
#
# Sent as-is via `X-PriceFx-jwt`. Nothing is exchanged, so creating the client performs no network
# call at all - the cheapest of the options here.
#
# Intended for the non-expiring integration tokens produced by `generateJwtToken` (or the
# time-limited ones from `generateTimedJwtToken`), which you obtain once and keep in configuration.
# The connector cannot refresh a token supplied this way, as it holds no credentials to
# re-authenticate with: if the token is rejected the error surfaces to you rather than being
# retried. That is correct for a non-expiring token, but a short-lived session token pasted in here
# will eventually stop working - use `BasicCredentials` if you want renewal handled for you.
public type JwtCredentials record {|
    # The Pricefx-issued JWT to send on every request
    string jwt;
|};

# OAuth 2.0, using a refresh token you obtained beforehand.
#
# The initial authorization-code exchange needs an interactive browser redirect and so cannot be
# automated by this connector (or any library) - do it once out of band and keep the refresh token.
# From then on Ballerina's HTTP layer fetches an access token before the first request that needs
# one and silently renews it on expiry.
public type OAuth2Credentials record {|
    # The client identifier, as registered in Pricefx's `oauthConfiguration`
    string clientId;
    # The client secret, if one was configured for this client
    string clientSecret?;
    # A refresh token from a completed Authorization Code Grant flow
    string refreshToken;
|};

# A JWT signed by a system Pricefx has been configured to trust.
#
# Requires a trust relationship on the Pricefx side (an `externalJWTConfiguration` entry naming
# your system and holding its public key). The token is sent as
# `Authorization: Bearer <systemName>;<jwt>`, which is a Pricefx-specific value rather than a
# standard bearer token.
public type ExternalJwtCredentials record {|
    # The external system's name, as configured in `externalJWTConfiguration`
    string systemName;
    # A JWT signed by that system
    string jwt;
|};

# How to authenticate with Pricefx. Pick the record matching the credentials you hold; the compiler
# then holds you to that choice, rather than accepting any mixture of loose optional fields.
public type PricefxCredentials BasicCredentials|JwtCredentials|OAuth2Credentials|ExternalJwtCredentials;

# Provides a set of configurations for controlling the behaviours when communicating with a remote
# HTTP endpoint. Transport settings only - credentials are passed separately, as
# `PricefxCredentials`.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    oas:ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional,
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};
