// Add a new product to the catalog, update one of its fields, then list matching products to confirm the change.

import ballerina/io;
import ballerinax/pricefx;

configurable string username = ?;
configurable string password = ?;
configurable string partition = ?;
configurable string serviceUrl = ?;

// `pricefx:ProductResponse.response` is untyped (`anydata`) in the OpenAPI spec, so a locally
// declared shape is used to safely read the fields this example needs out of it.
type ProductRecord record {
    string typedId;
    decimal version;
};

type ProductResponseData record {
    ProductRecord data;
};

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {username, password, partition}}, serviceUrl);

    // Step 1: Add a new product
    pricefx:AddProductRequest addRequest = {
        data: {sku: "SKU-1001", label: "Wireless Mouse", unitOfMeasure: "EA"},
        operation: "add"
    };
    pricefx:ProductResponse addResult = check pricefxClient->addProduct(addRequest);
    io:println("Added product: ", addResult);

    // Step 2: Update the newly created product's label, using the typedId and version Pricefx
    // assigned to it rather than a fabricated identifier.
    anydata addResponseAny = addResult?.response ?: {};
    ProductResponseData addResponseData = check addResponseAny.cloneWithType();
    pricefx:UpdateProductRequest updateRequest = {
        data: {typedId: addResponseData.data.typedId, label: "Wireless Mouse Pro"},
        oldValues: {typedId: addResponseData.data.typedId, version: addResponseData.data.version}
    };
    pricefx:ProductResponse updateResult = check pricefxClient->updateProduct(updateRequest);
    io:println("Updated product: ", updateResult);

    // Step 3: List products to confirm the change
    pricefx:ListProductsRequest listRequest = {};
    pricefx:ProductResponse listResult = check pricefxClient->listProducts(listRequest);
    io:println("Product list: ", listResult);
}
