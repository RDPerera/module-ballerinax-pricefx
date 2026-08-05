// Create an upload slot for a customer record, upload a file to it, then list the customer's files.

import ballerina/io;
import ballerinax/pricefx;

configurable string username = ?;
configurable string password = ?;
configurable string partition = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {username, password, partition}}, serviceUrl);

    // Step 1: Create an upload slot for the customer record
    pricefx:CreateUploadSlotEnvelope slotResult = check pricefxClient->createUploadSlot(ownerTypedId = "CUST-2001.C");
    io:println("Created upload slot: ", slotResult);

    // Step 2: Upload a file to the slot Pricefx just created, rather than a hard-coded slot id
    pricefx:InlineResponse200ResponseData[] slots = slotResult.response?.data ?: [];
    if slots.length() == 0 {
        return error("Pricefx returned no upload slot");
    }
    // Coalescing a missing id to "" would send an invalid slot to `uploadFile`, so fail here
    // instead - a malformed response should not become a malformed request.
    string? slotId = slots[0].id;
    if slotId is () || slotId.trim() == "" {
        return error("Pricefx returned an upload slot without an id");
    }
    pricefx:TypedIdslotIdBody uploadRequest = {
        file: {fileContent: "Sample contract text".toBytes(), fileName: "contract.txt"}
    };
    pricefx:FileOperationEnvelope uploadResult = check pricefxClient->uploadFile("CUST-2001.C", slotId, uploadRequest);
    io:println("Uploaded file: ", uploadResult);

    // Step 3: List files attached to the customer record
    pricefx:BdmanagerListtypedIdBody listRequest = {};
    pricefx:ListFilesEnvelope listResult = check pricefxClient->listFiles("CUST-2001.C", listRequest);
    io:println("Customer files: ", listResult);
}
