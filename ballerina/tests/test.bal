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
final string token = isLiveServer ? os:getEnv("PRICEFX_TOKEN") : "test_token";

// Constraint validation is disabled here only for the mock/live smoke-test client: several
// Pricefx request schemas mark large nested arrays as non-empty (`minLength: 1`), and populating
// full business-realistic graphs (e.g. a Quote's line items) just to satisfy runtime validation
// adds no value to these wire-format tests. Real usage should leave validation at its default (true).
final Client pricefxClient = check new ({auth: {xPriceFxJwt: token}, validation: false}, serviceUrl = serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testLogin() returns error? {
    UserLoginResponse response = check pricefxClient->/login/extended();
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCustomer() returns error? {
    AddCustomerRequest payload = {
        data: {customerId: "CUST-2001", name: "Test Customer"},
        operation: "add"
    };
    customerResponse response = check pricefxClient->/add/C.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddConditionRecordSet() returns error? {
    AddCRCSBody payload = {
        data: {uniqueName: "test-crcs", keySize: 12, label: "Test Condition Record Set"},
        operation: "add"
    };
    ConditionRecordSetOperationEnvelope response = check pricefxClient->/add/CRCS.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateManualPriceList() returns error? {
    CreateManualPriceListRequest payload = {
        textMatchStyle: "exact",
        data: {uniqueName: "q1-2026-promo", label: "Q1 2026 Promo Price List", validAfter: "2026-01-01", status: "ACTIVE"},
        operationType: "add"
    };
    manualpricelistResponse response = check pricefxClient->/add/MPL.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddProduct() returns error? {
    AddProductRequest payload = {
        data: {sku: "SKU-9001", label: "Test Product"},
        operation: "add"
    };
    productResponse response = check pricefxClient->/add/P.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddSeller() returns error? {
    AddSellerRequest payload = {
        data: {sellerId: "SL-9001", name: "Test Seller"},
        operation: "add"
    };
    AddSellerEnvelope response = check pricefxClient->/add/SL.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListFiles() returns error? {
    BdmanagerListtypedIdBody payload = {};
    ListFilesEnvelope response = check pricefxClient->/bdmanager\.list/["1001.C"].post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testAddCalculationGrid() returns error? {
    AddCalculationGridRequest payload = {
        data: {configuration: "Standard Discount Grid", label: "Standard Discount Grid", keyGenerationType: "MANUAL"}
    };
    AddCalculationGridResponse response = check pricefxClient->/calculationgridmanager\.addgrid.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCalculateCalculationGrid() returns error? {
    CalculateCalculationGridRequest payload = {};
    CalculateCalculationGridResponse response = check pricefxClient->/calculationgridmanager\.calculate/["6001"].post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetContract() returns error? {
    contractModelResponse response = check pricefxClient->/contractmanager\.fetch/["acme-master-agreement"].post();
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertContract() returns error? {
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
    contractModelResponse response = check pricefxClient->/contractmanager\.save.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCustomers() returns error? {
    ListCustomersRequest payload = {};
    customerResponse response = check pricefxClient->/customermanager\.fetchformulafilteredcustomers.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteCustomer() returns error? {
    DeleteCustomerRequest payload = {data: {typedId: "1001.C"}};
    DeleteCustomerResponse response = check pricefxClient->/delete/C.post(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteConditionRecordSet() returns error? {
    DcrmanagerDeletemassopidBody payload = {data: {typedId: "500.CRCS"}};
    ConditionRecordSetOperationEnvelope response = check pricefxClient->/delete/CRCS.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testDeleteProduct() returns error? {
    DeleteProductRequest payload = {data: {typedId: "3001.P"}};
    DeleteProductResponse response = check pricefxClient->/delete/P.post(payload);
    test:assertTrue(response.response.data.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListCalculationGrids() returns error? {
    record {} payload = {};
    ListCalculationGridsResponse response = check pricefxClient->/fetch/CG.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListConditionRecordSets() returns error? {
    record {} payload = {};
    ListConditionRecordSetsEnvelope response = check pricefxClient->/fetch/CRCS.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListManualPriceLists() returns error? {
    ListManualPriceListsRequest payload = {};
    manualpricelistResponse response = check pricefxClient->/fetch/MPL.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListPriceLists() returns error? {
    ListPriceListsRequest payload = {};
    ListPriceListsResponse response = check pricefxClient->/fetch/PL.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPriceList() returns error? {
    GetPriceListResponse response = check pricefxClient->/fetch/PL/["9001"].post();
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreatePriceList() returns error? {
    CreatePriceListRequest payload = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    CreatePriceListResponse response = check pricefxClient->/pricelistmanager\.add.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListProducts() returns error? {
    ListProductsRequest payload = {};
    productResponse response = check pricefxClient->/productmanager\.fetchformulafilteredproducts.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetQuote() returns error? {
    quoteResponse response = check pricefxClient->/quotemanager\.fetch/["10001.QU"].post();
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListQuotes() returns error? {
    ListQuotesRequest payload = {};
    ListQuotesResponse response = check pricefxClient->/quotemanager\.fetchlist.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpsertQuote() returns error? {
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
    quoteResponse response = check pricefxClient->/quotemanager\.save.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListSellers() returns error? {
    ListSellersRequest payload = {};
    ListSellersEnvelope response = check pricefxClient->/sellermanager\.fetchformulafilteredsellers.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateAuthToken() returns error? {
    CreateAuthTokenHeaders headers = {pricefxKey: "test-pricefx-key"};
    GetAuthenticationTokenAPIv2Request payload = {password: "test-pass", partition: "companypartition", username: "test-user"};
    tokenResponse response = check pricefxClient->/token.post(headers, payload);
    test:assertTrue(response.access\-token.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateCustomer() returns error? {
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
    customerResponse response = check pricefxClient->/update/C.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUpdateProduct() returns error? {
    UpdateProductRequest payload = {
        data: {typedId: "3001.P", label: "Wireless Mouse Pro"},
        oldValues: {typedId: "3001.P", version: 1}
    };
    productResponse response = check pricefxClient->/update/P.post(payload);
    test:assertTrue(response?.response !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateUploadSlot() returns error? {
    CreateUploadSlotEnvelope response = check pricefxClient->/uploadmanager\.newuploadslot.post();
    test:assertTrue(response?.response !is ());
}
