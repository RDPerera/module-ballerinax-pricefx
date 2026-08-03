## Overview

[Pricefx](https://www.pricefx.com/) is a cloud-native pricing and revenue management platform that helps enterprises manage price lists, calculation grids, quotes, contracts, and rebate agreements across their sales organization.

The `ballerinax/pricefx` connector offers APIs to connect and interact with the [Pricefx Backend API](https://api.pricefx.com/), covering all 477 publicly exposed operations across master data (products, customers, sellers), pricing (price lists, manual price lists, calculation grids, condition records), sales (quotes, contracts, rebates, sales compensations), and platform administration (users, workflow, data manager, notifications, comments, custom forms, and more).

## Setup guide

The connector supports several ways to authenticate with Pricefx, configured through `PricefxCredentials`/`ConnectionConfig`. Provide exactly one of the following credential combinations:

- **Username + password + partition** (+ optional `pricefxKey`) — when `pricefxKey` is set the connector exchanges your credentials for a session token at `POST /token`; otherwise it authenticates every request with HTTP Basic auth.
- **OAuth 2.0** — provide `oauth2ClientId`, `oauth2RefreshToken`, and optionally `oauth2ClientSecret`. The refresh token must be obtained once beforehand through Pricefx's Authorization Code Grant flow (`GET /pricefx/{partition}/oauth/authorize`, then `POST /pricefx/{partition}/oauth/token`) — that initial exchange needs an interactive browser redirect and can't be automated by this connector. Once you have a refresh token, the connector fetches and refreshes access tokens automatically.
- **A Pricefx JWT you already hold** — provide `jwt`. Sent as-is via `X-PriceFx-jwt`, with no token exchange, so creating the client makes no network call. This is the option for the non-expiring integration tokens minted by `generateJwtToken` — obtain one deliberately, keep it in configuration, and the connector uses it directly. Note the connector cannot refresh a token supplied this way (it has nothing to re-authenticate with), which is fine for a non-expiring token but not for a short-lived session one.
- **External JWT** — provide `externalJwtSystemName` and `externalJwt`, if your organization has a trust relationship configured on the Pricefx side (`externalJWTConfiguration`) with an external system that signs JWTs on your behalf.

Independently of the above, you can also set:

- **`csrfToken`** — a CSRF token, if your partition has CSRF protection enabled

If your Pricefx user has two-factor authentication enabled, pass the current code as a
`PriceFx-TFA` header on the call that needs it — there is no config field for it, because a
six-digit code expires in about thirty seconds and would be stale before a long-lived client made
its first request:

```ballerina
var result = check pricefxClient->listPriceLists({}, {"PriceFx-TFA": "123456"});
```

Interactive two-factor auth does not really fit unattended integrations; prefer `pricefxKey`, a
`jwt`, or OAuth 2.0 for those.

The connector automatically re-authenticates and retries once whenever a request comes back unauthenticated (JWTs and OAuth2 access tokens are short-lived), so a long-lived `pricefx:Client` instance keeps working without manual re-initialization.

## Quickstart

To use the `pricefx` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/io;
import ballerinax/pricefx;
import ballerinax/pricefx.oas;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file with your Pricefx credentials:

    ```toml
    username = "<your-pricefx-username>"
    password = "<your-pricefx-password>"
    partition = "<your-partition>"
    serviceUrl = "https://<your-node>.pricefx.com/pricefx/<your-partition>"

    # Optional. Uncomment if you have a Pricefx API key - the connector then authenticates via
    # the faster `POST /token`. Without it, the connector falls back to HTTP Basic auth
    # (`<partition>/<username>:<password>`), which needs no separate key but is slower per request.
    # pricefxKey = "<your-pricefx-api-key>"
    ```

2. Create a `pricefx:Client` instance:

    ```ballerina
    configurable string username = ?;
    configurable string password = ?;
    configurable string partition = ?;
    configurable string? pricefxKey = ();
    configurable string serviceUrl = ?;

    pricefx:ConnectionConfig config = {username, password, partition};
    if pricefxKey is string {
        config.pricefxKey = pricefxKey;
    }
    final pricefx:Client pricefxClient = check new (config, serviceUrl);
    ```

    Or, using OAuth 2.0 instead:

    ```ballerina
    pricefx:ConnectionConfig config = {
        oauth2ClientId,
        oauth2ClientSecret,
        oauth2RefreshToken
    };
    final pricefx:Client pricefxClient = check new (config, serviceUrl);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List all price lists

```ballerina
public function main() returns error? {
    oas:ListPriceListsRequest payload = {};
    oas:ListPriceListsResponse response = check pricefxClient->listPriceLists(payload);
    io:println(response);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Pricefx` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-pricefx/tree/main/examples/), covering the following use cases:

1. [Product catalog management](https://github.com/ballerina-platform/module-ballerinax-pricefx/tree/main/examples/product-catalog-management) — Add a new product to the catalog, update one of its fields, then list matching products to confirm the change.
2. [Customer quote workflow](https://github.com/ballerina-platform/module-ballerinax-pricefx/tree/main/examples/customer-quote-workflow) — Add a new customer, create a quote for them, then submit the quote for approval.
3. [Price list calculation](https://github.com/ballerina-platform/module-ballerinax-pricefx/tree/main/examples/price-list-calculation) — Create a new price list, run its calculation, then fetch the calculated price list.
4. [Attachment upload workflow](https://github.com/ballerina-platform/module-ballerinax-pricefx/tree/main/examples/attachment-upload-workflow) — Create an upload slot for a customer record, upload a file to it, then list the customer's files.
