# Tests

The connector generates a client for nearly all 480 operations in the Pricefx Backend API spec. This test suite covers 30 representative operations spanning the most commonly used resource areas: Products (`addProduct`, `updateProduct`, `listProducts`), Customers (`addCustomer`, `updateCustomer`, `listCustomers`), Sellers (`addSeller`, `listSellers`), Condition records (`addConditionRecordSet`, `listConditionRecordSets`, `deleteConditionRecordSet`), Price lists (`listPriceLists`, `getPriceList`, `createPriceList`), Manual price lists (`createManualPriceList`, `listManualPriceLists`), Calculation grids (`addCalculationGrid`, `listCalculationGrids`, `calculateCalculationGrid`), Quotes (`upsertQuote`, `listQuotes`, `getQuote`), Contracts (`getContract`, `upsertContract`), Attachments (`createUploadSlot`, `listFiles`), and Authentication (`login`, `createAuthToken`), plus delete/mutation operations for Products and Customers.

Each test runs against a local mock server (`tests/mock_service.bal`) that returns realistic canned responses, so no real Pricefx credentials are required to run the suite. Since several Pricefx request schemas require non-empty nested arrays (e.g. a Quote's line items) that add no value to these wire-format checks, the mock service disables payload validation (`@http:ServiceConfig {validation: false}`) rather than requiring fully realistic business objects on every call.

`Client.init()` performs a live authentication call (`POST /token`) against whichever server it's pointed at, including the mock — so the connector is constructed in `@test:BeforeSuite` rather than a module-level variable initializer, guaranteeing the mock listener is already up when that call is made.

## Running Tests

```bash
bal test
```

The test suite uses a mock server (`tests/mock_service.bal`) that intercepts HTTP calls so no real credentials are required.
