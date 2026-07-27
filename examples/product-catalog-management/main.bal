// Add a new product to the catalog, update one of its fields, then list matching products to confirm the change.

import ballerina/io;
import ballerinax/pricefx;

configurable string username = ?;
configurable string password = ?;
configurable string partition = ?;
configurable string pricefxKey = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {username, password, partition, pricefxKey}}, serviceUrl);

    // Step 1: Add a new product
    pricefx:AddProductRequest addRequest = {
        data: {sku: "SKU-1001", label: "Wireless Mouse", unitOfMeasure: "EA"},
        operation: "add"
    };
    pricefx:productResponse addResult = check pricefxClient->addProduct(addRequest);
    io:println("Added product: ", addResult);

    // Step 2: Update the product's label
    pricefx:UpdateProductRequest updateRequest = {
        data: {typedId: "SKU-1001.P", label: "Wireless Mouse Pro"},
        oldValues: {typedId: "SKU-1001.P", version: 1}
    };
    pricefx:productResponse updateResult = check pricefxClient->updateProduct(updateRequest);
    io:println("Updated product: ", updateResult);

    // Step 3: List products to confirm the change
    pricefx:ListProductsRequest listRequest = {};
    pricefx:productResponse listResult = check pricefxClient->listProducts(listRequest);
    io:println("Product list: ", listResult);
}
