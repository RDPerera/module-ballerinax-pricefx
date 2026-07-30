## Overview

[Pricefx](https://www.pricefx.com/) is a cloud-native pricing and revenue management platform that helps enterprises manage price lists, calculation grids, quotes, contracts, and rebate agreements across their sales organization.

The `ballerinax/pricefx` connector offers APIs to connect and interact with the [Pricefx Backend API](https://api.pricefx.com/), covering nearly all 480 operations across master data (products, customers, sellers), pricing (price lists, manual price lists, calculation grids, condition records), sales (quotes, contracts, rebates, sales compensations), and platform administration (users, workflow, data manager, notifications, comments, custom forms, and more).

## Setup guide

To use the Pricefx connector, you need your Pricefx username, password, and partition name. The connector exchanges these for a session token internally — there's no separate login step to perform yourself.

- **Username** and **password** — your regular Pricefx login credentials
- **Partition** — the name of your Pricefx partition
- **Pricefx API key** (optional) — contact Pricefx Support to obtain one. When provided, the connector authenticates via the faster `POST /token` endpoint; otherwise it falls back to HTTP Basic auth (`<partition>/<username>:<password>` on every request)

The connector also re-authenticates automatically whenever the session token expires (Pricefx JWTs are valid for around 30 minutes), so a long-lived `pricefx:Client` instance keeps working without manual re-initialization.

## Quickstart

To use the `pricefx` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/io;
import ballerinax/pricefx;
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

    pricefx:PricefxCredentials auth = {username, password, partition};
    if pricefxKey is string {
        auth.pricefxKey = pricefxKey;
    }
    final pricefx:Client pricefxClient = check new ({auth}, serviceUrl);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List all price lists

```ballerina
public function main() returns error? {
    pricefx:ListPriceListsRequest payload = {};
    pricefx:ListPriceListsResponse response = check pricefxClient->listPriceLists(payload);
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
