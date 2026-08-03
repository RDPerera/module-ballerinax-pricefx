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

# Request body for Pricefx's `POST /token` session-token exchange.
#
# This is the connector's own session bootstrap, not a public operation - `POST /token` is
# deliberately not exposed on the client, because callers must never manage the session the
# connector owns. The type is declared here rather than reused from the generated `oas` module
# for exactly that reason: no generated operation references it any more.
type TokenExchangeRequest record {|
    string username;
    string password;
    string partition;
|};

# Response from Pricefx's `POST /token`. Field names match the wire format, which is hyphenated.
# Only `access-token` is required; the rest are accepted if present but unused, and the record is
# open so additional fields a future Pricefx version might add do not break the exchange.
type TokenExchangeResponse record {
    string access\-token;
    string refresh\-token?;
    string token\-type?;
    decimal expires\-in?;
};

# Pricefx account credentials and authentication options. Exactly one of the following
# combinations must be provided:
#
# - `username` + `password` + `partition` (+ optional `pricefxKey`) - the connector authenticates
#   via `POST /token` when `pricefxKey` is set, or via HTTP Basic auth otherwise
# - `oauth2ClientId` + `oauth2RefreshToken` (+ optional `oauth2ClientSecret`) - OAuth 2.0, using a
#   refresh token obtained beforehand through Pricefx's Authorization Code Grant flow (that initial
#   exchange requires an interactive browser redirect and can't be automated by this connector -
#   see Pricefx's OAuth 2.0 documentation). The connector automatically refreshes the access token
#   as needed
# - `jwt` - a Pricefx-issued JWT you already hold, sent as `X-PriceFx-jwt`. No exchange happens at
#   all, so this is the cheapest option. Intended for the non-expiring integration tokens minted by
#   `generateJwtToken`/`generateTimedJwtToken`
# - `externalJwtSystemName` + `externalJwt` - a pre-signed JWT from a trusted external system,
#   configured on the Pricefx side via `externalJWTConfiguration`
#
# `tfaCode` and `csrfToken` are independent of the above and can be set alongside any of them.
public type PricefxCredentials record {|
    # Your Pricefx username
    string username?;
    # Your Pricefx password
    string password?;
    # Your Pricefx partition name
    string partition?;
    # A Pricefx API key (contact Pricefx Support to obtain one). When set, authentication uses
    # `POST /token`, which is faster and recommended for server-to-server integrations. When
    # absent, authentication falls back to HTTP Basic auth (`<partition>/<username>:<password>`),
    # which needs no separate API key but is slower per request
    string pricefxKey?;
    # A Pricefx-issued JWT you already hold, sent directly as the `X-PriceFx-jwt` header. Unlike
    # `pricefxKey`, no `POST /token` exchange happens - the token is used as given, so client
    # initialization performs no network call at all.
    #
    # Intended for the non-expiring integration tokens produced by `generateJwtToken` (or the
    # time-limited ones from `generateTimedJwtToken`), which you obtain once and keep in
    # configuration. Note that a token supplied this way cannot be refreshed by the connector: it
    # has nothing to re-authenticate with, so if the token is rejected the error surfaces to you
    # rather than being retried. That is fine for a non-expiring token, but if you paste in a
    # short-lived session token it will eventually stop working - use `pricefxKey`, or
    # username/password, if you want the connector to manage renewal.
    string jwt?;
    # OAuth 2.0 client identifier, as registered in Pricefx's `oauthConfiguration`
    string oauth2ClientId?;
    # OAuth 2.0 client secret, if one was configured for the client
    string oauth2ClientSecret?;
    # A refresh token previously obtained through Pricefx's OAuth 2.0 Authorization Code Grant
    # flow. The connector uses it to fetch (and automatically refresh) access tokens
    string oauth2RefreshToken?;
    # A cleartext two-factor authentication code, sent as the `PriceFx-TFA` header on every
    # request. Only required when the calling user has TFA enabled and no session cookie exists
    string tfaCode?;
    # A CSRF token, sent as the `X-PriceFx-Csrf-Token` header on every request. Only required when
    # the partition has CSRF protection enabled
    string csrfToken?;
    # The name of the external system trusted via Pricefx's `externalJWTConfiguration`, used
    # together with `externalJwt`
    string externalJwtSystemName?;
    # A JWT signed by the external system named in `externalJwtSystemName`, sent as
    # `Authorization: BEARER <externalJwtSystemName>;<externalJwt>` on every request
    string externalJwt?;
|};

# Provides a set of configurations for controlling the behaviours when communicating with a remote
# HTTP endpoint. Includes `PricefxCredentials` directly. The client automatically re-authenticates
# and retries once whenever a request comes back unauthenticated, so a long-lived client instance
# keeps working without manual re-initialization.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    *PricefxCredentials;
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
