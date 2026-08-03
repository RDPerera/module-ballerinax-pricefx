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

import ballerina/os;
import ballerinax/pricefx.oas;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? os:getEnv("PRICEFX_SERVICE_URL") : "http://localhost:9090/pricefx/companypartition";
final string username = isLiveServer ? os:getEnv("PRICEFX_USERNAME") : "test-user";
final string password = isLiveServer ? os:getEnv("PRICEFX_PASSWORD") : "test-password";
final string partition = isLiveServer ? os:getEnv("PRICEFX_PARTITION") : "companypartition";

// `Client.init()` performs a live authentication call (the Basic auth session bootstrap), so it
// can't run as part of a module-level variable initializer here - that phase completes before the
// mock listener in mock_service.bal starts accepting connections. Constructing the client in
// `@test:BeforeSuite` instead guarantees the mock listener is already up.
isolated Client? pricefxClientHolder = ();

@test:BeforeSuite
function setUpPricefxClient() returns error? {
    // Constraint validation is disabled here only for the mock/live smoke-test client: several
    // Pricefx request schemas mark large nested arrays as non-empty (`minLength: 1`), and
    // populating full business-realistic graphs (e.g. a Quote's line items) just to satisfy
    // runtime validation adds no value to these wire-format tests. Real usage should leave
    // validation at its default (true).
    Client newClient = check new ({username, password, partition, validation: false}, serviceUrl);
    lock {
        pricefxClientHolder = newClient;
    }
}

isolated function getPricefxClient() returns Client {
    lock {
        Client? c = pricefxClientHolder;
        if c is Client {
            return c;
        }
        panic error("pricefx client was not initialized - @test:BeforeSuite did not run");
    }
}

@test:Config {
    groups: ["mock_tests"]
}
function testReauthenticatesAndRetriesOnUnauthorized() returns error? {
    // The mock's `/accountmanager.fetchusers` rejects its first call with a 401 (simulating an
    // expired token) and succeeds afterwards. The wrapper should re-authenticate and replay the
    // request transparently, so the caller sees a successful response rather than the 401.
    Client pricefxClient = getPricefxClient();
    oas:ListUsersResponse response = check pricefxClient->listUsers({});
    test:assertTrue(response?.response !is (), "expected the retried request to succeed after re-authentication");
}

@test:Config {
    groups: ["mock_tests"]
}
function testBasicAuthBootstrapsASessionToken() returns error? {
    // Authenticating with username/password should cost one Basic authenticated call, after which
    // every request carries the session token Pricefx handed back as a cookie - not the
    // credentials. Pricefx makes Basic auth deliberately slow, so re-sending it per request would
    // add roughly half a second each time.
    Client basicClient = check new ({username, password, partition, validation: false}, serviceUrl);
    oas:ListPriceListsResponse response = check basicClient->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(
        node.includes("jwt=mock-session-jwt-abc123"),
        "expected the bootstrapped session token to be sent as X-PriceFx-jwt, got: " + node
    );
    test:assertFalse(
        node.includes("auth=Basic"),
        "expected no Basic credentials on requests after the bootstrap, got: " + node
    );
}

@test:Config {
    groups: ["mock_tests"]
}
function testFallsBackToBasicAuthWhenNoSessionCookieIsIssued() returns error? {
    // Against a deployment that issues no session cookie, initialization must still succeed and
    // simply keep using Basic auth per request. The bootstrap is an optimization; losing it should
    // never turn into an outage.
    Client fallbackClient = check new (
        {username, password, partition: "nocookie", validation: false},
        "http://localhost:9090/pricefx/nocookie"
    );
    oas:ListPriceListsResponse response = check fallbackClient->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(
        node.includes("auth=Basic "),
        "expected a fallback to per-request Basic auth when no session cookie is issued, got: " + node
    );
}

@test:Config {
    groups: ["mock_tests"]
}
function testCsrfTokenIsMerged() returns error? {
    Client csrfClient = check new (
        {username, password, partition, csrfToken: "csrf-abc", validation: false},
        serviceUrl
    );
    oas:ListPriceListsResponse response = check csrfClient->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(node.includes("csrf=csrf-abc"), "expected the X-PriceFx-Csrf-Token header to be merged in, got: " + node);
}

@test:Config {
    groups: ["mock_tests"]
}
function testPerCallHeaderReachesTheServer() returns error? {
    // There is no config field for a two-factor code (it expires in seconds), so it is passed
    // per call. This also covers the general case: any header a caller supplies on a single
    // operation is forwarded, and takes precedence over the connector's own merged headers.
    Client pricefxClient = getPricefxClient();
    oas:ListPriceListsResponse response = check pricefxClient->listPriceLists({}, {"PriceFx-TFA": "123456"});
    string node = response.response?.node ?: "";
    test:assertTrue(node.includes("tfa=123456"), "expected a per-call header to reach the server, got: " + node);
}

