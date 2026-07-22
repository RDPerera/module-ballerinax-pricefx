// Add a new customer, create a quote for them, then submit the quote for approval.

import ballerina/io;
import ballerinax/pricefx;

configurable string token = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {xPriceFxJwt: token}}, serviceUrl = serviceUrl);

    // Step 1: Add a new customer
    pricefx:AddCustomerRequest customerRequest = {
        data: {customerId: "CUST-2001", name: "Acme Corp"},
        operation: "add"
    };
    pricefx:customerResponse customerResult = check pricefxClient->/add/C.post(customerRequest);
    io:println("Added customer: ", customerResult);

    // Step 2: Create a quote for the new customer
    pricefx:QuotemanagersaveDataQuote quote = {
        outputs: [],
        createdByName: "Jane Doe",
        typedId: "10001.QU",
        headerText: "Acme Q1 Renewal Quote",
        workflowStatus: "DRAFT",
        inputs: [],
        lastUpdateDate: "2026-01-15T10:00:00Z",
        lineItems: [],
        rootUniqueName: "q-2026-001",
        targetDate: "2026-01-15",
        version: 1,
        uniqueName: "q-2026-001",
        hasWorkflowHistory: false,
        status: "DRAFT",
        lastUpdateByName: "Jane Doe",
        quoteStatus: "OPEN",
        expiryDate: "2026-03-15",
        customerId: "CUST-2001",
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
    pricefx:UpsertQuoteRequest quoteRequest = {data: {quote: quote}};
    pricefx:quoteResponse quoteResult = check pricefxClient->/quotemanager\.save.post(quoteRequest);
    io:println("Created quote: ", quoteResult);

    // Step 3: Submit the quote for approval
    // Note: `inputs` must contain at least one entry matching the quote's configured
    // input schema in a real Pricefx instance — left empty here for illustration.
    pricefx:SubmitQuoteRequest submitRequest = {
        data: {
            quote: {typedId: "q-2026-001.QU", uniqueName: "q-2026-001", inputs: []}
        }
    };
    pricefx:quoteResponse submitResult = check pricefxClient->/quotemanager\.submit.post(submitRequest);
    io:println("Submitted quote: ", submitResult);
}
