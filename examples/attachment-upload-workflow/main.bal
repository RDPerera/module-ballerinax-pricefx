// Create an upload slot for a customer record, upload a file to it, then list the customer's files.

import ballerina/io;
import ballerinax/pricefx;

configurable string username = ?;
configurable string password = ?;
configurable string partition = ?;
configurable string? pricefxKey = ();
configurable string serviceUrl = ?;

public function main() returns error? {
    // `pricefxKey` is optional: when set, the connector authenticates via the faster `POST /token`;
    // otherwise it falls back to `GET /login/extended` (HTTP Basic auth).
    pricefx:PricefxCredentials auth = {username, password, partition};
    if pricefxKey is string {
        auth.pricefxKey = pricefxKey;
    }
    pricefx:Client pricefxClient = check new ({auth}, serviceUrl);

    // Step 1: Create an upload slot for the customer record
    pricefx:CreateUploadSlotEnvelope slotResult = check pricefxClient->createUploadSlot(ownerTypedId = "CUST-2001.C");
    io:println("Created upload slot: ", slotResult);

    // Step 2: Upload a file to the slot Pricefx just created, rather than a hard-coded slot id
    pricefx:InlineResponse200ResponseData[] slots = slotResult.response?.data ?: [];
    if slots.length() == 0 {
        return error("Pricefx did not return an upload slot id");
    }
    string slotId = slots[0].id ?: "";
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