@test:Config {
    groups: ["mock_tests"]
}
function testOAuth2RefreshTokenAuth() returns error? {
    Client oauth2Client = check new (
        {oauth2ClientId: "test-client-id", oauth2ClientSecret: "test-client-secret", oauth2RefreshToken: "test-refresh-token", validation: false},
        serviceUrl
    );
    oas:ListPriceListsResponse response = check oauth2Client->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(
        node.includes("auth=Bearer mock-oauth2-access-token"),
        "expected the OAuth2 access token (fetched via the mock /oauth/token endpoint) to be sent as the Authorization header, got: " + node
    );
}

@test:Config {
    groups: ["mock_tests"]
}
function testPreObtainedJwtAuth() returns error? {
    // A Pricefx-issued JWT the caller already holds (e.g. a non-expiring integration token from
    // `generateJwtToken`). It is sent as-is: no `POST /token` exchange happens, so constructing
    // this client makes no network call at all.
    Client jwtClient = check new ({jwt: "preobtained-jwt-xyz", validation: false}, serviceUrl);
    oas:ListPriceListsResponse response = check jwtClient->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(
        node.includes("jwt=preobtained-jwt-xyz"),
        "expected the supplied JWT to be sent unchanged as X-PriceFx-jwt, got: " + node
    );
}

