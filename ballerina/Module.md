## Overview

[Pricefx](https://www.pricefx.com/) is a cloud-native pricing and revenue management platform that helps enterprises manage price lists, calculation grids, quotes, contracts, and rebate agreements across their sales organization.

The `ballerinax/pricefx` connector offers APIs to connect and interact with the [Pricefx Backend API](https://api.pricefx.com/), covering all 477 publicly exposed operations across master data (products, customers, sellers), pricing (price lists, manual price lists, calculation grids, condition records), sales (quotes, contracts, rebates, sales compensations), and platform administration (users, workflow, data manager, notifications, comments, custom forms, and more).

## Setup guide

Authentication goes in `ConnectionConfig.auth`, typed as `pricefx:PricefxCredentials` — a union of
four records, one per method. You pick the record matching the credentials you hold, and the
compiler holds you to it: an incomplete or mixed-up combination will not compile.

- **`BasicCredentials`** — `username`, `password`, `partition`. The connector authenticates once
  with HTTP Basic auth and then reuses the `X-PriceFx-jwt` session token Pricefx hands back, so the
  deliberate ~500 ms penalty Pricefx applies to Basic auth is paid once per client rather than on
  every request. If a deployment returns no session token, it falls back to Basic auth per request.
- **`OAuth2Credentials`** — `clientId`, `refreshToken`, and optionally `clientSecret`. The refresh
  token must be obtained once beforehand through Pricefx's Authorization Code Grant flow, which
  needs an interactive browser redirect and so can't be automated by this connector. Once you have
  one, access tokens are fetched and renewed automatically.
- **`JwtCredentials`** — `jwt`. Sent as-is via `X-PriceFx-jwt`, with nothing exchanged, so creating
  the client makes no network call. This is the option for the non-expiring integration tokens
  minted by `generateJwtToken`. The connector cannot refresh a token supplied this way (it holds no
  credentials to re-authenticate with), which is fine for a non-expiring token but not for a
  short-lived session one.
- **`ExternalJwtCredentials`** — `systemName`, `jwt`, if your organization has a trust relationship
  configured on the Pricefx side (`externalJWTConfiguration`) with an external system that signs
  JWTs on your behalf.

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

    ```

2. Create a `pricefx:Client` instance:

    ```ballerina
    configurable string username = ?;
    configurable string password = ?;
    configurable string partition = ?;
    configurable string serviceUrl = ?;

    final pricefx:Client pricefxClient = check new ({auth: {username, password, partition}}, serviceUrl);
    ```

    Constructing the client makes one Basic authenticated call to obtain a session token; every
    request after that uses the token. To use a different method, supply its record as `auth`
    instead — see the setup guide above. For example, with a non-expiring integration JWT:

    ```ballerina
    final pricefx:Client pricefxClient = check new ({auth: {jwt}}, serviceUrl);
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
