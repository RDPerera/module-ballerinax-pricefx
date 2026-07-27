// Create a new price list, run its calculation, then fetch the calculated price list.

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

    // Step 1: Create a new price list
    pricefx:CreatePriceListRequest createRequest = {
        data: {targetDate: "2026-01-15", errorMode: "STOP", priceListName: "Standard 2026 Price List"}
    };
    pricefx:CreatePriceListResponse createResult = check pricefxClient->createPriceList(createRequest);
    io:println("Created price list: ", createResult);

    // The calculate/get endpoints take the price list's plain `id` - the `typedId` Pricefx assigned
    // it, without the trailing ".PL" suffix.
    pricefx:CreatePriceListResponseResponseData[] priceLists = createResult.response?.data ?: [];
    if priceLists.length() == 0 {
        return error("Pricefx did not return a price list id");
    }
    string typedId = priceLists[0].typedId ?: "";
    string id = typedId.substring(0, typedId.indexOf(".") ?: typedId.length());

    // Step 2: Calculate the price list
    pricefx:PricelistmanagerCalculateidBody calculateRequest = {data: {fullListRecalc: true}};
    pricefx:CalculatePricelistResponse calculateResult = check pricefxClient->calculatePriceList(id, calculateRequest);
    io:println("Calculation triggered: ", calculateResult);

    // Step 3: Fetch the calculated price list
    pricefx:GetPriceListResponse getResult = check pricefxClient->getPriceList(id);
    io:println("Price list details: ", getResult);
}
