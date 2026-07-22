## Overview

[Pricefx](https://www.pricefx.com/) is a cloud-native pricing and revenue management platform that helps enterprises manage price lists, calculation grids, quotes, contracts, and rebate agreements across their sales organization.

The `ballerinax/pricefx` connector offers APIs to connect and interact with the [Pricefx Backend API](https://api.pricefx.com/), covering nearly all 480 operations across master data (products, customers, sellers), pricing (price lists, manual price lists, calculation grids, condition records), sales (quotes, contracts, rebates, sales compensations), and platform administration (users, workflow, data manager, notifications, comments, custom forms, and more).

## Setup guide

To use the Pricefx connector, you need a Pricefx partition (a dedicated instance/environment) and either an account username/password or an API key.

### Step 1: Get a Pricefx partition

Pricefx doesn't offer public self-service sign-up for API access. Reach out to your Pricefx account contact (sales, customer success, or partner contact) to have a partition provisioned for you. You'll receive:

- A **node hostname** (e.g. `yourcompany.pricefx.com`)
- A **partition name** (e.g. `yourcompanypartition`)
- Login credentials (username and password), and/or a **Pricefx-Key** API key

### Step 2: Obtain an authentication token

The Pricefx API uses a short-lived JWT (`X-PriceFx-jwt`) for authenticating requests. Obtain one via:

- `GET /login/extended` — Basic-Auth-style login with your username/password (returns the token as part of the response), or
- `POST /token` — pass your **Pricefx-Key** header along with a username/password/partition payload (recommended for server-to-server integrations)

> See Pricefx's own [REST API integration guide](https://api.pricefx.com/rest-api/integration-guide) for full details on token acquisition and expiry (JWTs from `/login/extended` expire after 30 minutes).

## Quickstart

To use the `pricefx` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/io;
import ballerinax/pricefx;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained JWT token, along with your Pricefx node and partition:

    ```toml
    token = "<your-pricefx-jwt-token>"
    serviceUrl = "https://<your-node>.pricefx.com/pricefx/<your-partition>"
    ```

2. Create a `pricefx:Client` instance:

    ```ballerina
    configurable string token = ?;
    configurable string serviceUrl = ?;

    final pricefx:Client pricefxClient = check new ({auth: {xPriceFxJwt: token}}, serviceUrl = serviceUrl);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### List all price lists

```ballerina
public function main() returns error? {
    pricefx:ListPriceListsRequest payload = {};
    pricefx:ListPriceListsResponse response = check pricefxClient->/fetch/PL.post(payload);
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
