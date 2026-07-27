// Create a new price list, run its calculation, then fetch the calculated price list.

import ballerina/io;
import ballerinax/pricefx;

configurable string username = ?;
configurable string password = ?;
configurable string partition = ?;
configurable string pricefxKey = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {username, password, partition, pricefxKey}}, serviceUrl);

    // Step 1: Create a new price list
    pricefx:CreatePriceListRequest createRequest = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    pricefx:CreatePriceListResponse createResult = check pricefxClient->createPriceList(createRequest);
    io:println("Created price list: ", createResult);

    // Step 2: Calculate the price list
    pricefx:PricelistmanagerCalculateidBody calculateRequest = {data: {fullListRecalc: true}};
    pricefx:CalculatePricelistResponse calculateResult = check pricefxClient->calculatePriceList("9001", calculateRequest);
    io:println("Calculation triggered: ", calculateResult);

    // Step 3: Fetch the calculated price list
    pricefx:GetPriceListResponse getResult = check pricefxClient->getPriceList("9001");
    io:println("Price list details: ", getResult);
}
