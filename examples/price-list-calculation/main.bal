// Create a new price list, run its calculation, then fetch the calculated price list.

import ballerina/io;
import ballerinax/pricefx;

configurable string token = ?;
configurable string serviceUrl = ?;

public function main() returns error? {
    pricefx:Client pricefxClient = check new ({auth: {xPriceFxJwt: token}}, serviceUrl = serviceUrl);

    // Step 1: Create a new price list
    pricefx:CreatePriceListRequest createRequest = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    pricefx:CreatePriceListResponse createResult = check pricefxClient->/pricelistmanager\.add.post(createRequest);
    io:println("Created price list: ", createResult);

    // Step 2: Calculate the price list
    pricefx:PricelistmanagerCalculateidBody calculateRequest = {data: {fullListRecalc: true}};
    pricefx:CalculatePricelistResponse calculateResult =
        check pricefxClient->/pricelistmanager\.calculate/["9001"].post(calculateRequest);
    io:println("Calculation triggered: ", calculateResult);

    // Step 3: Fetch the calculated price list
    pricefx:GetPriceListResponse getResult = check pricefxClient->/fetch/PL/["9001"].post();
    io:println("Price list details: ", getResult);
}
