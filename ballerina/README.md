## Overview

[Pricefx](https://www.pricefx.com/) is a cloud-native pricing and revenue management platform that helps enterprises manage price lists, calculation grids, quotes, contracts, and rebate agreements across their sales organization.

The `ballerinax/pricefx` connector offers APIs to connect and interact with the [Pricefx Backend API](https://api.pricefx.com/), covering nearly all 480 operations across master data (products, customers, sellers), pricing (price lists, manual price lists, calculation grids, condition records), sales (quotes, contracts, rebates, sales compensations), and platform administration (users, workflow, data manager, notifications, comments, custom forms, and more).

## Setup guide

The connector supports several ways to authenticate with Pricefx, configured through `PricefxCredentials`/`ConnectionConfig`. Provide exactly one of the following credential combinations:

- **Username + password + partition** (+ optional **Pricefx API key**) — the most common setup. Contact Pricefx Support for an API key if you want the faster `POST /token` exchange; without one, the connector falls back to HTTP Basic auth (`<partition>/<username>:<password>` on every request).
- **OAuth 2.0** — provide `oauth2ClientId`, `oauth2RefreshToken`, and optionally `oauth2ClientSecret`. The refresh token must be obtained once beforehand through Pricefx's Authorization Code Grant flow (`GET /pricefx/{partition}/oauth/authorize`, then `POST /pricefx/{partition}/oauth/token`) — that initial exchange needs an interactive browser redirect and can't be automated by this connector. Once you have a refresh token, the connector fetches and refreshes access tokens automatically.
- **External JWT** — provide `externalJwtSystemName` and `externalJwt`, if your organization has a trust relationship configured on the Pricefx side (`externalJWTConfiguration`) with an external system that signs JWTs on your behalf.

Independently of the above, you can also set:

- **`tfaCode`** — a two-factor authentication code, if your user has TFA enabled
- **`csrfToken`** — a CSRF token, if your partition has CSRF protection enabled

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`pricefx` package](https://central.ballerina.io/ballerinax/pricefx/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
