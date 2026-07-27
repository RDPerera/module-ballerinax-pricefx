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
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? os:getEnv("PRICEFX_SERVICE_URL") : "http://localhost:9090/pricefx/companypartition";
final string username = isLiveServer ? os:getEnv("PRICEFX_USERNAME") : "test-user";
final string password = isLiveServer ? os:getEnv("PRICEFX_PASSWORD") : "test-password";
final string partition = isLiveServer ? os:getEnv("PRICEFX_PARTITION") : "companypartition";
final string pricefxKey = isLiveServer ? os:getEnv("PRICEFX_KEY") : "test-pricefx-key";

// `Client.init()` now performs a live authentication call (POST /token), so it can't run as part
// of a module-level variable initializer here - that phase completes before the mock listener in
// mock_service.bal starts accepting connections. Constructing the client in `@test:BeforeSuite`
// instead guarantees the mock listener is already up.
isolated Client? pricefxClientHolder = ();

@test:BeforeSuite
function setUpPricefxClient() returns error? {
    // Constraint validation is disabled here only for the mock/live smoke-test client: several
    // Pricefx request schemas mark large nested arrays as non-empty (`minLength: 1`), and
    // populating full business-realistic graphs (e.g. a Quote's line items) just to satisfy
    // runtime validation adds no value to these wire-format tests. Real usage should leave
    // validation at its default (true).
    Client newClient = check new ({auth: {username, password, partition, pricefxKey}, validation: false}, serviceUrl);
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
    groups: ["live_tests", "mock_tests"]
}
function testLogin() returns error? {
    Client pricefxClient = getPricefxClient();
    UserLoginResponse response = check pricefxClient->login();
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    AddCustomerRequest payload = {
        data: {customerId: "CUST-2001", name: "Test Customer"},
        operation: "add"
    };
    customerResponse response = check pricefxClient->addCustomer(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddConditionRecordSet() returns error? {
    Client pricefxClient = getPricefxClient();
    AddCRCSBody payload = {
        data: {uniqueName: "test-crcs", keySize: 12, label: "Test Condition Record Set"},
        operation: "add"
    };
    ConditionRecordSetOperationEnvelope response = check pricefxClient->addConditionRecordSet(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateManualPriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    CreateManualPriceListRequest payload = {
        textMatchStyle: "exact",
        data: {uniqueName: "q1-2026-promo", label: "Q1 2026 Promo Price List", validAfter: "2026-01-01", status: "ACTIVE"},
        operationType: "add"
    };
    manualpricelistResponse response = check pricefxClient->createManualPriceList(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    AddProductRequest payload = {
        data: {sku: "SKU-9001", label: "Test Product"},
        operation: "add"
    };
    productResponse response = check pricefxClient->addProduct(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddSeller() returns error? {
    Client pricefxClient = getPricefxClient();
    AddSellerRequest payload = {
        data: {sellerId: "SL-9001", name: "Test Seller"},
        operation: "add"
    };
    AddSellerEnvelope response = check pricefxClient->addSeller(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListFiles() returns error? {
    Client pricefxClient = getPricefxClient();
    BdmanagerListtypedIdBody payload = {};
    ListFilesEnvelope response = check pricefxClient->listFiles("1001.C", payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCalculationGrid() returns error? {
    Client pricefxClient = getPricefxClient();
    AddCalculationGridRequest payload = {
        data: {configuration: "Standard Discount Grid", label: "Standard Discount Grid", keyGenerationType: "MANUAL"}
    };
    AddCalculationGridResponse response = check pricefxClient->addCalculationGrid(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCalculateCalculationGrid() returns error? {
    Client pricefxClient = getPricefxClient();
    CalculateCalculationGridRequest payload = {};
    CalculateCalculationGridResponse response = check pricefxClient->calculateCalculationGrid("6001", payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetContract() returns error? {
    Client pricefxClient = getPricefxClient();
    contractModelResponse response = check pricefxClient->getContract("acme-master-agreement");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertContract() returns error? {
    Client pricefxClient = getPricefxClient();
    ContractmanagersaveDataContract contract = {
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
    UpsertContractRequest payload = {data: {contract: contract}};
    contractModelResponse response = check pricefxClient->upsertContract(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCustomers() returns error? {
    Client pricefxClient = getPricefxClient();
    ListCustomersRequest payload = {};
    customerResponse response = check pricefxClient->listCustomers(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    DeleteCustomerRequest payload = {data: {typedId: "1001.C"}};
    DeleteCustomerResponse response = check pricefxClient->deleteCustomer(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteConditionRecordSet() returns error? {
    Client pricefxClient = getPricefxClient();
    DcrmanagerDeletemassopidBody payload = {data: {typedId: "500.CRCS"}};
    ConditionRecordSetOperationEnvelope response = check pricefxClient->deleteConditionRecordSet(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    DeleteProductRequest payload = {data: {typedId: "3001.P"}};
    DeleteProductResponse response = check pricefxClient->deleteProduct(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCalculationGrids() returns error? {
    Client pricefxClient = getPricefxClient();
    record {} payload = {};
    ListCalculationGridsResponse response = check pricefxClient->listCalculationGrids(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListConditionRecordSets() returns error? {
    Client pricefxClient = getPricefxClient();
    record {} payload = {};
    ListConditionRecordSetsEnvelope response = check pricefxClient->listConditionRecordSets(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListManualPriceLists() returns error? {
    Client pricefxClient = getPricefxClient();
    ListManualPriceListsRequest payload = {};
    manualpricelistResponse response = check pricefxClient->listManualPriceLists(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListPriceLists() returns error? {
    Client pricefxClient = getPricefxClient();
    ListPriceListsRequest payload = {};
    ListPriceListsResponse response = check pricefxClient->listPriceLists(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    GetPriceListResponse response = check pricefxClient->getPriceList("9001");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreatePriceList() returns error? {
    Client pricefxClient = getPricefxClient();
    CreatePriceListRequest payload = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    CreatePriceListResponse response = check pricefxClient->createPriceList(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListProducts() returns error? {
    Client pricefxClient = getPricefxClient();
    ListProductsRequest payload = {};
    productResponse response = check pricefxClient->listProducts(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetQuote() returns error? {
    Client pricefxClient = getPricefxClient();
    quoteResponse response = check pricefxClient->getQuote("10001.QU");
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListQuotes() returns error? {
    Client pricefxClient = getPricefxClient();
    ListQuotesRequest payload = {};
    ListQuotesResponse response = check pricefxClient->listQuotes(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertQuote() returns error? {
    Client pricefxClient = getPricefxClient();
    QuotemanagersaveDataQuote quote = {
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
    UpsertQuoteRequest payload = {data: {quote: quote}};
    quoteResponse response = check pricefxClient->upsertQuote(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListSellers() returns error? {
    Client pricefxClient = getPricefxClient();
    ListSellersRequest payload = {};
    ListSellersEnvelope response = check pricefxClient->listSellers(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateAuthToken() returns error? {
    Client pricefxClient = getPricefxClient();
    CreateAuthTokenHeaders headers = {pricefxKey};
    GetAuthenticationTokenAPIv2Request payload = {password, partition, username};
    tokenResponse response = check pricefxClient->createAuthToken(headers, payload);
    test:assertTrue(response.access\-token.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateCustomer() returns error? {
    Client pricefxClient = getPricefxClient();
    UpdateCustomerRequest payload = {
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
    customerResponse response = check pricefxClient->updateCustomer(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateProduct() returns error? {
    Client pricefxClient = getPricefxClient();
    UpdateProductRequest payload = {
        data: {typedId: "3001.P", label: "Wireless Mouse Pro"},
        oldValues: {typedId: "3001.P", version: 1}
    };
    productResponse response = check pricefxClient->updateProduct(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateUploadSlot() returns error? {
    Client pricefxClient = getPricefxClient();
    CreateUploadSlotEnvelope response = check pricefxClient->createUploadSlot();
    test:assertTrue(response?.response !is ());
}