@test:Config {
    groups: ["mock_tests"]
}
function testExternalJwtAuth() returns error? {
    Client externalJwtClient = check new (
        {externalJwtSystemName: "mysystem", externalJwt: "signed-jwt-value", validation: false},
        serviceUrl
    );
    oas:ListPriceListsResponse response = check externalJwtClient->listPriceLists({});
    string node = response.response?.node ?: "";
    test:assertTrue(
        node.includes("auth=BEARER mysystem;signed-jwt-value"),
        "expected the external JWT to be sent as the Authorization header, got: " + node
    );
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:AddCustomerRequest payload = {
        data: {customerId: "CUST-2001", name: "Test Customer"},
        operation: "add"
    };
    oas:customerResponse response = check pricefxClient->addCustomer(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddConditionRecordSet() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:AddCRCSBody payload = {
        data: {uniqueName: "test-crcs", keySize: 12, label: "Test Condition Record Set"},
        operation: "add"
    };
    oas:ConditionRecordSetOperationEnvelope response = check pricefxClient->addConditionRecordSet(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateManualPriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:CreateManualPriceListRequest payload = {
        textMatchStyle: "exact",
        data: {uniqueName: "q1-2026-promo", label: "Q1 2026 Promo Price List", validAfter: "2026-01-01", status: "ACTIVE"},
        operationType: "add"
    };
    oas:manualpricelistResponse response = check pricefxClient->createManualPriceList(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:AddProductRequest payload = {
        data: {sku: "SKU-9001", label: "Test Product"},
        operation: "add"
    };
    oas:productResponse response = check pricefxClient->addProduct(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddSeller() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:AddSellerRequest payload = {
        data: {sellerId: "SL-9001", name: "Test Seller"},
        operation: "add"
    };
    oas:AddSellerEnvelope response = check pricefxClient->addSeller(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListFiles() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:BdmanagerListtypedIdBody payload = {};
    oas:ListFilesEnvelope response = check pricefxClient->listFiles("1001.C", payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCalculationGrid() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:AddCalculationGridRequest payload = {
        data: {configuration: "Standard Discount Grid", label: "Standard Discount Grid", keyGenerationType: "MANUAL"}
    };
    oas:AddCalculationGridResponse response = check pricefxClient->addCalculationGrid(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCalculateCalculationGrid() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:CalculateCalculationGridRequest payload = {};
    oas:CalculateCalculationGridResponse response = check pricefxClient->calculateCalculationGrid("6001", payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetContract() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:contractModelResponse response = check pricefxClient->getContract("acme-master-agreement");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertContract() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ContractmanagersaveDataContract contract = {
        outputs: [],
        headerText: "Globex Partner Agreement",
        endDate: "2026-12-31",
        workflowStatus: "DRAFT",
        inputs: [],
        lastUpdateDate: "2026-01-15T10:00:00Z",
        serverMessagesExtended: [],
        lineItems: [],
        targetDate: "2026-01-15T10:00:00Z",
        serverMessages: [],
        hasWorkflowHistory: false,
        nodeId: 8002,
        startDate: "2026-01-15",
        status: "DRAFT",
        createDate: "2026-01-15T10:00:00Z",
        dirty: false,
        refreshInputs: false,
        contractStatus: "DRAFT",
        numberOfAttachments: 0,
        label: "Globex Partner Agreement",
        productGroup: {productFieldName: "sku", productFieldLabel: "SKU", productFieldValue: "*"},
        createdBy: 1,
        viewState: {},
        calculationStatus: 0,
        lastUpdateBy: 1
    };
    oas:UpsertContractRequest payload = {data: {contract: contract}};
    oas:contractModelResponse response = check pricefxClient->upsertContract(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCustomers() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListCustomersRequest payload = {};
    oas:customerResponse response = check pricefxClient->listCustomers(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:DeleteCustomerRequest payload = {data: {typedId: "1001.C"}};
    oas:DeleteCustomerResponse response = check pricefxClient->deleteCustomer(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteConditionRecordSet() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:DcrmanagerDeletemassopidBody payload = {data: {typedId: "500.CRCS"}};
    oas:ConditionRecordSetOperationEnvelope response = check pricefxClient->deleteConditionRecordSet(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:DeleteProductRequest payload = {data: {typedId: "3001.P"}};
    oas:DeleteProductResponse response = check pricefxClient->deleteProduct(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCalculationGrids() returns error? {
    Client pricefxClient = getPricefxClient();
    record {} payload = {};
    oas:ListCalculationGridsResponse response = check pricefxClient->listCalculationGrids(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListConditionRecordSets() returns error? {
    Client pricefxClient = getPricefxClient();
    record {} payload = {};
    oas:ListConditionRecordSetsEnvelope response = check pricefxClient->listConditionRecordSets(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListManualPriceLists() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListManualPriceListsRequest payload = {};
    oas:manualpricelistResponse response = check pricefxClient->listManualPriceLists(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListPriceLists() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListPriceListsRequest payload = {};
    oas:ListPriceListsResponse response = check pricefxClient->listPriceLists(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:GetPriceListResponse response = check pricefxClient->getPriceList("9001");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreatePriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:CreatePriceListRequest payload = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    oas:CreatePriceListResponse response = check pricefxClient->createPriceList(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListProducts() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListProductsRequest payload = {};
    oas:productResponse response = check pricefxClient->listProducts(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetQuote() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:quoteResponse response = check pricefxClient->getQuote("10001.QU");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListQuotes() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListQuotesRequest payload = {};
    oas:ListQuotesResponse response = check pricefxClient->listQuotes(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertQuote() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:QuotemanagersaveDataQuote quote = {
        outputs: [],
        createdByName: "Jane Doe",
        typedId: "10002.QU",
        headerText: "Globex Renewal Quote",
        workflowStatus: "DRAFT",
        inputs: [],
        lastUpdateDate: "2026-01-15T10:00:00Z",
        lineItems: [],
        rootUniqueName: "q-2026-002",
        targetDate: "2026-01-15",
        version: 1,
        uniqueName: "q-2026-002",
        hasWorkflowHistory: false,
        status: "DRAFT",
        lastUpdateByName: "Jane Doe",
        quoteStatus: "OPEN",
        expiryDate: "2026-03-15",
        customerId: "1001.C",
        submittedByName: "Jane Doe",
        createDate: "2026-01-15T10:00:00Z",
        dirty: false,
        refreshInputs: false,
        numberOfAttachments: 0,
        createdBy: 1,
        viewState: {selectedNodes: []},
        prevRev: "0",
        calculationStatus: 0,
        lastUpdateBy: 1
    };
    oas:UpsertQuoteRequest payload = {data: {quote: quote}};
    oas:quoteResponse response = check pricefxClient->upsertQuote(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListSellers() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:ListSellersRequest payload = {};
    oas:ListSellersEnvelope response = check pricefxClient->listSellers(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:UpdateCustomerRequest payload = {
        data: {typedId: "1001.C", attribute1: "N/A", attribute2: "N/A"},
        textMatchStyle: "exact",
        operationType: "update",
        oldValues: {
            typedId: "1001.C",
            lastUpdateDate: "2026-01-15T10:00:00Z",
            customerId: "CUST-1001",
            createDate: "2026-01-15T10:00:00Z",
            isParent: false,
            version: 1,
            createdBy: 1,
            name: "Acme Corp",
            attribute1: "N/A",
            attribute2: "N/A",
            nodeId: 1001,
            lastUpdateBy: 1
        }
    };
    oas:customerResponse response = check pricefxClient->updateCustomer(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:UpdateProductRequest payload = {
        data: {typedId: "3001.P", label: "Wireless Mouse Pro"},
        oldValues: {typedId: "3001.P", version: 1}
    };
    oas:productResponse response = check pricefxClient->updateProduct(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateUploadSlot() returns error? {
    Client pricefxClient = getPricefxClient();
    oas:CreateUploadSlotEnvelope response = check pricefxClient->createUploadSlot();
    test:assertTrue(response?.response !is ());
}
