// Create an upload slot for a customer record, upload a file to it, then list the customer's files.

import ballerina/io;
import ballerinax/pricefx;

configurable string token = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {xPriceFxJwt: token}}, serviceUrl = serviceUrl);

    // Step 1: Create an upload slot for the customer record
    pricefx:CreateUploadSlotEnvelope slotResult =
        check pricefxClient->/uploadmanager\.newuploadslot.post(ownerTypedId = "CUST-2001.C");
    io:println("Created upload slot: ", slotResult);

    // Step 2: Upload a file to the slot
    pricefx:TypedIdslotIdBody uploadRequest = {
        file: {fileContent: "Sample contract text".toBytes(), fileName: "contract.txt"}
    };
    pricefx:FileOperationEnvelope uploadResult =
        check pricefxClient->/bdmanager\.upload/["CUST-2001.C"]/["slot-001"].post(uploadRequest);
    io:println("Uploaded file: ", uploadResult);

    // Step 3: List files attached to the customer record
    pricefx:BdmanagerListtypedIdBody listRequest = {};
    pricefx:ListFilesEnvelope listResult = check pricefxClient->/bdmanager\.list/["CUST-2001.C"].post(listRequest);
    io:println("Customer files: ", listResult);
}
