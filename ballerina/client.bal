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

import ballerina/http;
import ballerinax/pricefx.oas;

# The cookie Pricefx sets on a Basic authenticated response, carrying the session token.
const string JWT_COOKIE_PREFIX = "X-PriceFx-jwt=";

# Holds the current `oas:Client`, guarding the swap that happens on re-authentication.
#
# This exists as a separate class purely to keep the `lock` statement out of `Client`. `Client`
# carries 477 remote methods, which is large enough that the compiler splits it across several JVM
# classes (`$Client$split$N`), and on Swan Lake Update 13.x a `lock` inside a split class generates
# invalid bytecode - the JVM rejects it at run time with `VerifyError: Bad type on operand stack`.
# Update 12 compiles the same code correctly, so this is a toolchain bug rather than invalid
# Ballerina, but the connector has to work on current releases. Keeping the lock in this small
# class - which is never split - avoids it entirely, and lets every field on `Client` be `final`.
isolated class OasClientHolder {
    private oas:Client current;

    # Gets invoked to initialize the holder with the client to start from.
    #
    # + initial - The initially authenticated `oas:Client`
    isolated function init(oas:Client initial) {
        self.current = initial;
    }

    # Returns the client currently in use.
    #
    # + return - The current `oas:Client`
    isolated function get() returns oas:Client {
        lock {
            return self.current;
        }
    }

    # Replaces the client currently in use, after a successful re-authentication.
    #
    # + replacement - The freshly authenticated `oas:Client` to switch to
    isolated function set(oas:Client replacement) {
        lock {
            self.current = replacement;
        }
    }
}

# The `ballerinax/pricefx` client. Wraps the generated `oas` client - kept as pristine,
# regeneratable code in the `oas` submodule - and adds the two things Pricefx's API needs that a
# generated client cannot provide: turning `PricefxCredentials` into the right kind of HTTP auth,
# and transparently re-authenticating and replaying a request once when it comes back
# unauthenticated. Session tokens and OAuth2 access tokens are short-lived, so that retry is what
# lets a long-lived client instance keep working without manual re-initialization.
public isolated client class Client {
    private final OasClientHolder holder;
    private final readonly & PricefxCredentials auth;
    private final readonly & ConnectionConfig config;
    private final string serviceUrl;

    # Gets invoked to initialize the `connector`.
    #
    # + auth - The credentials to authenticate with. See `PricefxCredentials` for the options
    # + serviceUrl - URL of the target service
    # + config - HTTP transport settings. The defaults are fine for most callers
    # + return - An error if connector initialization, or authentication, failed
    public isolated function init(PricefxCredentials auth, string serviceUrl = "https://companynode.pricefx.com/pricefx/companypartition", ConnectionConfig config = {}) returns error? {
        self.auth = auth.cloneReadOnly();
        self.config = config.cloneReadOnly();
        self.serviceUrl = serviceUrl;
        self.holder = new (check createOasClient(self.auth, self.config, serviceUrl));
    }

    # Returns the current underlying `oas` client instance in a manner that is safe to call
    # from within an `isolated` object.
    #
    # + return - The current `oas:Client` instance
    private isolated function getOasClient() returns oas:Client {
        return self.holder.get();
    }

    # Re-authenticates against Pricefx and replaces the underlying `oas` client instance with a
    # freshly authenticated one. The generated `oas:Client`'s fields are `final`, so a session
    # refresh is done by constructing a brand-new instance rather than mutating the existing one.
    #
    # + return - An error if re-authentication failed
    private isolated function reauthenticate() returns error? {
        self.holder.set(check createOasClient(self.auth, self.config, self.serviceUrl));
    }

    # Submit a Calculation Grid Item
    #
    # + id - The `id` of the Calculation Grid you want to submit items for. You can retrieve the `id` of the CG, for example, by calling the `/fetch/CG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function acceptCalculationGridItem(string id, oas:SubmitCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns oas:SubmitCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitCalculationGridItemResponse|error r = oasClient->acceptCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->acceptCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Add an Action Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addActionType(oas:AddActionTypeRequest payload, map<string|string[]> headers = {}) returns oas:AddActionTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddActionTypeResponse|error r = oasClient->addActionType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addActionType(payload, headers);
        }
        return r;
    }

    # Add an Approver Step
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addApproverStep(string currentStepId, oas:AddApproverStepRequest payload, map<string|string[]> headers = {}) returns oas:AddApproverStepResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddApproverStepResponse|error r = oasClient->addApproverStep(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addApproverStep(currentStepId, payload, headers);
        }
        return r;
    }

    # Add a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addCalculation(oas:AddCalculationRequest payload, map<string|string[]> headers = {}) returns oas:AddCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddCalculationResponse|error r = oasClient->addCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addCalculation(payload, headers);
        }
        return r;
    }

    # Add a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addCalculationGrid(oas:AddCalculationGridRequest payload, map<string|string[]> headers = {}) returns oas:AddCalculationGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddCalculationGridResponse|error r = oasClient->addCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addCalculationGrid(payload, headers);
        }
        return r;
    }

    # Add a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, oas:AddCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns oas:AddCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddCalculationGridItemResponse|error r = oasClient->addCalculationGridItem(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addCalculationGridItem(keyNumber, payload, headers);
        }
        return r;
    }

    # Add a Claim
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addClaim(oas:AddClaimRequest payload, map<string|string[]> headers = {}) returns oas:AddClaimResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddClaimResponse|error r = oasClient->addClaim(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addClaim(payload, headers);
        }
        return r;
    }

    # Add a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addClaimType(oas:AddClaimTypeRequest payload, map<string|string[]> headers = {}) returns oas:AddClaimTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddClaimTypeResponse|error r = oasClient->addClaimType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addClaimType(payload, headers);
        }
        return r;
    }

    # Add a Comment
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addComment(oas:CommentmanagerAddBody payload, map<string|string[]> headers = {}) returns oas:CommentOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CommentOperationEnvelope|error r = oasClient->addComment(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addComment(payload, headers);
        }
        return r;
    }

    # Add a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addCompensationType(oas:AddCompensationTypeRequest payload, map<string|string[]> headers = {}) returns oas:AddCompensationTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddCompensationTypeEnvelope|error r = oasClient->addCompensationType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addCompensationType(payload, headers);
        }
        return r;
    }

    # Add a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addConditionRecordItemMeta(oas:AddCRCIMBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordItemMetaOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordItemMetaOperationEnvelope|error r = oasClient->addConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Add a Condition Record Set
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addConditionRecordSet(oas:AddCRCSBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordSetOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordSetOperationEnvelope|error r = oasClient->addConditionRecordSet(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addConditionRecordSet(payload, headers);
        }
        return r;
    }

    # Add a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function addConditionType(oas:AddConditionTypeRequest payload, map<string|string[]> headers = {}) returns oas:AddConditionTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddConditionTypeEnvelope|error r = oasClient->addConditionType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addConditionType(payload, headers);
        }
        return r;
    }

    # Add a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addConfigurationStorage(oas:AddJCSBody payload, map<string|string[]> headers = {}) returns oas:ConfigurationStorageOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConfigurationStorageOperationEnvelope|error r = oasClient->addConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Add Contract Line Items
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function addContractLineItems(oas:AddContractLineItemsRequest payload, map<string|string[]> headers = {}) returns oas:ContractModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ContractModelResponse|error r = oasClient->addContractLineItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addContractLineItems(payload, headers);
        }
        return r;
    }

    # Add a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns customer record details 
    remote isolated function addCustomer(oas:AddCustomerRequest payload, map<string|string[]> headers = {}) returns oas:CustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomerResponse|error r = oasClient->addCustomer(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addCustomer(payload, headers);
        }
        return r;
    }

    # Add a Data Change Request
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addDataChangeRequest(oas:AddDCRRequest payload, map<string|string[]> headers = {}) returns oas:AddDCRResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddDCRResponse|error r = oasClient->addDataChangeRequest(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addDataChangeRequest(payload, headers);
        }
        return r;
    }

    # Add a Data Change Request Item
    #
    # + id - `id` of the Data Change Request you want to add the Data Change Request Item to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addDataChangeRequestItem(string id, oas:AddDCRIRequest payload, map<string|string[]> headers = {}) returns oas:AddDCRIResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddDCRIResponse|error r = oasClient->addDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Add Line Items
    #
    # + typedId - typed ID of the target CLIC document 
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addLineItems(string typedId, oas:ClicmanagerAdditemstypedIdBody payload, map<string|string[]> headers = {}) returns record {}|error {
        oas:Client oasClient = self.getOasClient();
        record {}|error r = oasClient->addLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Add a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addLivePriceGridType(oas:AddPGTTBody payload, map<string|string[]> headers = {}) returns oas:LivePriceGridTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:LivePriceGridTypeOperationEnvelope|error r = oasClient->addLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Add a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload - The request must contain all fields that are part of the business key for that object and all non-nullable fields 
    # + return - OK 
    remote isolated function addLookupTable(oas:AddLookupTableRequest payload, map<string|string[]> headers = {}) returns oas:AddLookupTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddLookupTableResponse|error r = oasClient->addLookupTable(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addLookupTable(payload, headers);
        }
        return r;
    }

    # Add a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addLookupTableValue(string tableId, oas:AddLookupTableValueRequest payload, map<string|string[]> headers = {}) returns oas:AddLookupTableValueResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddLookupTableValueResponse|error r = oasClient->addLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Add Products to a Manual Pricelist
    #
    # + id - The ID of the Manual Price List where you want to add products to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function addManualPriceListProducts(string id, oas:AddProductsToManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->addManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # Add Products to a Manual Price List (No Recalculation)
    #
    # + id - The ID of the Manual Price List where you want to add products to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addManualPriceListProductsNoRecalc(string id, oas:AddProductsToManualPriceListNoRecalcRequest payload, map<string|string[]> headers = {}) returns oas:AddProductsToManualPriceListNoRecalcResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddProductsToManualPriceListNoRecalcResponse|error r = oasClient->addManualPriceListProductsNoRecalc(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addManualPriceListProductsNoRecalc(id, payload, headers);
        }
        return r;
    }

    # Add a New Internationalization Message
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Created - the new internationalization messages have been added 
    remote isolated function addNewInternationalizationMessage(oas:I18nmanagerPutBody payload, map<string|string[]> headers = {}) returns oas:AddInternationalizationMessageEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddInternationalizationMessageEnvelope|error r = oasClient->addNewInternationalizationMessage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addNewInternationalizationMessage(payload, headers);
        }
        return r;
    }

    # Add Price Grid Items to a Price Grid
    #
    # + id - The ID of the Live Price Grid where you want to add Price Grid Items to. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addPriceGridItemsToPriceGrid(string id, oas:AddPriceGridItemsRequest payload, map<string|string[]> headers = {}) returns oas:AddPriceGridItemsToPriceGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddPriceGridItemsToPriceGridResponse|error r = oasClient->addPriceGridItemsToPriceGrid(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addPriceGridItemsToPriceGrid(id, payload, headers);
        }
        return r;
    }

    # Add a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function addPriceListType(oas:AddPLTTBody payload, map<string|string[]> headers = {}) returns oas:PriceListTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListTypeOperationEnvelope|error r = oasClient->addPriceListType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addPriceListType(payload, headers);
        }
        return r;
    }

    # Add a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns full record details 
    remote isolated function addProduct(oas:AddProductRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->addProduct(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addProduct(payload, headers);
        }
        return r;
    }

    # Add Products to a Quote
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function addQuoteProducts(oas:AddProductsToQuoteRequest payload, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->addQuoteProducts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addQuoteProducts(payload, headers);
        }
        return r;
    }

    # Add Rebate Agreement Items
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function addRebateAgreementItems(oas:GetCustomerRequest payload, map<string|string[]> headers = {}) returns oas:RebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RebateAgreementResponse|error r = oasClient->addRebateAgreementItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addRebateAgreementItems(payload, headers);
        }
        return r;
    }

    # Add a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addRebateCalculation(oas:AddRRSCBody payload, map<string|string[]> headers = {}) returns oas:AddRebateCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddRebateCalculationResponse|error r = oasClient->addRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addRebateCalculation(payload, headers);
        }
        return r;
    }

    # Add a Seller
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addSeller(oas:AddSellerRequest payload, map<string|string[]> headers = {}) returns oas:AddSellerEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddSellerEnvelope|error r = oasClient->addSeller(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addSeller(payload, headers);
        }
        return r;
    }

    # Add a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addSellerExtension(oas:AddSellerExtensionRequest payload, map<string|string[]> headers = {}) returns oas:AddSellerExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddSellerExtensionResponse|error r = oasClient->addSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addSellerExtension(payload, headers);
        }
        return r;
    }

    # Add a User
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function addUser(oas:AddUserRequest payload, map<string|string[]> headers = {}) returns oas:UserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UserResponse|error r = oasClient->addUser(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addUser(payload, headers);
        }
        return r;
    }

    # Add a Watcher Step
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function addWatcherStep(string currentStepId, oas:AddWatcherStepRequest payload, map<string|string[]> headers = {}) returns oas:AddWatcherStepResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddWatcherStepResponse|error r = oasClient->addWatcherStep(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->addWatcherStep(currentStepId, payload, headers);
        }
        return r;
    }

    # Approve a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function approveDocument(string currentStepId, oas:ApproveDocumentRequest payload, map<string|string[]> headers = {}) returns oas:ApproveDocumentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ApproveDocumentResponse|error r = oasClient->approveDocument(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->approveDocument(currentStepId, payload, headers);
        }
        return r;
    }

    # Assign a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignBusinessRole(oas:AssignBusinessRoleRequest payload, map<string|string[]> headers = {}) returns oas:AssignBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignBusinessRoleResponse|error r = oasClient->assignBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Business Role to a User
    #
    # + userId - The ID of the user you want to assign a role to. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignBusinessRoleToUser(string userId, oas:AssignBusinessRoleToUserRequest payload, map<string|string[]> headers = {}) returns oas:AssignBusinessRoleToUserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignBusinessRoleToUserResponse|error r = oasClient->assignBusinessRoleToUser(userId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignBusinessRoleToUser(userId, payload, headers);
        }
        return r;
    }

    # Assign Customers
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function assignCustomers(oas:AssignCustomersRequest payload, map<string|string[]> headers = {}) returns oas:AssignmentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignmentResponse|error r = oasClient->assignCustomers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignCustomers(payload, headers);
        }
        return r;
    }

    # Assign a Group to a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignGroupToBusinessRole(oas:AssignGroupToBusinessRoleRequest payload, map<string|string[]> headers = {}) returns oas:AssignGroupToBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignGroupToBusinessRoleResponse|error r = oasClient->assignGroupToBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignGroupToBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Role to a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignRoleToBusinessRole(oas:AssignRoleToBusinessRoleRequest payload, map<string|string[]> headers = {}) returns oas:AssignRoleToBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignRoleToBusinessRoleResponse|error r = oasClient->assignRoleToBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignRoleToBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Role to a User
    #
    # + userId - The ID of the user you want to assign a role to. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignRoleToUser(string userId, oas:AssignRoleToUserRequest payload, map<string|string[]> headers = {}) returns oas:AssignRoleToUserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignRoleToUserResponse|error r = oasClient->assignRoleToUser(userId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignRoleToUser(userId, payload, headers);
        }
        return r;
    }

    # Assign a Role to Users
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignRoleToUsers(oas:AssignRoleToUsersRequest payload, map<string|string[]> headers = {}) returns oas:AssignRoleToUsersResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignRoleToUsersResponse|error r = oasClient->assignRoleToUsers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignRoleToUsers(payload, headers);
        }
        return r;
    }

    # Assign a User Group to Users
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignUserGroupToUsers(oas:AssignUserGroupToUsersRequest payload, map<string|string[]> headers = {}) returns oas:AssignUserGroupToUsersResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignUserGroupToUsersResponse|error r = oasClient->assignUserGroupToUsers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignUserGroupToUsers(payload, headers);
        }
        return r;
    }

    # Assign a User to a User Group
    #
    # + userId - The ID of the user you want to add to the group. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function assignUserToUserGroup(string userId, oas:AssignUserToUserGroupRequest payload, map<string|string[]> headers = {}) returns oas:AssignUserToUserGroupResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignUserToUserGroupResponse|error r = oasClient->assignUserToUserGroup(userId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->assignUserToUserGroup(userId, payload, headers);
        }
        return r;
    }

    # Insert Bulk Customers
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify customer field names in the `header` object and fields values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function bulkInsertCustomers(oas:InsertBulkCustomersRequest payload, map<string|string[]> headers = {}) returns oas:LoadDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LoadDataResponse|error r = oasClient->bulkInsertCustomers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->bulkInsertCustomers(payload, headers);
        }
        return r;
    }

    # Insert Bulk Products
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify product field names in the `header` object and fields values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function bulkInsertProducts(oas:InsertBulkProductsRequest payload, map<string|string[]> headers = {}) returns oas:LoadDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LoadDataResponse|error r = oasClient->bulkInsertProducts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->bulkInsertProducts(payload, headers);
        }
        return r;
    }

    # Calculate a Calculation Grid
    #
    # + id - `id` of the Calculation Grid you want to calculate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function calculateCalculationGrid(string id, oas:CalculateCalculationGridRequest payload, map<string|string[]> headers = {}) returns oas:CalculateCalculationGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculateCalculationGridResponse|error r = oasClient->calculateCalculationGrid(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateCalculationGrid(id, payload, headers);
        }
        return r;
    }

    # Calculate a CFS
    #
    # + id - The `id` is the `typedId` without the type suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateCfs(string id, map<string|string[]> headers = {}) returns oas:CalculateCFSResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculateCFSResponse|error r = oasClient->calculateCfs(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateCfs(id, headers);
        }
        return r;
    }

    # Calculate a Claim
    #
    # + typedId - The `typedId` of the claim whose items you want to calculate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function calculateClaim(string typedId, oas:CalculateClaimRequest payload, map<string|string[]> headers = {}) returns oas:CalculateClaimResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculateClaimResponse|error r = oasClient->calculateClaim(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateClaim(typedId, payload, headers);
        }
        return r;
    }

    # Calculate a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to start the calculation for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateManualPriceList(string id, map<string|string[]> headers = {}) returns oas:CalculateManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculateManualPriceListResponse|error r = oasClient->calculateManualPriceList(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateManualPriceList(id, headers);
        }
        return r;
    }

    # Calculate a Model Object Step
    #
    # + typedId - The `typedId` of the Model Object you want to recalculate the step for
    # + stepName - Enter the name of the step you want to calculate
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function calculateModelObjectStep(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, map<string|string[]> headers = {}, *oas:CalculateModelObjectStepQueries queries) returns oas:ModelCalculationStepEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ModelCalculationStepEnvelope|error r = oasClient->calculateModelObjectStep(typedId, stepName, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateModelObjectStep(typedId, stepName, headers, queries = queries);
        }
        return r;
    }

    # Calculate a Price Grid
    #
    # + headers - Headers to be sent with the request 
    # + id - The id to be sent with the request
    # + return - OK 
    remote isolated function calculatePriceGrid(string id, map<string|string[]> headers = {}) returns oas:CalculatePriceGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculatePriceGridResponse|error r = oasClient->calculatePriceGrid(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculatePriceGrid(id, headers);
        }
        return r;
    }

    # Calculate a Pricelist
    #
    # + id - The ID of the Price List you want to calculate. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function calculatePriceList(string id, oas:PricelistmanagerCalculateidBody payload, map<string|string[]> headers = {}) returns oas:CalculatePricelistResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculatePricelistResponse|error r = oasClient->calculatePriceList(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculatePriceList(id, payload, headers);
        }
        return r;
    }

    # Calculate a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to calculate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function calculateRebateRecordGroup(string typedId, oas:RebaterecordgroupCalculatetypedIdBody payload, map<string|string[]> headers = {}) returns oas:CalculateRebateRecordGroupEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CalculateRebateRecordGroupEnvelope|error r = oasClient->calculateRebateRecordGroup(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->calculateRebateRecordGroup(typedId, payload, headers);
        }
        return r;
    }

    # Cancel a Calculation Step
    #
    # + typedId - The `typedId` of the Model Object you want to cancel the calculation step for
    # + stepName - The name of the step you want to cancel
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function cancelCalculationStep(string typedId, string stepName, map<string|string[]> headers = {}) returns oas:JobStatusTrackerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:JobStatusTrackerResponse|error r = oasClient->cancelCalculationStep(typedId, stepName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->cancelCalculationStep(typedId, stepName, headers);
        }
        return r;
    }

    # Cancel a CFS Calculation
    #
    # + id - The `id` is the `typedId` without the type suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function cancelCfsCalculation(string id, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->cancelCfsCalculation(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->cancelCfsCalculation(id, headers);
        }
        return r;
    }

    # Cancel a Calculation
    #
    # + typedId - The `typedId` of the claim whose item calculation you want to cancel
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function cancelClaimCalculation(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:CancelClaimCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CancelClaimCalculationResponse|error r = oasClient->cancelClaimCalculation(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->cancelClaimCalculation(typedId, payload, headers);
        }
        return r;
    }

    # Cancel a Job
    #
    # + id - `id` if the job you want to cancel
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function cancelJob(string id, record {} payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->cancelJob(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->cancelJob(id, payload, headers);
        }
        return r;
    }

    # Cancel a Calculation
    #
    # + id - The ID of the Live Price Grid whose running calculation should be cancelled
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function cancelPriceGridCalculation(string id, map<string|string[]> headers = {}) returns oas:CancelCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CancelCalculationResponse|error r = oasClient->cancelPriceGridCalculation(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->cancelPriceGridCalculation(id, headers);
        }
        return r;
    }

    # Change a Current User Password
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function changeCurrentUserPassword(oas:ChangeCurrentUserPasswordRequest payload, map<string|string[]> headers = {}) returns oas:ChangeCurrentUserPasswordResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ChangeCurrentUserPasswordResponse|error r = oasClient->changeCurrentUserPassword(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->changeCurrentUserPassword(payload, headers);
        }
        return r;
    }

    # Change a Custom Form Status
    #
    # + typedId - The `typedId` of the Custom Form whose status you want to change
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function changeCustomFormStatus(string typedId, oas:ChangeCustomFormStatusRequest payload, map<string|string[]> headers = {}) returns oas:ChangeCustomFormStatusResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ChangeCustomFormStatusResponse|error r = oasClient->changeCustomFormStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->changeCustomFormStatus(typedId, payload, headers);
        }
        return r;
    }

    # Change Terms of Use
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - No Content 
    # 
    # # Deprecated
    @deprecated
    remote isolated function changeTermsOfUse(oas:AccountmanagerChangetermsofuseBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->changeTermsOfUse(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->changeTermsOfUse(payload, headers);
        }
        return r;
    }

    # Change a User Password
    #
    # + userId - Enter the ID of the user whose password you want to change. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function changeUserPassword(string userId, oas:ChangeUserPasswordRequest payload, map<string|string[]> headers = {}) returns oas:ChangeUserPasswordResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ChangeUserPasswordResponse|error r = oasClient->changeUserPassword(userId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->changeUserPassword(userId, payload, headers);
        }
        return r;
    }

    # Check a File
    #
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function checkFileExists(string binaryDataId, map<string|string[]> headers = {}) returns oas:CheckFileExistsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CheckFileExistsEnvelope|error r = oasClient->checkFileExists(binaryDataId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->checkFileExists(binaryDataId, headers);
        }
        return r;
    }

    # Convert to a Deal
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function convertQuoteToDeal(string identifier, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->convertQuoteToDeal(identifier, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->convertQuoteToDeal(identifier, headers);
        }
        return r;
    }

    # Convert to Price List
    #
    # + headers - Headers to be sent with the request 
    # + id - The id to be sent with the request
    # + return - OK 
    remote isolated function convertToPriceList(string id, map<string|string[]> headers = {}) returns oas:ConvertPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConvertPriceListResponse|error r = oasClient->convertToPriceList(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->convertToPriceList(id, headers);
        }
        return r;
    }

    # Copy a Logic
    #
    # + id - The ID of the logic. you want to copy. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyLogic(string id, map<string|string[]> headers = {}) returns oas:CopyLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyLogicResponse|error r = oasClient->copyLogic(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyLogic(id, headers);
        }
        return r;
    }

    # Copy a Lookup Table
    #
    # + tableId - Enter the ID of the table you want to copy
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyLookupTable(string tableId, map<string|string[]> headers = {}) returns oas:CopyLookupTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyLookupTableResponse|error r = oasClient->copyLookupTable(tableId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyLookupTable(tableId, headers);
        }
        return r;
    }

    # Copy a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to copy
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function copyManualPriceList(string id, map<string|string[]> headers = {}) returns oas:ManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ManualPriceListResponse|error r = oasClient->copyManualPriceList(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyManualPriceList(id, headers);
        }
        return r;
    }

    # Copy a Price Grid
    #
    # + id - The `id` of the Live Price Grid you want to copy. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyPriceGrid(string id, map<string|string[]> headers = {}) returns oas:CopyPriceGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyPriceGridResponse|error r = oasClient->copyPriceGrid(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyPriceGrid(id, headers);
        }
        return r;
    }

    # Copy a Quote
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function copyQuote(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:CopyQuoteEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyQuoteEnvelope|error r = oasClient->copyQuote(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyQuote(typedId, payload, headers);
        }
        return r;
    }

    # Copy Roles
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function copyRoles(oas:CopyRolesRequest payload, map<string|string[]> headers = {}) returns oas:CopyRolesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyRolesResponse|error r = oasClient->copyRoles(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyRoles(payload, headers);
        }
        return r;
    }

    # Copy a User
    #
    # + userid - The ID of the user you want to copy. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyUser(string userid, map<string|string[]> headers = {}) returns oas:CopyUserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CopyUserResponse|error r = oasClient->copyUser(userid, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->copyUser(userid, headers);
        }
        return r;
    }

    # Count Keys
    #
    # + tableName - The table to count keys from
    # + headers - Headers to be sent with the request 
    # + return - OK - the number of keys 
    remote isolated function countKeys(string tableName, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->countKeys(tableName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->countKeys(tableName, headers);
        }
        return r;
    }

    # Count Mass Action Items
    #
    # + headers - Headers to be sent with the request 
    # + id - The id to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function countMassActionItems(string id, oas:CountMassActionItemsRequest payload, map<string|string[]> headers = {}) returns oas:CountMassActionItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CountMassActionItemsResponse|error r = oasClient->countMassActionItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->countMassActionItems(id, payload, headers);
        }
        return r;
    }

    # Create an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function createActionItem(oas:AddActionItemRequest payload, map<string|string[]> headers = {}) returns oas:AddActionItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AddActionItemResponse|error r = oasClient->createActionItem(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createActionItem(payload, headers);
        }
        return r;
    }

    # Create a Quote
    #
    # + typeCode - Enter the type code of the entity you want to create
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createClic("Q"|"QTMP" typeCode, oas:ClicmanagerCreateTypeCodeBody payload, map<string|string[]> headers = {}) returns oas:ClicOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicOperationEnvelope|error r = oasClient->createClic(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createClic(typeCode, payload, headers);
        }
        return r;
    }

    # Create a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function createCustomForm(oas:CreateCustomFormRequest payload, map<string|string[]> headers = {}) returns oas:CreateCustomFormEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateCustomFormEnvelope|error r = oasClient->createCustomForm(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createCustomForm(payload, headers);
        }
        return r;
    }

    # Create a Custom Form Revision
    #
    # + typedId - `typedId` of the Custom Form you want to create a revision from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createCustomFormRevision(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:CustomFormRevisionEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomFormRevisionEnvelope|error r = oasClient->createCustomFormRevision(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createCustomFormRevision(typedId, payload, headers);
        }
        return r;
    }

    # Create a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createCustomFormType(oas:CreateCustomFormTypeRequest payload, map<string|string[]> headers = {}) returns oas:CreateCustomFormTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateCustomFormTypeResponse|error r = oasClient->createCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createCustomFormType(payload, headers);
        }
        return r;
    }

    # Create a DMFieldCollection
    #
    # + fcType - The type of FC (FieldCollection) you want to create
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createDMFieldCollection("DMDS"|"DMT" fcType, oas:DatamartCreatefcfcTypeBody payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->createDMFieldCollection(fcType, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createDMFieldCollection(fcType, payload, headers);
        }
        return r;
    }

    # Create a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Either `uniqueName` or `typedId` must be provided in the request 
    # + return - Example response 
    remote isolated function createDataManagerEntity("DMF"|"DM"|"DMDS" typeCode, oas:CreateDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns oas:DmObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DmObjectResponse|error r = oasClient->createDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Create a KV Table
    #
    # + tableName - A name of the table you want create. Only lower case letters, numbers and underscores are allowed. Do not use special characters
    # + headers - Headers to be sent with the request 
    # + payload - The sample request creates a table with four columns: sku, customer, record and payload (TEXT).<br> 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function createKvTable(string tableName, oas:CreateKVTableRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->createKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Create a Manual Price List
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function createManualPriceList(oas:CreateManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:ManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ManualPriceListResponse|error r = oasClient->createManualPriceList(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createManualPriceList(payload, headers);
        }
        return r;
    }

    # Create an Object
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createObject(string typeCode, oas:CreateObjectRequest_1 payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->createObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createObject(typeCode, payload, headers);
        }
        return r;
    }

    # Create a Price List
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createPriceList(oas:CreatePriceListRequest payload, map<string|string[]> headers = {}) returns oas:CreatePriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreatePriceListResponse|error r = oasClient->createPriceList(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createPriceList(payload, headers);
        }
        return r;
    }

    # Create a Revision
    #
    # + id - The ID of the Price List you want to create a revision for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function createPriceListRevision(string id, oas:CreateRevisionRequest payload, map<string|string[]> headers = {}) returns oas:PriceListItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListItemResponse|error r = oasClient->createPriceListRevision(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createPriceListRevision(id, payload, headers);
        }
        return r;
    }

    # Create a New Revision
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function createQuoteRevision(string identifier, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->createQuoteRevision(identifier, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createQuoteRevision(identifier, headers);
        }
        return r;
    }

    # 1. Create an Upload Slot
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Slot created 
    remote isolated function createUploadSlot(map<string|string[]> headers = {}, *oas:CreateUploadSlotQueries queries) returns oas:CreateUploadSlotEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateUploadSlotEnvelope|error r = oasClient->createUploadSlot(headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createUploadSlot(headers, queries = queries);
        }
        return r;
    }

    # Create a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function createWorkflowDelegation(oas:CreateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns oas:CreateWorkflowDelegationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateWorkflowDelegationResponse|error r = oasClient->createWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->createWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Deactivate a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deactivateWorkflowDelegation(oas:DeactivateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns oas:DeactivateWorkflowDelegationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeactivateWorkflowDelegationResponse|error r = oasClient->deactivateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deactivateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Delete an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteActionItem(oas:DeleteActionItemRequest payload, map<string|string[]> headers = {}) returns oas:DeleteActionItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteActionItemResponse|error r = oasClient->deleteActionItem(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteActionItem(payload, headers);
        }
        return r;
    }

    # Delete an Action Item Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - The general delete request. Deletes the object specified by `typedId` in the request body 
    # + return - OK 
    remote isolated function deleteActionItemType(record {record {string typedId;} data;} payload, map<string|string[]> headers = {}) returns oas:DeleteActionItemTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteActionItemTypeResponse|error r = oasClient->deleteActionItemType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteActionItemType(payload, headers);
        }
        return r;
    }

    # Delete a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteBusinessRole(oas:DeleteBusinessRoleRequest payload, map<string|string[]> headers = {}) returns oas:DeleteBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteBusinessRoleResponse|error r = oasClient->deleteBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteBusinessRole(payload, headers);
        }
        return r;
    }

    # Delete a Calculated Field Set
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCalculatedFieldSet(oas:DeleteCalculatedFieldSetRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->deleteCalculatedFieldSet(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCalculatedFieldSet(payload, headers);
        }
        return r;
    }

    # Delete a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - returns the deleted object's data 
    remote isolated function deleteCalculation(oas:DeleteCalculationRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCalculationResponse|error r = oasClient->deleteCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCalculation(payload, headers);
        }
        return r;
    }

    # Delete a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCalculationGrid(oas:DeleteCalculationGridRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCalculationGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCalculationGridResponse|error r = oasClient->deleteCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCalculationGrid(payload, headers);
        }
        return r;
    }

    # Delete a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, oas:DeleteCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCalculationGridItemResponse|error r = oasClient->deleteCalculationGridItem(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCalculationGridItem(keyNumber, payload, headers);
        }
        return r;
    }

    # Delete a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteClaimType(oas:DeleteClaimTypeRequest payload, map<string|string[]> headers = {}) returns oas:DeleteClaimTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteClaimTypeResponse|error r = oasClient->deleteClaimType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteClaimType(payload, headers);
        }
        return r;
    }

    # Delete Column Values
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + columnName - The name of the column/attribute you want to remove values from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteColumnValues(string typeCode, string columnName, map<string|string[]> headers = {}) returns oas:DeleteColumnValuesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteColumnValuesResponse|error r = oasClient->deleteColumnValues(typeCode, columnName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteColumnValues(typeCode, columnName, headers);
        }
        return r;
    }

    # Delete Column Values (Matrix only)
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + columnName - Enter the name of the column you want to delete values from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteColumnValuesMatrix(string tableId, string columnName, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->deleteColumnValuesMatrix(tableId, columnName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteColumnValuesMatrix(tableId, columnName, headers);
        }
        return r;
    }

    # Delete a Comment
    #
    # + typedId - Comment or CommentThread typedId
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteComment(string typedId, map<string|string[]> headers = {}) returns oas:DeleteCommentEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCommentEnvelope|error r = oasClient->deleteComment(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteComment(typedId, headers);
        }
        return r;
    }

    # Delete a Compensation Plan
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK. Returns the deleted Compensation Plan object 
    remote isolated function deleteCompensationPlan(oas:DeleteCompensationPlanRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCompensationPlanResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCompensationPlanResponse|error r = oasClient->deleteCompensationPlan(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCompensationPlan(payload, headers);
        }
        return r;
    }

    # Delete a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - returns the deleted object 
    remote isolated function deleteCompensationType(oas:DeleteCOHTBody payload, map<string|string[]> headers = {}) returns oas:DeleteCompensationTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCompensationTypeEnvelope|error r = oasClient->deleteCompensationType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCompensationType(payload, headers);
        }
        return r;
    }

    # Delete a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteConditionRecordItemMeta(oas:DeleteCRCIMBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordItemMetaOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordItemMetaOperationEnvelope|error r = oasClient->deleteConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Delete a Condition Records Set
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteConditionRecordSet(oas:DcrmanagerDeletemassopidBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordSetOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordSetOperationEnvelope|error r = oasClient->deleteConditionRecordSet(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteConditionRecordSet(payload, headers);
        }
        return r;
    }

    # Delete a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteConditionType(oas:DeleteConditionTypeRequest payload, map<string|string[]> headers = {}) returns oas:DeleteConditionTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteConditionTypeEnvelope|error r = oasClient->deleteConditionType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteConditionType(payload, headers);
        }
        return r;
    }

    # Delete a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteConfigurationStorage(record {} payload, map<string|string[]> headers = {}) returns oas:ConfigurationStorageOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConfigurationStorageOperationEnvelope|error r = oasClient->deleteConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Delete a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteCustomForm(oas:DeleteCustomFormRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->deleteCustomForm(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCustomForm(payload, headers);
        }
        return r;
    }

    # Delete a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCustomFormType(oas:DeleteCFOTBody payload, map<string|string[]> headers = {}) returns oas:DeleteCustomFormTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCustomFormTypeEnvelope|error r = oasClient->deleteCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCustomFormType(payload, headers);
        }
        return r;
    }

    # Delete a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCustomer(oas:DeleteCustomerRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCustomerResponse|error r = oasClient->deleteCustomer(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCustomer(payload, headers);
        }
        return r;
    }

    # Delete a Customer Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteCustomerExtension(oas:DeleteCustomerExtensionRequest payload, map<string|string[]> headers = {}) returns oas:DeleteCustomerExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteCustomerExtensionResponse|error r = oasClient->deleteCustomerExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteCustomerExtension(payload, headers);
        }
        return r;
    }

    # Delete a Data Change Request Item
    #
    # + id - `id` of the Data Change Request whose item you want to delete
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteDataChangeRequestItem(string id, oas:DeleteDCRIRequest payload, map<string|string[]> headers = {}) returns oas:DeleteDCRIResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteDCRIResponse|error r = oasClient->deleteDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Delete a Data Change Request Mass Change
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteDataChangeRequestMassChange(string id, oas:DcrmanagerDeletemassopidBody payload, map<string|string[]> headers = {}) returns oas:DataChangeRequestMassChangeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataChangeRequestMassChangeEnvelope|error r = oasClient->deleteDataChangeRequestMassChange(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteDataChangeRequestMassChange(id, payload, headers);
        }
        return r;
    }

    # Delete a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to delete
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteDataManagerEntity("DM"|"DMF"|"DMDS" typeCode, oas:DeleteDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns oas:DeleteDataManagerEntityResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteDataManagerEntityResponse|error r = oasClient->deleteDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Delete Datamart Orphan Objects
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteDatamartOrphanObjects(map<string|string[]> headers = {}) returns oas:DatamartOrphanObjectsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DatamartOrphanObjectsEnvelope|error r = oasClient->deleteDatamartOrphanObjects(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteDatamartOrphanObjects(headers);
        }
        return r;
    }

    # Delete a File
    #
    # + typedId - `typedId` of the document whose attachment you want to delete
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteFile(string typedId, string binaryDataId, record {} payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->deleteFile(typedId, binaryDataId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteFile(typedId, binaryDataId, payload, headers);
        }
        return r;
    }

    # Delete Import Changes
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteImportChanges(oas:ImportmanagerDeletechangesBody payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->deleteImportChanges(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteImportChanges(payload, headers);
        }
        return r;
    }

    # Delete Internationalization Messages
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - the internationalization keys have been deleted successfully 
    remote isolated function deleteInternationalizationMessages(oas:I18nmanagerDeleteKeysBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->deleteInternationalizationMessages(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteInternationalizationMessages(payload, headers);
        }
        return r;
    }

    # Delete a Key
    #
    # + headers - Headers to be sent with the request 
    # + tableName - The tableName to be sent with the request
    # + payload - Request payload
    # + return - OK. Returns `null` when successfully deleted 
    remote isolated function deleteKey(string tableName, oas:DeleteKVKeyRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->deleteKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteKey(tableName, payload, headers);
        }
        return r;
    }

    # Delete a Live Price Grid
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteLivePriceGrid(oas:DeleteLivePriceGridRequest payload, map<string|string[]> headers = {}) returns oas:DeleteLivePriceGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteLivePriceGridResponse|error r = oasClient->deleteLivePriceGrid(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteLivePriceGrid(payload, headers);
        }
        return r;
    }

    # Delete a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deleteLivePriceGridType(oas:DeletePLTTBody payload, map<string|string[]> headers = {}) returns oas:LivePriceGridTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:LivePriceGridTypeOperationEnvelope|error r = oasClient->deleteLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Delete a Logic
    #
    # + id - The ID of the logic you want to delete. `id`  is the `typedId` without **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484835.F** is **2147484835**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteLogic(string id, map<string|string[]> headers = {}) returns oas:DeleteLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteLogicResponse|error r = oasClient->deleteLogic(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteLogic(id, headers);
        }
        return r;
    }

    # Delete a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify the `typedId` of the Lookup Table (Company Parameters) you want to delete 
    # + return - OK 
    remote isolated function deleteLookupTable(oas:DeleteLookupTableRequest payload, map<string|string[]> headers = {}) returns oas:DeleteLookupTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteLookupTableResponse|error r = oasClient->deleteLookupTable(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteLookupTable(payload, headers);
        }
        return r;
    }

    # Delete a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deleteLookupTableValue(string tableId, oas:DeleteLookupTableValueRequest payload, map<string|string[]> headers = {}) returns oas:DeleteLookupTableValueResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteLookupTableValueResponse|error r = oasClient->deleteLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Delete a Manual Price List
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function deleteManualPriceList(oas:DeleteManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:ManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ManualPriceListResponse|error r = oasClient->deleteManualPriceList(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteManualPriceList(payload, headers);
        }
        return r;
    }

    # Delete a Product from a Manual Price List
    #
    # + id - The ID of the Manual Price List whose product you want to delete
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns full record details 
    remote isolated function deleteManualPriceListProduct(string id, oas:DeleteProductFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->deleteManualPriceListProduct(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteManualPriceListProduct(id, payload, headers);
        }
        return r;
    }

    # Delete Products from a Manual Price List
    #
    # + id - The ID of the Manual Price List whose products you want to delete
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteManualPriceListProducts(string id, oas:DeleteProductsFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:DeleteProductsFromManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteProductsFromManualPriceListResponse|error r = oasClient->deleteManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # Delete a Notification
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteNotification(oas:NotificationSetreadBody payload, map<string|string[]> headers = {}) returns oas:DeleteNotificationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteNotificationEnvelope|error r = oasClient->deleteNotification(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteNotification(payload, headers);
        }
        return r;
    }

    # Delete an Object
    #
    # + typeCode - Enter the type code of the entity you want to delete the object from. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteObject("ACTT"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CLLI"|"CN"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DREG"|"DWT"|"ET"|"EVT"|"F"|"FE"|"FN"|"IDC"|"IE"|"ISH"|"JST"|"JLTV"|"JLTVM"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"P"|"PAM"|"PAPIJ"|"PBOME"|"PCOMP"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, oas:DeleteObjectRequest_1 payload, map<string|string[]> headers = {}) returns oas:DeleteObjectResponse_1|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteObjectResponse_1|error r = oasClient->deleteObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteObject(typeCode, payload, headers);
        }
        return r;
    }

    # Delete Objects
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteObjects(string typeCode, oas:DeleteObjectsForceFilterRequest payload, map<string|string[]> headers = {}) returns oas:DeleteObjectsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteObjectsResponse|error r = oasClient->deleteObjects(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteObjects(typeCode, payload, headers);
        }
        return r;
    }

    # Delete a Price Grid Item
    #
    # + id - The ID of the Price Grid you want to delete the Price Grid Item from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function deletePriceGridItem(string id, oas:DeletePriceGridItemRequest payload, map<string|string[]> headers = {}) returns oas:PriceGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceGridItemResponse|error r = oasClient->deletePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deletePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Delete a Price Grid Item (Filter)
    #
    # + id - The ID of the Price Grid that contains Price Grid Items you want to delete
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deletePriceGridItemFilter(string id, oas:DeletePriceGridItemFilterRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->deletePriceGridItemFilter(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deletePriceGridItemFilter(id, payload, headers);
        }
        return r;
    }

    # Delete a Price List
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deletePriceList(oas:DeletePriceListRequest payload, map<string|string[]> headers = {}) returns oas:DeletePriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeletePriceListResponse|error r = oasClient->deletePriceList(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deletePriceList(payload, headers);
        }
        return r;
    }

    # Delete a Price List Item
    #
    # + id - Enter the ID of the Price List where you want to delete an item from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - Returns a number of deleted items 
    remote isolated function deletePriceListItems(string id, oas:DeletePriceListItemRequest payload, map<string|string[]> headers = {}) returns oas:DeletePriceListItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeletePriceListItemResponse|error r = oasClient->deletePriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deletePriceListItems(id, payload, headers);
        }
        return r;
    }

    # Delete a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deletePriceListType(oas:DeletePLTTBody payload, map<string|string[]> headers = {}) returns oas:PriceListTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListTypeOperationEnvelope|error r = oasClient->deletePriceListType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deletePriceListType(payload, headers);
        }
        return r;
    }

    # Delete a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteProduct(oas:DeleteProductRequest payload, map<string|string[]> headers = {}) returns oas:DeleteProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteProductResponse|error r = oasClient->deleteProduct(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteProduct(payload, headers);
        }
        return r;
    }

    # Delete a Product Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteProductExtension(oas:DeleteProductExtensionRequest payload, map<string|string[]> headers = {}) returns oas:DeleteProductExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteProductExtensionResponse|error r = oasClient->deleteProductExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteProductExtension(payload, headers);
        }
        return r;
    }

    # Delete a Rebate Agreement
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function deleteRebateAgreement(oas:DeleteRebateAgreementRequest payload, map<string|string[]> headers = {}) returns oas:RebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RebateAgreementResponse|error r = oasClient->deleteRebateAgreement(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteRebateAgreement(payload, headers);
        }
        return r;
    }

    # Delete a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteRebateCalculation(oas:DeleteRebateCalculationRequest payload, map<string|string[]> headers = {}) returns oas:DeleteRebateCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteRebateCalculationResponse|error r = oasClient->deleteRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteRebateCalculation(payload, headers);
        }
        return r;
    }

    # Delete a Seller
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteSeller(oas:DeleteSellerRequest payload, map<string|string[]> headers = {}) returns oas:DeleteSellerEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteSellerEnvelope|error r = oasClient->deleteSeller(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteSeller(payload, headers);
        }
        return r;
    }

    # Delete a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteSellerExtension(oas:DeleteSellerExtensionRequest payload, map<string|string[]> headers = {}) returns oas:DeleteSellerExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteSellerExtensionResponse|error r = oasClient->deleteSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteSellerExtension(payload, headers);
        }
        return r;
    }

    # 3. Delete an Upload Slot
    #
    # + slotId - Enter the ID of the slot you want to delete
    # + headers - Headers to be sent with the request 
    # + return - Slot deleted 
    remote isolated function deleteUploadSlot(string slotId, map<string|string[]> headers = {}) returns oas:UploadSlotOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UploadSlotOperationEnvelope|error r = oasClient->deleteUploadSlot(slotId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteUploadSlot(slotId, headers);
        }
        return r;
    }

    # 3. Delete an Upload Slot
    #
    # + slotId - Enter the ID of the slot you want to delete
    # + headers - Headers to be sent with the request 
    # + return - Slot deleted 
    remote isolated function deleteUploadSlotViaGet(string slotId, map<string|string[]> headers = {}) returns oas:DeleteUploadSlotResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteUploadSlotResponse|error r = oasClient->deleteUploadSlotViaGet(slotId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteUploadSlotViaGet(slotId, headers);
        }
        return r;
    }

    # Delete a User
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function deleteUser(oas:DeleteUserRequest payload, map<string|string[]> headers = {}) returns oas:UserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UserResponse|error r = oasClient->deleteUser(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteUser(payload, headers);
        }
        return r;
    }

    # Delete a User Group
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteUserGroup(oas:DeleteUserGroupRequest payload, map<string|string[]> headers = {}) returns oas:DeleteUserGroupResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteUserGroupResponse|error r = oasClient->deleteUserGroup(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteUserGroup(payload, headers);
        }
        return r;
    }

    # Delete a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deleteWorkflowDelegation(oas:DeleteWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns oas:DeleteWorkflowDelegationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteWorkflowDelegationResponse|error r = oasClient->deleteWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deleteWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Deny a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function denyDocument(string currentStepId, oas:DenyDocumentRequest payload, map<string|string[]> headers = {}) returns oas:DenyDocumentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DenyDocumentResponse|error r = oasClient->denyDocument(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->denyDocument(currentStepId, payload, headers);
        }
        return r;
    }

    # Deny a Live Price Grid Item
    #
    # + id - The ID of the Price Grid that contains the Price Grid Item you want to deny
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function denyLivePriceGridItem(string id, oas:DenyLivePriceGridItemRequest payload, map<string|string[]> headers = {}) returns oas:PriceGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceGridItemResponse|error r = oasClient->denyLivePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->denyLivePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Deploy a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function deployConfigurationStorage(oas:JcsmanagerDeployBody payload, map<string|string[]> headers = {}) returns oas:ConfigurationStorageOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConfigurationStorageOperationEnvelope|error r = oasClient->deployConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->deployConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Download an Attachment
    #
    # + binaryDataId - If the typedId is, for example, 1146.BD then the binaryDataId is **1146**
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - binary data 
    remote isolated function downloadAttachmentData(string binaryDataId, map<string|string[]> headers = {}, *oas:DownloadAttachmentDataQueries queries) returns byte[]|error {
        oas:Client oasClient = self.getOasClient();
        byte[]|error r = oasClient->downloadAttachmentData(binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->downloadAttachmentData(binaryDataId, headers, queries = queries);
        }
        return r;
    }

    # Download a File
    #
    # + typedId - `typedId` of the document you want to download the attachment from
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - File metadata or content 
    remote isolated function downloadFile(string typedId, string binaryDataId, map<string|string[]> headers = {}, *oas:DownloadFileQueries queries) returns oas:FileDownloadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:FileDownloadEnvelope|error r = oasClient->downloadFile(typedId, binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->downloadFile(typedId, binaryDataId, headers, queries = queries);
        }
        return r;
    }

    # Download a File
    #
    # + typedId - `typedId` of the document you want to download the attachment from
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function downloadFileViaPost(string typedId, string binaryDataId, map<string|string[]> headers = {}, *oas:DownloadFileViaPostQueries queries) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->downloadFileViaPost(typedId, binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->downloadFileViaPost(typedId, binaryDataId, headers, queries = queries);
        }
        return r;
    }

    # Download a Live Price Grid Excel File
    #
    # + id13 - IDs of the Price Grids you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + id1 - The id1 to be sent with the request
    # + id2 - The id2 to be sent with the request
    # + id3 - The id3 to be sent with the request
    # + id4 - The id4 to be sent with the request
    # + id5 - The id5 to be sent with the request
    # + id6 - The id6 to be sent with the request
    # + id7 - The id7 to be sent with the request
    # + id8 - The id8 to be sent with the request
    # + id9 - The id9 to be sent with the request
    # + id10 - The id10 to be sent with the request
    # + id11 - The id11 to be sent with the request
    # + id12 - The id12 to be sent with the request
    # + return - OK 
    remote isolated function downloadLivePriceGridExcelFile(string id1, string id2, string id3, string id4, string id5, string id6, string id7, string id8, string id9, string id10, string id11, string id12, string id13, map<string|string[]> headers = {}, *oas:DownloadLivePriceGridExcelFileQueries queries) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->downloadLivePriceGridExcelFile(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10, id11, id12, id13, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->downloadLivePriceGridExcelFile(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10, id11, id12, id13, headers, queries = queries);
        }
        return r;
    }

    # Drop a KV Table
    #
    # + tableName - A name of the table you want drop. Only lower case letters, numbers and underscores are allowed. Do not use special characters
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Table dropped 
    remote isolated function dropKvTable(string tableName, record {} payload, map<string|string[]> headers = {}) returns record {}|error {
        oas:Client oasClient = self.getOasClient();
        record {}|error r = oasClient->dropKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->dropKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Duplicate a Compensation Plan
    #
    # + typedId - The `typedId` of the Compensation Plan you want to duplicate
    # + headers - Headers to be sent with the request 
    # + return - OK. Returns the duplicated object 
    remote isolated function duplicateCompensationPlan(string typedId, map<string|string[]> headers = {}) returns oas:DuplicateCompensationPlanEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DuplicateCompensationPlanEnvelope|error r = oasClient->duplicateCompensationPlan(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->duplicateCompensationPlan(typedId, headers);
        }
        return r;
    }

    # Duplicate a Custom Form
    #
    # + typedId - `typedId` of the Custom Form you want to duplicate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function duplicateCustomForm(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:CustomFormRevisionEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomFormRevisionEnvelope|error r = oasClient->duplicateCustomForm(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->duplicateCustomForm(typedId, payload, headers);
        }
        return r;
    }

    # Duplicate a Model
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function duplicateModel(string typedId, oas:OptimizationModelduplicatetypedIdBody payload, map<string|string[]> headers = {}) returns oas:ModelDuplicationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ModelDuplicationEnvelope|error r = oasClient->duplicateModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->duplicateModel(typedId, payload, headers);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + ownerTypedId - The `TypedId` of the document owning the attachment
    # + binaryDataId - The `binaryDataId` of the attachment to replace
    # + slotId - The upload `slot_id` containing the new file
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Attachment replaced 
    remote isolated function editAttachment(string ownerTypedId, string binaryDataId, string slotId, oas:BinaryDataIdslotIdBody payload, map<string|string[]> headers = {}) returns oas:FileDownloadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:FileDownloadEnvelope|error r = oasClient->editAttachment(ownerTypedId, binaryDataId, slotId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->editAttachment(ownerTypedId, binaryDataId, slotId, payload, headers);
        }
        return r;
    }

    # Edit a Comment
    #
    # + typedId - typedId of the comment you want to edit
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function editComment(string typedId, oas:CommentmanagerEdittypedIdBody payload, map<string|string[]> headers = {}) returns oas:CommentOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CommentOperationEnvelope|error r = oasClient->editComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->editComment(typedId, payload, headers);
        }
        return r;
    }

    # Execute a Data Load Logic
    #
    # + typedId - The `typedId` of the Data Load you want to evaluate
    # + logicName - The name of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeDataLoadLogic(string typedId, string logicName, map<string|string[]> headers = {}) returns oas:ExecuteDataLoadLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteDataLoadLogicResponse|error r = oasClient->executeDataLoadLogic(typedId, logicName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeDataLoadLogic(typedId, logicName, headers);
        }
        return r;
    }

    # Execute Library Function
    #
    # + formulaName - Name of the formula library containing the function
    # + elementName - Name of the library element containing the function
    # + functionName - Name of the function to execute
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function executeLibraryFunction(string formulaName, string elementName, string functionName, oas:ElementNamefunctionNameBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->executeLibraryFunction(formulaName, elementName, functionName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLibraryFunction(formulaName, elementName, functionName, payload, headers);
        }
        return r;
    }

    # Execute a Logic
    #
    # + typeCode - The `typeCode` of the Action Item you want to execute the calculation for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function executeLogic(string typeCode, record {} payload, map<string|string[]> headers = {}) returns oas:ExecuteActionItemLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteActionItemLogicResponse|error r = oasClient->executeLogic(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLogic(typeCode, payload, headers);
        }
        return r;
    }

    # Execute a Logic Without a Context in a Service
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Example response 
    remote isolated function executeLogicInService(string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}) returns oas:LogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LogicResponse|error r = oasClient->executeLogicInService(uniqueName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLogicInService(uniqueName, payload, headers);
        }
        return r;
    }

    # Execute a Logic Without a Context in a Service (Read-Only)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLogicInServiceReadOnly(string uniqueName, map<string|string[]> headers = {}) returns oas:ExecuteLogicReadOnlyResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteLogicReadOnlyResponse|error r = oasClient->executeLogicInServiceReadOnly(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLogicInServiceReadOnly(uniqueName, headers);
        }
        return r;
    }

    # Execute a Logic (Read-Only)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLogicRead(string uniqueName, map<string|string[]> headers = {}) returns oas:ExecuteLogicReadOnlyResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteLogicReadOnlyResponse|error r = oasClient->executeLogicRead(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLogicRead(uniqueName, headers);
        }
        return r;
    }

    # Execute a Logic (Without a Context)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function executeLogicWithout(string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}, *oas:ExecuteLogicWithoutQueries queries) returns oas:ExecuteLogicWithoutProductContextResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteLogicWithoutProductContextResponse|error r = oasClient->executeLogicWithout(uniqueName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeLogicWithout(uniqueName, payload, headers, queries = queries);
        }
        return r;
    }

    # Execute a Model Logic
    #
    # + typedId - The `typedId` of the Model Object you want to execute the logic for
    # + stepName - The name of the step you want to execute the logic for
    # + formulaName - The name of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function executeModelLogic(string typedId, string stepName, string formulaName, oas:ExecuteModelLogicRequest payload, map<string|string[]> headers = {}) returns oas:ExecuteModelLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteModelLogicResponse|error r = oasClient->executeModelLogic(typedId, stepName, formulaName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeModelLogic(typedId, stepName, formulaName, payload, headers);
        }
        return r;
    }

    # Execute a Logic
    #
    # + sku - The `sku` or `typedId` of the product you want to execute the assigned logic for
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function executeNamedProductLogic(string sku, string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}) returns oas:ExecuteLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteLogicResponse|error r = oasClient->executeNamedProductLogic(sku, uniqueName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeNamedProductLogic(sku, uniqueName, payload, headers);
        }
        return r;
    }

    # Execute an Assigned Logic
    #
    # + sku - The `sku` or `typedId` of the product you want to execute the logic for
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function executeProductLogic(string sku, record {record {} data?;} payload, map<string|string[]> headers = {}) returns oas:ExecuteAssignedLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExecuteAssignedLogicResponse|error r = oasClient->executeProductLogic(sku, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->executeProductLogic(sku, payload, headers);
        }
        return r;
    }

    # Export a PDF File
    #
    # + uniqueName - Specify the `uniqueName` of the A&P you want to download
    # + headers - Headers to be sent with the request 
    # + return - OK - returns the file data 
    remote isolated function exportContractPdf(string uniqueName, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->exportContractPdf(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportContractPdf(uniqueName, headers);
        }
        return r;
    }

    # Export a CSV File
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK - returns the ZIP file (binary data): `Content-Type: application/zip` 
    remote isolated function exportCsvFile(oas:ExportCSVFileRequest payload, map<string|string[]> headers = {}, *oas:ExportCsvFileQueries queries) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->exportCsvFile(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportCsvFile(payload, headers, queries = queries);
        }
        return r;
    }

    # Export Datamart
    #
    # + fcTypedIdOrSourceName - Restricts the export to a specific source, identified by either the 'typedId' or 'sourceName'. 
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function exportDatamart(string fcTypedIdOrSourceName, oas:ExportDatamartRequest payload, map<string|string[]> headers = {}, *oas:ExportDatamartQueries queries) returns oas:ExportDatamartResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ExportDatamartResponse|error r = oasClient->exportDatamart(fcTypedIdOrSourceName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportDatamart(fcTypedIdOrSourceName, payload, headers, queries = queries);
        }
        return r;
    }

    # Export an Excel File (XLSX)
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK - returns the XLSX file (binary data): `Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` 
    remote isolated function exportExcelFileXlsx(oas:ExportExcelFileRequest payload, map<string|string[]> headers = {}, *oas:ExportExcelFileXlsxQueries queries) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->exportExcelFileXlsx(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportExcelFileXlsx(payload, headers, queries = queries);
        }
        return r;
    }

    # Export Models
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - A ZIP file containing the exported model JSON files 
    remote isolated function exportModels(oas:OptimizationModelexportBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->exportModels(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportModels(payload, headers);
        }
        return r;
    }

    # Export a DOCX File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function exportQuoteDocx(string uniqueName, map<string|string[]> headers = {}, *oas:ExportQuoteDocxQueries queries) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->exportQuoteDocx(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportQuoteDocx(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Export an Excel File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns a file data 
    remote isolated function exportQuoteExcel(string uniqueName, map<string|string[]> headers = {}, *oas:ExportQuoteExcelQueries queries) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->exportQuoteExcel(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportQuoteExcel(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Export a PDF File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns the file data 
    remote isolated function exportQuotePdf(string uniqueName, map<string|string[]> headers = {}, *oas:ExportQuotePdfQueries queries) returns record {}|error {
        oas:Client oasClient = self.getOasClient();
        record {}|error r = oasClient->exportQuotePdf(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->exportQuotePdf(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Fetch Activities
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function fetchActivities(oas:ActivitylogFetchBody payload, map<string|string[]> headers = {}) returns record {}|oas:FetchActivitiesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        record {}|oas:FetchActivitiesEnvelope|error r = oasClient->fetchActivities(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->fetchActivities(payload, headers);
        }
        return r;
    }

    # Get a DM Object
    #
    # + objectId - Use one of the following object identifiers:
    # - **typedUniquename** – Format: "*\<typeCode\>.\<uniqueName\>*" (e.g., DMDS.SalesTransactions)
    # - **typedId** – Format: "*\<dbId\>.\<typeCode\>*" (e.g., 123456.DMDS)'
    # - **"*"** (asterisk) – Asterisk can be used when you are providing a **source$query** in `data` within the request body
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function fetchDataMartObject(string objectId, oas:GetDMObjectRequest payload, map<string|string[]> headers = {}, *oas:FetchDataMartObjectQueries queries) returns oas:GetDMObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetDMObjectResponse|error r = oasClient->fetchDataMartObject(objectId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->fetchDataMartObject(objectId, payload, headers, queries = queries);
        }
        return r;
    }

    # Fetch Pending Reviews
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchPendingReviews(map<string|string[]> headers = {}) returns oas:FetchPendingReviewsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:FetchPendingReviewsEnvelope|error r = oasClient->fetchPendingReviews(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->fetchPendingReviews(headers);
        }
        return r;
    }

    # Generate a JWT Token
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function generateJwtToken(oas:GenerateJWTTokenRequest payload, map<string|string[]> headers = {}) returns oas:GenerateJWTTokenResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenerateJWTTokenResponse|error r = oasClient->generateJwtToken(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->generateJwtToken(payload, headers);
        }
        return r;
    }

    # Generate Parameters
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function generateParameters(oas:GenerateParametersRequest payload, map<string|string[]> headers = {}) returns oas:GenerateParametersResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenerateParametersResponse|error r = oasClient->generateParameters(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->generateParameters(payload, headers);
        }
        return r;
    }

    # Generate a JWT Token (time limited)
    #
    # + minutes - The number of minutes in which the token expires
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function generateTimedJwtToken(string minutes, map<string|string[]> headers = {}) returns oas:GenerateJWTTokenTimeLimitedResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenerateJWTTokenTimeLimitedResponse|error r = oasClient->generateTimedJwtToken(minutes, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->generateTimedJwtToken(minutes, headers);
        }
        return r;
    }

    # Get Action Status
    #
    # + headers - Headers to be sent with the request 
    # + actionUUID - The actionUUID to be sent with the request
    # + return - OK 
    remote isolated function getActionStatus(string actionUUID, map<string|string[]> headers = {}) returns oas:GetActionStatusResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetActionStatusResponse|error r = oasClient->getActionStatus(actionUUID, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getActionStatus(actionUUID, headers);
        }
        return r;
    }

    # Get Advanced Configuration Property
    #
    # + propertyname - Name of the configuration property to retrieve
    # + headers - Headers to be sent with the request 
    # + return - Property found 
    remote isolated function getAdvancedConfigurationProperty(string propertyname, map<string|string[]> headers = {}) returns oas:AdvancedConfigPropertyEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:AdvancedConfigPropertyEnvelope|error r = oasClient->getAdvancedConfigurationProperty(propertyname, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getAdvancedConfigurationProperty(propertyname, headers);
        }
        return r;
    }

    # Get a Calculation Grid
    #
    # + id - ID of the Calculation Grid you want to retrieve
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getCalculationGrid(string id, record {} payload, map<string|string[]> headers = {}) returns oas:GetCalculationGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetCalculationGridResponse|error r = oasClient->getCalculationGrid(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getCalculationGrid(id, payload, headers);
        }
        return r;
    }

    # Get a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + id - `id` of the Calculation Grid Item you want to fetch
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, string id, record {} payload, map<string|string[]> headers = {}) returns oas:GetCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetCalculationGridItemResponse|error r = oasClient->getCalculationGridItem(keyNumber, id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getCalculationGridItem(keyNumber, id, payload, headers);
        }
        return r;
    }

    # Get a Calculation Status
    #
    # + typedId - The `typedId` of the Model Object you want to retrieve the calculation status for
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getCalculationStatus(string typedId, map<string|string[]> headers = {}) returns oas:JobStatusTrackerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:JobStatusTrackerResponse|error r = oasClient->getCalculationStatus(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getCalculationStatus(typedId, headers);
        }
        return r;
    }

    # Get a Temporary Data
    #
    # + typedId - `typedId` of the Quote you want to retrieve the temporary data from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getClicDraftHeader(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ClicDraftHeaderEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicDraftHeaderEnvelope|error r = oasClient->getClicDraftHeader(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getClicDraftHeader(typedId, payload, headers);
        }
        return r;
    }

    # Get Folder Statistics
    #
    # + typedId - typedId of the document whose folder statistics you want to fetch
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function getClicFolderStats(string typedId, map<string|string[]> headers = {}, *oas:GetClicFolderStatsQueries queries) returns oas:ClicFolderStatsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicFolderStatsEnvelope|error r = oasClient->getClicFolderStats(typedId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getClicFolderStats(typedId, headers, queries = queries);
        }
        return r;
    }

    # Get a Quote/Contract/Rebate Agreement/Compensation Plan Header
    #
    # + typedId - The `typedId` of the Contract, Quote, or Rebate Agreement you want to return details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getClicHeader(string typedId, map<string|string[]> headers = {}) returns oas:GetQuoteContractRebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetQuoteContractRebateAgreementResponse|error r = oasClient->getClicHeader(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getClicHeader(typedId, headers);
        }
        return r;
    }

    # Get a Condition Record Item
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getConditionRecordItem(record {} payload, map<string|string[]> headers = {}) returns oas:ConditionRecordItemEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordItemEnvelope|error r = oasClient->getConditionRecordItem(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getConditionRecordItem(payload, headers);
        }
        return r;
    }

    # Get a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getConditionRecordItemMeta(oas:FetchCRCIMBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordItemMetaEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordItemMetaEnvelope|error r = oasClient->getConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Get Condition Record Set Items With Set Id Validation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getConditionRecordSetItems(oas:ConditionrecordsetFetchCRCI3Body payload, map<string|string[]> headers = {}) returns oas:ConditionRecordSetItemsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordSetItemsEnvelope|error r = oasClient->getConditionRecordSetItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getConditionRecordSetItems(payload, headers);
        }
        return r;
    }

    # Get a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getConfigurationStorage(oas:FetchJCSBody payload, map<string|string[]> headers = {}) returns oas:GetConfigurationStorageEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetConfigurationStorageEnvelope|error r = oasClient->getConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Get a Contract
    #
    # + uniqueName - `uniqueName` of the Contract you want to retrieve details for. Alternatively, `typedId` can be also used
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getContract(string uniqueName, map<string|string[]> headers = {}) returns oas:ContractModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ContractModelResponse|error r = oasClient->getContract(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getContract(uniqueName, headers);
        }
        return r;
    }

    # Get a Custom Form
    #
    # + typedId - The `typedId` of the Custom Form you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getCustomForm(string typedId, map<string|string[]> headers = {}) returns oas:GetCustomFormResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetCustomFormResponse|error r = oasClient->getCustomForm(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getCustomForm(typedId, headers);
        }
        return r;
    }

    # Get a Customer
    #
    # + id - The ID of the Customer you want to retrieve details for. The `id` is the `typedId` without the **C** suffix. For example, the `id` parameter of the item with `typedId` = **2147492200.C**  is **2147492200**
    # + headers - Headers to be sent with the request 
    # + return - Returns customer record details 
    remote isolated function getCustomer(string id, map<string|string[]> headers = {}) returns oas:CustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomerResponse|error r = oasClient->getCustomer(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getCustomer(id, headers);
        }
        return r;
    }

    # Get a Data Change Request
    #
    # + id - `id` of the Data Change Request you want to retrieve
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getDataChangeRequest(string id, oas:GetDCRRequest payload, map<string|string[]> headers = {}) returns oas:GetDCRResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetDCRResponse|error r = oasClient->getDataChangeRequest(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDataChangeRequest(id, payload, headers);
        }
        return r;
    }

    # Get a Data Change Request (changes only)
    #
    # + id - `id` of the Data Change Request you want to retrieve changed items for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getDataChangeRequestChanges(string id, oas:GetDCRRequestChangeOnly payload, map<string|string[]> headers = {}) returns oas:GetDCRResponseChangeOnly|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetDCRResponseChangeOnly|error r = oasClient->getDataChangeRequestChanges(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDataChangeRequestChanges(id, payload, headers);
        }
        return r;
    }

    # Get Data Change Request Mass Changes
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getDataChangeRequestMassChanges(string id, oas:DcrmanagerFetchmassopidBody payload, map<string|string[]> headers = {}) returns oas:DataChangeRequestMassChangeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataChangeRequestMassChangeEnvelope|error r = oasClient->getDataChangeRequestMassChanges(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDataChangeRequestMassChanges(id, payload, headers);
        }
        return r;
    }

    # Get a DM Object
    #
    # + objectId - Use one of the following object identifiers:
    # - **typedUniquename** – Format: "*\<typeCode\>.\<uniqueName\>*" (e.g., DMDS.SalesTransactions)
    # - **typedId** – Format: "*\<dbId\>.\<typeCode\>*" (e.g., 123456.DMDS)'
    # - **"*"** (asterisk) – Asterisk can be used when you are providing a **source$query** in `data` within the request body
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Exported data 
    remote isolated function getDataMartObject(string objectId, map<string|string[]> headers = {}, *oas:GetDataMartObjectQueries queries) returns oas:DataMartObjectEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataMartObjectEnvelope|error r = oasClient->getDataMartObject(objectId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDataMartObject(objectId, headers, queries = queries);
        }
        return r;
    }

    # Get a Default Pricing Logic Name
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDefaultPricingLogicName(map<string|string[]> headers = {}) returns oas:GetDefaultPricingLogicNameResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetDefaultPricingLogicNameResponse|error r = oasClient->getDefaultPricingLogicName(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDefaultPricingLogicName(headers);
        }
        return r;
    }

    # Get a DM Export File
    #
    # + fileName - The name of the file previously created by a `datamart.export` request. The filename needs to be an exact match - no wildcards allowed, hence only one file at the time can be fetched
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDmExportFile(string fileName, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->getDmExportFile(fileName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDmExportFile(fileName, headers);
        }
        return r;
    }

    # Get a DM Object (no count)
    #
    # + objectId - Use one of the following object identifiers:
    # - **typedUniquename** – Format: "*\<typeCode\>.\<uniqueName\>*" (e.g., DMDS.SalesTransactions)
    # - **typedId** – Format: "*\<dbId\>.\<typeCode\>*" (e.g., 123456.DMDS)
    # - **"*"** (asterisk) – Asterisk can be used when you are providing a **source$query** in `data` within the request body
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getDmObjectNo(string objectId, oas:GetDMObjectNoCountRequest payload, map<string|string[]> headers = {}) returns oas:GetDMObjectNoCountResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetDMObjectNoCountResponse|error r = oasClient->getDmObjectNo(objectId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getDmObjectNo(objectId, payload, headers);
        }
        return r;
    }

    # Get External Application Properties
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getExternalApplicationProperties(map<string|string[]> headers = {}) returns oas:GetexternalapppropertiesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetexternalapppropertiesResponse|error r = oasClient->getExternalApplicationProperties(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getExternalApplicationProperties(headers);
        }
        return r;
    }

    # Get a Key
    #
    # + tableName - A name of the table you want to retrieve the "payload" from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK. The "payload" is returned 
    remote isolated function getKey(string tableName, oas:GetKVKeyRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->getKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getKey(tableName, payload, headers);
        }
        return r;
    }

    # Get a Live Price Grid
    #
    # + id - The `id` of the Live Price Grid you want to retrieve details for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLivePriceGrid(string id, map<string|string[]> headers = {}) returns oas:GetLivePriceGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetLivePriceGridResponse|error r = oasClient->getLivePriceGrid(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getLivePriceGrid(id, headers);
        }
        return r;
    }

    # Get a Logic
    #
    # + id - The ID of the logic you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLogic(string id, map<string|string[]> headers = {}) returns oas:GetLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetLogicResponse|error r = oasClient->getLogic(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getLogic(id, headers);
        }
        return r;
    }

    # Get Logic References
    #
    # + tableId - Enter the ID of the table you want to retrieve logic references for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLogicReferences(string tableId, map<string|string[]> headers = {}) returns oas:GetLogicReferencesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetLogicReferencesResponse|error r = oasClient->getLogicReferences(tableId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getLogicReferences(tableId, headers);
        }
        return r;
    }

    # Get a Loki Log
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function getLokiLog(map<string|string[]> headers = {}, *oas:GetLokiLogQueries queries) returns oas:LokiLogEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:LokiLogEnvelope|error r = oasClient->getLokiLog(headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getLokiLog(headers, queries = queries);
        }
        return r;
    }

    # Get MCP Roles
    #
    # + headers - Headers to be sent with the request 
    # + return - Roles received 
    remote isolated function getMcpRoles(map<string|string[]> headers = {}) returns oas:McpRolesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:McpRolesEnvelope|error r = oasClient->getMcpRoles(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getMcpRoles(headers);
        }
        return r;
    }

    # Get MCP Tools
    #
    # + headers - Headers to be sent with the request 
    # + return - Roles received 
    remote isolated function getMcpTools(map<string|string[]> headers = {}) returns oas:McpToolsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:McpToolsEnvelope|error r = oasClient->getMcpTools(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getMcpTools(headers);
        }
        return r;
    }

    # 1. Create an Upload Slot
    #
    # + headers - Headers to be sent with the request 
    # + return - Slot created 
    remote isolated function getNewUploadSlot(map<string|string[]> headers = {}) returns oas:CreateUploadSlotResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateUploadSlotResponse|error r = oasClient->getNewUploadSlot(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getNewUploadSlot(headers);
        }
        return r;
    }

    # Get an Object
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + id - The ID of the object you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getObject(string typeCode, string id, map<string|string[]> headers = {}) returns oas:GetObjectResponse_1|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetObjectResponse_1|error r = oasClient->getObject(typeCode, id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getObject(typeCode, id, headers);
        }
        return r;
    }

    # Get a One Time Token
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getOneTimeToken(map<string|string[]> headers = {}) returns oas:GetOneTimeTokenResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetOneTimeTokenResponse|error r = oasClient->getOneTimeToken(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getOneTimeToken(headers);
        }
        return r;
    }

    # Get a Parallel Calculation Item
    #
    # + id - `id` of the Parallel Calculation Item (PCI) you want to retrieve
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getParallelCalculationItem(string id, record {} payload, map<string|string[]> headers = {}) returns oas:GetParallelCalculationItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetParallelCalculationItemResponse|error r = oasClient->getParallelCalculationItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getParallelCalculationItem(id, payload, headers);
        }
        return r;
    }

    # Get a Price List
    #
    # + id - The ID of the Price List you want to retrieve details for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getPriceList(string id, map<string|string[]> headers = {}) returns oas:GetPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetPriceListResponse|error r = oasClient->getPriceList(id, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getPriceList(id, headers);
        }
        return r;
    }

    # Get Product Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getProductAttributeMeta(record {} payload, map<string|string[]> headers = {}) returns oas:ProductAttributeMetaEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductAttributeMetaEnvelope|error r = oasClient->getProductAttributeMeta(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getProductAttributeMeta(payload, headers);
        }
        return r;
    }

    # List BoM for a Product
    #
    # + sku - The `sku` of the product you want to retrieve the Bill of Materials for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getProductBomTree(string sku, map<string|string[]> headers = {}) returns oas:ListBoMForProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListBoMForProductResponse|error r = oasClient->getProductBomTree(sku, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getProductBomTree(sku, headers);
        }
        return r;
    }

    # Get Competition Data
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getProductCompetition(oas:GetCompetitionDataRequest payload, map<string|string[]> headers = {}) returns oas:GetCompetitionDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetCompetitionDataResponse|error r = oasClient->getProductCompetition(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getProductCompetition(payload, headers);
        }
        return r;
    }

    # Get a Product Set
    #
    # + label - Enter the name of the product set you want to retrieve
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getProductSetCompetition(string label, oas:GetProductSetRequest payload, map<string|string[]> headers = {}) returns oas:GetProductSetResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetProductSetResponse|error r = oasClient->getProductSetCompetition(label, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getProductSetCompetition(label, payload, headers);
        }
        return r;
    }

    # Get Query API Metadata
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Metadata returned 
    remote isolated function getQueryApiMetadata(oas:QueryapiExecuteBody payload, map<string|string[]> headers = {}) returns oas:QueryApiMetadataEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:QueryApiMetadataEnvelope|error r = oasClient->getQueryApiMetadata(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getQueryApiMetadata(payload, headers);
        }
        return r;
    }

    # Get a Quote
    #
    # + typedID - Enter the quote typed ID. You get the `typedId` in the response when fetching all quotes using the `/quotemanager.fetchlist` endpoint
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getQuote(string typedID, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->getQuote(typedID, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getQuote(typedID, headers);
        }
        return r;
    }

    # Get a Rebate Agreement
    #
    # + uniqueName - The `uniqueName` of the Rebate Agreement you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getRebateAgreement(string uniqueName, map<string|string[]> headers = {}) returns oas:RebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RebateAgreementResponse|error r = oasClient->getRebateAgreement(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getRebateAgreement(uniqueName, headers);
        }
        return r;
    }

    # Get a Rebate Record Group
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getRebateRecordGroup(record {} payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->getRebateRecordGroup(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getRebateRecordGroup(payload, headers);
        }
        return r;
    }

    # Get a Seller Extension
    #
    # + sellerId - The `SellerId` of the seller in the Seller Extension table you want to retrieve details for
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSellerExtension(string sellerId, string sXCategory, map<string|string[]> headers = {}) returns oas:SellerExtensionEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:SellerExtensionEnvelope|error r = oasClient->getSellerExtension(sellerId, sXCategory, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getSellerExtension(sellerId, sXCategory, headers);
        }
        return r;
    }

    # Get a Signature Status
    #
    # + typedId - `typedId` of the Compensation document you want to retrieve the signature status for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getSignatureStatus(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:GetSignatureStatusResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetSignatureStatusResponse|error r = oasClient->getSignatureStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getSignatureStatus(typedId, payload, headers);
        }
        return r;
    }

    # Get a Signed Document
    #
    # + uniqueName - A `uniqueName` of the Compensation Plan you want to download a signed file for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSignedDocument(string uniqueName, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->getSignedDocument(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getSignedDocument(uniqueName, headers);
        }
        return r;
    }

    # Get a Step Calculation Status
    #
    # + typedId - The `typedId` of the Model Object you want to retrieve the calculation status for
    # + stepName - The name of the step you want to calculate
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getStepCalculationStatus(string typedId, string stepName, map<string|string[]> headers = {}) returns oas:JobStatusTrackerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:JobStatusTrackerResponse|error r = oasClient->getStepCalculationStatus(typedId, stepName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getStepCalculationStatus(typedId, stepName, headers);
        }
        return r;
    }

    # Get a Summary
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function getSummary(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:GetClaimItemsSummaryResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetClaimItemsSummaryResponse|error r = oasClient->getSummary(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getSummary(typedId, payload, headers);
        }
        return r;
    }

    # Get a Table Info
    #
    # + tableName - A name of the table you want to retrieve information about
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getTableInfo(string tableName, map<string|string[]> headers = {}) returns oas:GetKVTableInfoResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetKVTableInfoResponse|error r = oasClient->getTableInfo(tableName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getTableInfo(tableName, headers);
        }
        return r;
    }

    # Get Upload Progress
    #
    # + uploadslot - Upload Slot Id
    # + headers - Headers to be sent with the request 
    # + return - The request response contains the current status of the upload slot, including progress information 
    remote isolated function getUploadProgress(string uploadslot, map<string|string[]> headers = {}) returns oas:UploadSlotOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UploadSlotOperationEnvelope|error r = oasClient->getUploadProgress(uploadslot, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getUploadProgress(uploadslot, headers);
        }
        return r;
    }

    # Get a User Audit Report
    #
    # + typeCode - Specify whether you want to retrieve a report based on user roles (`R`), user groups (`UG`), or business roles (`BR`)
    # + id - Specify the `id`of the user role, user group, or business role for which you want to retrieve users. Call the `/fetch/R`, `/fetch/UG`, or `/fetch/BR` endpoint to retrieve a list with corresponding user roles, user groups, or business roles
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function getUserAuditReport("R"|"UG"|"BR" typeCode, string id, record {} payload, map<string|string[]> headers = {}) returns oas:UserAuditReportEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UserAuditReportEnvelope|error r = oasClient->getUserAuditReport(typeCode, id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getUserAuditReport(typeCode, id, payload, headers);
        }
        return r;
    }

    # Get a Workflow Document
    #
    # + typedId - The `typedId` of the approvable object you want to retrieve workflow details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getWorkflowDocument(string typedId, map<string|string[]> headers = {}) returns oas:GetWorkflowDocumentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetWorkflowDocumentResponse|error r = oasClient->getWorkflowDocument(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->getWorkflowDocument(typedId, headers);
        }
        return r;
    }

    # Import Line Items (w/o Input Types)
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK - `ServerMessageExtended` property contains information about what was imported 
    remote isolated function importClicLineItems(string typedId, oas:ClicmanagerImportlineitemstypedIdBody payload, map<string|string[]> headers = {}) returns oas:ClicOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicOperationEnvelope|error r = oasClient->importClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Import a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function importDataLoad(oas:ImportDataLoadRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->importDataLoad(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importDataLoad(payload, headers);
        }
        return r;
    }

    # Import a File
    #
    # + slotId - The `id` of the slot. Create the slot and retrieve the `id` using the **/uploadmanager.newuploadslot** endpoint
    # + typedId - The `typedId` of the Data Manager entity
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function importDataMartFile(string slotId, string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->importDataMartFile(slotId, typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importDataMartFile(slotId, typedId, headers);
        }
        return r;
    }

    # Import Models
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function importModels(oas:OptimizationModelimportBody payload, map<string|string[]> headers = {}) returns oas:ModelDuplicationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ModelDuplicationEnvelope|error r = oasClient->importModels(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importModels(payload, headers);
        }
        return r;
    }

    # Import Competition Data
    #
    # + headers - Headers to be sent with the request 
    # + payload - The competition product details 
    # + return - OK 
    remote isolated function importProductCompetition(oas:ImportCompetitionDataRequest payload, map<string|string[]> headers = {}) returns oas:ImportCompetitionDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ImportCompetitionDataResponse|error r = oasClient->importProductCompetition(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importProductCompetition(payload, headers);
        }
        return r;
    }

    # Import a File
    #
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + slotId - The ID that is returned by the **/uploadmanager.newuploadslot** (Create an Upload Slot) endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - Accepted 
    remote isolated function importSellerExtensionFile(string sXCategory, string slotId, oas:ImportSXFileRequest payload, map<string|string[]> headers = {}, *oas:ImportSellerExtensionFileQueries queries) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->importSellerExtensionFile(sXCategory, slotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->importSellerExtensionFile(sXCategory, slotId, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Customer Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify customer extension field names in the `header` object and field values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function insertBulkCustomerExtensions(oas:InsertBulkCustomerExtensionsRequest payload, map<string|string[]> headers = {}) returns oas:LoadDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LoadDataResponse|error r = oasClient->insertBulkCustomerExtensions(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkCustomerExtensions(payload, headers);
        }
        return r;
    }

    # Insert Bulk Data
    #
    # + typeCode - Specify the type code for the entity you want to work with. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article.'
    # + headers - Headers to be sent with the request 
    # + payload - The **`/loaddata/P`** endpoint (Insert Bulk Products) is used in our example.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function insertBulkData(oas:TypeCodeEnum typeCode, oas:InsertBulkDataRequest payload, map<string|string[]> headers = {}) returns oas:LoadDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LoadDataResponse|error r = oasClient->insertBulkData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkData(typeCode, payload, headers);
        }
        return r;
    }

    # Insert Bulk Data From a File
    #
    # + typeCode - Enter the type code of the entity you want to insert a data to. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function insertBulkDataFromFile("C"|"CDESC"|"CX"|"JLTV"|"LTV"|"MLTV"|"P"|"PBOME"|"PCOMP"|"PDESC"|"PR"|"PX"|"PXREF"|"SL"|"SX"|"TODO"|"UG" typeCode, oas:InsertBulkDataFromFileRequest payload, map<string|string[]> headers = {}, *oas:InsertBulkDataFromFileQueries queries) returns oas:InsertBulkDataFromFileResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:InsertBulkDataFromFileResponse|error r = oasClient->insertBulkDataFromFile(typeCode, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkDataFromFile(typeCode, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Data From a File (async)
    #
    # + typeCode - Enter the type code of the entity you want to insert a data to. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function insertBulkDataFromFileAsync("C"|"CDESC"|"CX"|"JLTV"|"LTV"|"MLTV"|"P"|"PBOME"|"PCOMP"|"PDESC"|"PR"|"PX"|"PXREF"|"SL"|"SX"|"TODO"|"UG" typeCode, oas:InsertBulkDataFromFileAsyncRequest payload, map<string|string[]> headers = {}, *oas:InsertBulkDataFromFileAsyncQueries queries) returns oas:InsertBulkDataFromFileAsyncResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:InsertBulkDataFromFileAsyncResponse|error r = oasClient->insertBulkDataFromFileAsync(typeCode, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkDataFromFileAsync(typeCode, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Data to Lookup Table
    #
    # + typeCode - Enter the type code of the Lookup Table entity you want to insert a data to
    # + headers - Headers to be sent with the request 
    # + payload - We used `/lookuptablemanager.loaddata/MLTV` in the request example to insert bulk data to Matrix Lookup Table. Notice that the `lookupTable` is used in the `header` section and then ID of the Lookup Table in the `data` section 
    # + return - OK 
    remote isolated function insertBulkDataToLookupTable("JLTV"|"JLTVM"|"LT"|"LTT"|"LTV"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM" typeCode, oas:InsertBulkDataToLookupTableRequest payload, map<string|string[]> headers = {}) returns oas:InsertBulkDataLookupTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:InsertBulkDataLookupTableResponse|error r = oasClient->insertBulkDataToLookupTable(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkDataToLookupTable(typeCode, payload, headers);
        }
        return r;
    }

    # Insert Bulk KV Data
    #
    # + tableName - A name of the table you want upload data to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function insertBulkKvData(string tableName, oas:InsertBulkKVDataRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->insertBulkKvData(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkKvData(tableName, payload, headers);
        }
        return r;
    }

    # Insert Bulk Product Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify product extension field names in the `header` object and field values in the `data` object 
    # + return - OK 
    remote isolated function insertBulkProductExtensions(oas:InsertBulkProductExtensionsRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->insertBulkProductExtensions(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkProductExtensions(payload, headers);
        }
        return r;
    }

    # Insert Bulk Seller Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify seller extension field names in the `header` object and field values in the `data` object 
    # + return - OK 
    remote isolated function insertBulkSellerExtensions(oas:InsertBulkProductExtensionsRequest1 payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->insertBulkSellerExtensions(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->insertBulkSellerExtensions(payload, headers);
        }
        return r;
    }

    # List Accrual Records
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listAccrualRecords(oas:ListAccrualRecordsRequest payload, map<string|string[]> headers = {}) returns oas:ListAccrualRecordsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListAccrualRecordsResponse|error r = oasClient->listAccrualRecords(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listAccrualRecords(payload, headers);
        }
        return r;
    }

    # List Action Items
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listActionItems(oas:FetchAIBody payload, map<string|string[]> headers = {}) returns oas:ListActionItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListActionItemsResponse|error r = oasClient->listActionItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listActionItems(payload, headers);
        }
        return r;
    }

    # List Action Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - A general fetch request. A filter can be applied 
    # + return - OK 
    remote isolated function listActionTypes(record {int endRow?; record {}? oldValues?; string operationType?; int startRow?; string textMatchStyle?; record {string _constructor?; string operator?; record {string fieldName?; string operator?; string value?;}[] criteria?;} data?;} payload, map<string|string[]> headers = {}) returns oas:ListActionTypesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListActionTypesResponse|error r = oasClient->listActionTypes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listActionTypes(payload, headers);
        }
        return r;
    }

    # List All Lookup Table Values
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - You can specify the start and end row to limit the number of retrieved records 
    # + return - OK 
    remote isolated function listAllLookupTableValues(string tableId, oas:ListAllLookupTableValuesRequest payload, map<string|string[]> headers = {}, *oas:ListAllLookupTableValuesQueries queries) returns oas:ListAllLookupTableValuesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListAllLookupTableValuesResponse|error r = oasClient->listAllLookupTableValues(tableId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listAllLookupTableValues(tableId, payload, headers, queries = queries);
        }
        return r;
    }

    # List All Lookup Tables
    #
    # + headers - Headers to be sent with the request 
    # + payload - You can specify the start and end row to limit the number of retrieved Lookup Tables / Company Parameters 
    # + return - Returns the Company Parameter table / Lookup table fields. The `name` property is the same as `uniqueName` if the `owner` is `null`. If the `owner` field is non-null, then the `name` will be the name of the table (DMT or LT) in the context of the owner 
    remote isolated function listAllLookupTables(oas:ListAllLookupTablesRequest payload, map<string|string[]> headers = {}) returns oas:ListAllLookupTablesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListAllLookupTablesResponse|error r = oasClient->listAllLookupTables(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listAllLookupTables(payload, headers);
        }
        return r;
    }

    # List Attribute Fields' Metadata
    #
    # + typeCode - Enter the type code of the entity you want to retrieve information for. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAttributeFieldsMetadata("ACTT"|"AI"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CL"|"CLLI"|"CLLIAM"|"CLR"|"CLT"|"CN"|"CO"|"COAM"|"COCT"|"COCTAM"|"COHT"|"COHTAM"|"COLI"|"COR"|"CORAM"|"COROLI"|"CORS"|"CORSC"|"COT"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX10"|"CX20"|"CX3"|"CX30"|"CX50"|"CX6"|"CX8"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DP"|"DPR"|"DPT"|"DREF"|"DREG"|"EDL"|"ET"|"EVT"|"F"|"FE"|"FN"|"HEVT"|"HRT"|"HRTAM"|"IDC"|"IE"|"ISH"|"JLTV"|"JLTV2"|"JLTVM"|"JST"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MC"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MN"|"MO"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"NT"|"P"|"PAM"|"PBOME"|"PCOMP"|"PCOMPCO"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLPGTT"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX10"|"PX20"|"PX3"|"PX30"|"PX50"|"PX6"|"PX8"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAROLI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"SL"|"SLAM"|"SX10"|"SX20"|"SX3"|"SX30"|"SX50"|"SX6"|"SX8"|"SXAM"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, map<string|string[]> headers = {}, *oas:ListAttributeFieldsMetadataQueries queries) returns oas:ListAttributeFieldsMetadata|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListAttributeFieldsMetadata|error r = oasClient->listAttributeFieldsMetadata(typeCode, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listAttributeFieldsMetadata(typeCode, headers, queries = queries);
        }
        return r;
    }

    # List Calculated Field Sets
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCalculatedFieldSets(map<string|string[]> headers = {}) returns oas:ListCalculatedFieldSetsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCalculatedFieldSetsResponse|error r = oasClient->listCalculatedFieldSets(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCalculatedFieldSets(headers);
        }
        return r;
    }

    # List Calculation Grid Items
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCalculationGridItems("1"|"2"|"3"|"4"|"5"|"6" keyNumber, oas:ListCalculationGridItemsRequest payload, map<string|string[]> headers = {}) returns oas:ListCalculationGridItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCalculationGridItemsResponse|error r = oasClient->listCalculationGridItems(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCalculationGridItems(keyNumber, payload, headers);
        }
        return r;
    }

    # List Calculation Grids
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCalculationGrids(record {} payload, map<string|string[]> headers = {}) returns oas:ListCalculationGridsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCalculationGridsResponse|error r = oasClient->listCalculationGrids(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCalculationGrids(payload, headers);
        }
        return r;
    }

    # List Calculations
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCalculations(oas:ListCalculationsRequest payload, map<string|string[]> headers = {}) returns oas:ListCalculationsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCalculationsResponse|error r = oasClient->listCalculations(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCalculations(payload, headers);
        }
        return r;
    }

    # List Charts
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCharts(map<string|string[]> headers = {}) returns oas:ListChartsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListChartsResponse|error r = oasClient->listCharts(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCharts(headers);
        }
        return r;
    }

    # List Claim Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - The example of the request body contains the filter. The call returns Claim Types whose `name` equals to "claimType" 
    # + return - OK 
    remote isolated function listClaimTypes(oas:ListClaimTypesRequest payload, map<string|string[]> headers = {}) returns oas:ListClaimTypesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListClaimTypesResponse|error r = oasClient->listClaimTypes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listClaimTypes(payload, headers);
        }
        return r;
    }

    # List Claims
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function listClaims(oas:ListClaimsRequest payload, map<string|string[]> headers = {}) returns oas:ListClaimsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListClaimsResponse|error r = oasClient->listClaims(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listClaims(payload, headers);
        }
        return r;
    }

    # List CLIC Objects
    #
    # + typedId - The `typedId` of the Quote/Contract/Rebate Agreement/Compensation Plan you want to retrieve line items for
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listClicObjects(string typedId, oas:GetCLICrequest payload, map<string|string[]> headers = {}, *oas:ListClicObjectsQueries queries) returns oas:GetCLICresponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GetCLICresponse|error r = oasClient->listClicObjects(typedId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listClicObjects(typedId, payload, headers, queries = queries);
        }
        return r;
    }

    # List Comment Threads
    #
    # + typedId - typedId of the object you want to fetch comments for
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCommentThreads(string typedId, oas:CommentmanagerFetchthreadstypedIdBody payload, map<string|string[]> headers = {}, *oas:ListCommentThreadsQueries queries) returns oas:ListCommentThreadsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCommentThreadsEnvelope|error r = oasClient->listCommentThreads(typedId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCommentThreads(typedId, payload, headers, queries = queries);
        }
        return r;
    }

    # List Compensation Plans
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCompensationPlans(oas:ListCompensationPlansRequest payload, map<string|string[]> headers = {}) returns oas:ListCompensationPlansResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCompensationPlansResponse|error r = oasClient->listCompensationPlans(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCompensationPlans(payload, headers);
        }
        return r;
    }

    # List Compensation Records
    #
    # + compensationRecordSetId - ID of the CompensationRecordSet into which this Compensation Record belongs. By default it belongs to "Default" CompensationRecordSet, but you can change it when you create the Compensation Record. This can be useful if you create different "kinds" of Compensation Records which will be used to calculate different results at different times
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCompensationRecords(string compensationRecordSetId, oas:ListCompensationRecordsRequest payload, map<string|string[]> headers = {}) returns oas:ListCompensationRecordsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCompensationRecordsResponse|error r = oasClient->listCompensationRecords(compensationRecordSetId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCompensationRecords(compensationRecordSetId, payload, headers);
        }
        return r;
    }

    # List Compensation Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCompensationTypes(oas:ListCompensationTypesRequest payload, map<string|string[]> headers = {}) returns oas:ListCompensationTypesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCompensationTypesEnvelope|error r = oasClient->listCompensationTypes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCompensationTypes(payload, headers);
        }
        return r;
    }

    # List Condition Record Sets
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listConditionRecordSets(record {} payload, map<string|string[]> headers = {}) returns oas:ListConditionRecordSetsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListConditionRecordSetsEnvelope|error r = oasClient->listConditionRecordSets(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listConditionRecordSets(payload, headers);
        }
        return r;
    }

    # List Condition Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listConditionTypes(oas:ListConditionTypesRequest payload, map<string|string[]> headers = {}) returns oas:ListConditionTypesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListConditionTypesEnvelope|error r = oasClient->listConditionTypes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listConditionTypes(payload, headers);
        }
        return r;
    }

    # List Contract Calculations
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listContractCalculations(record {} payload, map<string|string[]> headers = {}) returns oas:ListContractCalculationsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListContractCalculationsEnvelope|error r = oasClient->listContractCalculations(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listContractCalculations(payload, headers);
        }
        return r;
    }

    # List Contract Price Records
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listContractPriceRecords(oas:FetchCPRBody payload, map<string|string[]> headers = {}) returns oas:ListContractPriceRecords|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListContractPriceRecords|error r = oasClient->listContractPriceRecords(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listContractPriceRecords(payload, headers);
        }
        return r;
    }

    # List Contracts
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function listContracts(oas:ListContractsRequest payload, map<string|string[]> headers = {}) returns oas:ContractResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ContractResponse|error r = oasClient->listContracts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listContracts(payload, headers);
        }
        return r;
    }

    # List Custom Form Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCustomFormTypes(oas:ListCustomFormTypesRequest payload, map<string|string[]> headers = {}) returns oas:ListCustomFormTypesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCustomFormTypesResponse|error r = oasClient->listCustomFormTypes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCustomFormTypes(payload, headers);
        }
        return r;
    }

    # List Custom Forms
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCustomForms(oas:ListCustomFormsRequest payload, map<string|string[]> headers = {}) returns oas:ListCustomFormsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCustomFormsEnvelope|error r = oasClient->listCustomForms(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCustomForms(payload, headers);
        }
        return r;
    }

    # List Customer Assignments
    #
    # + typedId - The `typedId` of the entity you want to retrieve assignments for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function listCustomerAssignments(string typedId, oas:ListCustomerAssignmentsRequest payload, map<string|string[]> headers = {}) returns oas:AssignmentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:AssignmentResponse|error r = oasClient->listCustomerAssignments(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCustomerAssignments(typedId, payload, headers);
        }
        return r;
    }

    # List Customer Extension Objects
    #
    # + customerMasterExtensionName - Enter the name of Customer Extension you want to retrieve objects from. You can find the name in **Administration** > **Configuration** > **Master Data** > **Customer Master Extension** or using the **/configurationmanager.get/customerextension** endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listCustomerExtensionObjects(string customerMasterExtensionName, oas:ListCustomerExtensionObjectsRequest payload, map<string|string[]> headers = {}, *oas:ListCustomerExtensionObjectsQueries queries) returns oas:ListCustomerExtensionObjectsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListCustomerExtensionObjectsResponse|error r = oasClient->listCustomerExtensionObjects(customerMasterExtensionName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCustomerExtensionObjects(customerMasterExtensionName, payload, headers, queries = queries);
        }
        return r;
    }

    # List Customers
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns customer record details 
    remote isolated function listCustomers(oas:ListCustomersRequest payload, map<string|string[]> headers = {}) returns oas:CustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomerResponse|error r = oasClient->listCustomers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listCustomers(payload, headers);
        }
        return r;
    }

    # List Data Loads
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDataLoads(map<string|string[]> headers = {}) returns oas:ListDataLoadsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListDataLoadsResponse|error r = oasClient->listDataLoads(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listDataLoads(headers);
        }
        return r;
    }

    # List Data Loads (with validation and schedules)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDataLoadsWith(map<string|string[]> headers = {}) returns oas:ListDataLoadsWithValidationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListDataLoadsWithValidationResponse|error r = oasClient->listDataLoadsWith(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listDataLoadsWith(headers);
        }
        return r;
    }

    # List Data Manager Entities
    #
    # + typeCode - The type code of the **Field Collection**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function listDataManagerEntities("DM"|"DMDS"|"DMF"|"DMT" typeCode, oas:ListDataManagerEntitiesRequest payload, map<string|string[]> headers = {}) returns oas:DmObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DmObjectResponse|error r = oasClient->listDataManagerEntities(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listDataManagerEntities(typeCode, payload, headers);
        }
        return r;
    }

    # List Datamart Orphan Objects
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDatamartOrphanObjects(map<string|string[]> headers = {}) returns oas:DatamartOrphanObjectsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DatamartOrphanObjectsEnvelope|error r = oasClient->listDatamartOrphanObjects(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listDatamartOrphanObjects(headers);
        }
        return r;
    }

    # List Delegated Workflows
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listDelegatedWorkflows(oas:ListDelegatedWorkflowsRequest payload, map<string|string[]> headers = {}) returns oas:ListDelegatedWorkflowsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListDelegatedWorkflowsResponse|error r = oasClient->listDelegatedWorkflows(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listDelegatedWorkflows(payload, headers);
        }
        return r;
    }

    # List Elements
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to list elements for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listElements(string uniqueName, map<string|string[]> headers = {}) returns oas:ListElementsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListElementsResponse|error r = oasClient->listElements(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listElements(uniqueName, headers);
        }
        return r;
    }

    # List Email Tasks
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listEmailTasks(oas:NotificationListBody payload, map<string|string[]> headers = {}) returns oas:ListEmailTasksEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListEmailTasksEnvelope|error r = oasClient->listEmailTasks(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listEmailTasks(payload, headers);
        }
        return r;
    }

    # List Entity Fields
    #
    # + typeCode - Enter the type code of the entity you want to retrieve information for. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listEntityFields("ACTT"|"AI"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CL"|"CLLI"|"CLLIAM"|"CLR"|"CLT"|"CN"|"CO"|"COAM"|"COCT"|"COCTAM"|"COHT"|"COHTAM"|"COLI"|"COR"|"CORAM"|"COROLI"|"CORS"|"CORSC"|"COT"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX10"|"CX20"|"CX3"|"CX30"|"CX50"|"CX6"|"CX8"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DP"|"DPR"|"DPT"|"DREF"|"DREG"|"EDL"|"ET"|"EVT"|"F"|"FE"|"FN"|"HEVT"|"HRT"|"HRTAM"|"IDC"|"IE"|"ISH"|"JLTV"|"JLTV2"|"JLTVM"|"JST"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MC"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MN"|"MO"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"NT"|"P"|"PAM"|"PBOME"|"PCOMP"|"PCOMPCO"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLPGTT"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX10"|"PX20"|"PX3"|"PX30"|"PX50"|"PX6"|"PX8"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAROLI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"SL"|"SLAM"|"SX10"|"SX20"|"SX3"|"SX30"|"SX50"|"SX6"|"SX8"|"SXAM"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, map<string|string[]> headers = {}, *oas:ListEntityFieldsQueries queries) returns oas:ListEntityFieldsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListEntityFieldsResponse|error r = oasClient->listEntityFields(typeCode, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listEntityFields(typeCode, headers, queries = queries);
        }
        return r;
    }

    # List Event Tasks
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listEventTasks(oas:NotificationListBody payload, map<string|string[]> headers = {}) returns oas:ListEventTasksEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListEventTasksEnvelope|error r = oasClient->listEventTasks(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listEventTasks(payload, headers);
        }
        return r;
    }

    # List Files
    #
    # + typedId - `typedId` of the document you want to list attachments for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listFiles(string typedId, oas:BdmanagerListtypedIdBody payload, map<string|string[]> headers = {}) returns oas:ListFilesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListFilesEnvelope|error r = oasClient->listFiles(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listFiles(typedId, payload, headers);
        }
        return r;
    }

    # List Functions
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listFunctions(map<string|string[]> headers = {}) returns oas:ListFunctionsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListFunctionsResponse|error r = oasClient->listFunctions(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listFunctions(headers);
        }
        return r;
    }

    # List Groups of the Business Role
    #
    # + businessroleId - The ID of the business role you want to retrieve user roles for. The `businessroleId` is the `typedId` without the `BR` suffix. For example, `businessroleId` of the **53.BR** is **53**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listGroupsOfBusinessRole(string businessroleId, map<string|string[]> headers = {}) returns oas:ListGroupsOfBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListGroupsOfBusinessRoleResponse|error r = oasClient->listGroupsOfBusinessRole(businessroleId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listGroupsOfBusinessRole(businessroleId, headers);
        }
        return r;
    }

    # List ImportManager Changes
    #
    # + headers - Headers to be sent with the request 
    # + uniqueName - The uniqueName to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function listImportManagerChanges(string uniqueName, record {} payload, map<string|string[]> headers = {}) returns oas:ListImportManagerChangesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListImportManagerChangesEnvelope|error r = oasClient->listImportManagerChanges(uniqueName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listImportManagerChanges(uniqueName, payload, headers);
        }
        return r;
    }

    # List Internationalization Messages
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - contains the messages for the locale 
    remote isolated function listInternationalizationMessages(oas:I18nmanagerFetchWithExtraDataBody payload, map<string|string[]> headers = {}) returns oas:ListInternationalizationMessagesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListInternationalizationMessagesEnvelope|error r = oasClient->listInternationalizationMessages(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listInternationalizationMessages(payload, headers);
        }
        return r;
    }

    # List Items
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function listItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ListClaimItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListClaimItemsResponse|error r = oasClient->listItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listItems(typedId, payload, headers);
        }
        return r;
    }

    # List Jobs
    #
    # + headers - Headers to be sent with the request 
    # + payload - A general fetch request. A filter can be applied 
    # + return - OK 
    remote isolated function listJobs(record {int endRow?; record {}? oldValues?; string operationType?; int startRow?; string textMatchStyle?; record {string _constructor?; string operator?; record {string fieldName?; string operator?; string value?;}[] criteria?;} data?;} payload, map<string|string[]> headers = {}) returns oas:ListJSTResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListJSTResponse|error r = oasClient->listJobs(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listJobs(payload, headers);
        }
        return r;
    }

    # List KV Tables
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listKvTables(map<string|string[]> headers = {}) returns oas:ListKVTablesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListKVTablesResponse|error r = oasClient->listKvTables(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listKvTables(headers);
        }
        return r;
    }

    # List Libraries
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLibraries(map<string|string[]> headers = {}) returns oas:ListLibrariesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLibrariesResponse|error r = oasClient->listLibraries(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLibraries(headers);
        }
        return r;
    }

    # List Live Price Grid Items
    #
    # + id - The `id` of the Live Price Grid you want to retrieve items for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listLivePriceGridItems(string id, oas:ListLivePriceGridItemsRequest payload, map<string|string[]> headers = {}) returns oas:ListLivePriceGridItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLivePriceGridItemsResponse|error r = oasClient->listLivePriceGridItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLivePriceGridItems(id, payload, headers);
        }
        return r;
    }

    # List Live Price Grid Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLivePriceGridTypes(map<string|string[]> headers = {}) returns oas:ListLivePriceGridTypesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLivePriceGridTypesEnvelope|error r = oasClient->listLivePriceGridTypes(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLivePriceGridTypes(headers);
        }
        return r;
    }

    # List Live Price Grids
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listLivePriceGrids(oas:ListLivePriceGridsRequest payload, map<string|string[]> headers = {}) returns oas:ListLivePriceGridsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLivePriceGridsResponse|error r = oasClient->listLivePriceGrids(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLivePriceGrids(payload, headers);
        }
        return r;
    }

    # List Logic Parameters (Input Fields)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to list parameters for. If omitted, the logic as specified in the product’s master is used, otherwise the passed logic is used
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLogicParametersInput(string uniqueName, map<string|string[]> headers = {}) returns oas:ListLogicInputFieldsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLogicInputFieldsResponse|error r = oasClient->listLogicParametersInput(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLogicParametersInput(uniqueName, headers);
        }
        return r;
    }

    # List Logics
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLogics(map<string|string[]> headers = {}) returns oas:ListLogicsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLogicsResponse|error r = oasClient->listLogics(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLogics(headers);
        }
        return r;
    }

    # List Logins
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listLogins(oas:BdmanagerListtypedIdBody payload, map<string|string[]> headers = {}) returns oas:ListLoginsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListLoginsEnvelope|error r = oasClient->listLogins(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listLogins(payload, headers);
        }
        return r;
    }

    # List Products From a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to retrieve products from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listManualPriceListProducts(string id, oas:ListProductsFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:ListProductsFromManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListProductsFromManualPriceListResponse|error r = oasClient->listManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # List Manual Price Lists
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function listManualPriceLists(oas:ListManualPriceListsRequest payload, map<string|string[]> headers = {}) returns oas:ManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ManualPriceListResponse|error r = oasClient->listManualPriceLists(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listManualPriceLists(payload, headers);
        }
        return r;
    }

    # List Model Logic Parameters
    #
    # + typedId - The `typedId` of the Model Object you want to retrieve logic parameters for
    # + stepName - The name of the step you want to list logic parameters for
    # + formulaName - The name of the logic you want to get parameters for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listModelLogicParameters(string typedId, string stepName, string formulaName, map<string|string[]> headers = {}) returns oas:ListModelLogicParametersResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListModelLogicParametersResponse|error r = oasClient->listModelLogicParameters(typedId, stepName, formulaName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listModelLogicParameters(typedId, stepName, formulaName, headers);
        }
        return r;
    }

    # List Notifications
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listNotifications(oas:NotificationListBody payload, map<string|string[]> headers = {}) returns oas:ListNotificationsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListNotificationsEnvelope|error r = oasClient->listNotifications(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listNotifications(payload, headers);
        }
        return r;
    }

    # List Objects
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function listObjects(string typeCode, oas:ListObjectsRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->listObjects(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listObjects(typeCode, payload, headers);
        }
        return r;
    }

    # List Parallel Calculation Items
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listParallelCalculationItems(oas:ListParallelCalculationItemsRequest payload, map<string|string[]> headers = {}) returns oas:ListParallelCalculationItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListParallelCalculationItemsResponse|error r = oasClient->listParallelCalculationItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listParallelCalculationItems(payload, headers);
        }
        return r;
    }

    # List Pending Approvals
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listPendingApprovals(map<string|string[]> headers = {}) returns oas:ListPendingApprovalsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListPendingApprovalsResponse|error r = oasClient->listPendingApprovals(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listPendingApprovals(headers);
        }
        return r;
    }

    # List Price List Items
    #
    # + id - The ID of the Price List you want to retrieve items for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function listPriceListItems(string id, oas:ListPriceListItemsRequest payload, map<string|string[]> headers = {}) returns oas:PriceListItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListItemResponse|error r = oasClient->listPriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listPriceListItems(id, payload, headers);
        }
        return r;
    }

    # List Price List Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listPriceListTypes(map<string|string[]> headers = {}) returns oas:ListPriceListTypesEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListPriceListTypesEnvelope|error r = oasClient->listPriceListTypes(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listPriceListTypes(headers);
        }
        return r;
    }

    # List Price Lists
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listPriceLists(oas:ListPriceListsRequest payload, map<string|string[]> headers = {}) returns oas:ListPriceListsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListPriceListsResponse|error r = oasClient->listPriceLists(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listPriceLists(payload, headers);
        }
        return r;
    }

    # List Product Extension Objects
    #
    # + productMasterExtensionName - Enter the name of Product Extension you want to retrieve objects from. You can find the name in **Administration** > **Configuration** > **Master Data** > **Product Master Extension** or using the **/configurationmanager.get/productextension** endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - A Product Extension response 
    remote isolated function listProductExtensionObjects(string productMasterExtensionName, oas:ListProductExtensionObjectsRequest payload, map<string|string[]> headers = {}, *oas:ListProductExtensionObjectsQueries queries) returns oas:ProductExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductExtensionResponse|error r = oasClient->listProductExtensionObjects(productMasterExtensionName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listProductExtensionObjects(productMasterExtensionName, payload, headers, queries = queries);
        }
        return r;
    }

    # List Product Sets
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listProductSets(oas:ListProductSetsRequest payload, map<string|string[]> headers = {}) returns oas:ListProductSetsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListProductSetsResponse|error r = oasClient->listProductSets(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listProductSets(payload, headers);
        }
        return r;
    }

    # List Products
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns full record details 
    remote isolated function listProducts(oas:ListProductsRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->listProducts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listProducts(payload, headers);
        }
        return r;
    }

    # List Products
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listQuoteProducts(oas:ListProductsRequest1 payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->listQuoteProducts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listQuoteProducts(payload, headers);
        }
        return r;
    }

    # List Quotes
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listQuotes(oas:ListQuotesRequest payload, map<string|string[]> headers = {}) returns oas:ListQuotesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListQuotesResponse|error r = oasClient->listQuotes(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listQuotes(payload, headers);
        }
        return r;
    }

    # List Rebate Agreement Items
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listRebateAgreementItems(oas:ListRebateAgreementItemsRequest payload, map<string|string[]> headers = {}) returns oas:ListRebateAgreementItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRebateAgreementItemsResponse|error r = oasClient->listRebateAgreementItems(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRebateAgreementItems(payload, headers);
        }
        return r;
    }

    # List Rebate Agreements
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listRebateAgreements(oas:ListRebateAgreementsRequest payload, map<string|string[]> headers = {}) returns oas:ListRebateAgreementsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRebateAgreementsResponse|error r = oasClient->listRebateAgreements(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRebateAgreements(payload, headers);
        }
        return r;
    }

    # List Rebate Calculations
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listRebateCalculations(oas:FetchRRSCBody payload, map<string|string[]> headers = {}) returns oas:ListRebateCalculationsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRebateCalculationsResponse|error r = oasClient->listRebateCalculations(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRebateCalculations(payload, headers);
        }
        return r;
    }

    # List Recommendations
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listRecommendations(oas:ListRecommendationsRequest payload, map<string|string[]> headers = {}) returns oas:ListRecommendationsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRecommendationsEnvelope|error r = oasClient->listRecommendations(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRecommendations(payload, headers);
        }
        return r;
    }

    # List Roles of the Business Role
    #
    # + businessroleId - The ID of the business role you want to retrieve user roles for. The `businessroleId` is the `typedId` without the `BR` suffix. For example, `businessroleId` of the **53.BR** is **53**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRolesOfBusinessRole(string businessroleId, map<string|string[]> headers = {}) returns oas:ListRolesOfBusinessRoleResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRolesOfBusinessRoleResponse|error r = oasClient->listRolesOfBusinessRole(businessroleId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRolesOfBusinessRole(businessroleId, headers);
        }
        return r;
    }

    # List Rollups
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listRollups(oas:ListRollupsRequest payload, map<string|string[]> headers = {}) returns oas:ListRollupsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListRollupsResponse|error r = oasClient->listRollups(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listRollups(payload, headers);
        }
        return r;
    }

    # List Security & Configuration Events
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listSecurityConfigurationEvents(oas:NotificationListBody payload, map<string|string[]> headers = {}) returns oas:ListSecurityConfigEventsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListSecurityConfigEventsEnvelope|error r = oasClient->listSecurityConfigurationEvents(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listSecurityConfigurationEvents(payload, headers);
        }
        return r;
    }

    # List Seller Extensions
    #
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listSellerExtensions(string sXCategory, map<string|string[]> headers = {}) returns oas:SellerExtensionEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:SellerExtensionEnvelope|error r = oasClient->listSellerExtensions(sXCategory, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listSellerExtensions(sXCategory, headers);
        }
        return r;
    }

    # List Sellers
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listSellers(oas:ListSellersRequest payload, map<string|string[]> headers = {}) returns oas:ListSellersEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListSellersEnvelope|error r = oasClient->listSellers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listSellers(payload, headers);
        }
        return r;
    }

    # List Tasks
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function listTasks(map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->listTasks(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listTasks(headers);
        }
        return r;
    }

    # List Type Codes
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listTypeCodes(map<string|string[]> headers = {}) returns oas:TypeCodesResponse|error? {
        oas:Client oasClient = self.getOasClient();
        oas:TypeCodesResponse|error? r = oasClient->listTypeCodes(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listTypeCodes(headers);
        }
        return r;
    }

    # List Unique CLIC Items
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function listUniqueClicItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ListUniqueCLICItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUniqueCLICItemsResponse|error r = oasClient->listUniqueClicItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUniqueClicItems(typedId, payload, headers);
        }
        return r;
    }

    # List User's Business Roles
    #
    # + userId - The ID of the user you want to retrieve business roles for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSBusinessRoles(string userId, map<string|string[]> headers = {}) returns oas:ListUserBusinessRolesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUserBusinessRolesResponse|error r = oasClient->listUserSBusinessRoles(userId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUserSBusinessRoles(userId, headers);
        }
        return r;
    }

    # List User's Pending Approvals
    #
    # + loginName - The login name of the user you want to retrieve Pending Workflows for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSPendingApprovals(string loginName, map<string|string[]> headers = {}) returns oas:ListUserPendingApprovalsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUserPendingApprovalsResponse|error r = oasClient->listUserSPendingApprovals(loginName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUserSPendingApprovals(loginName, headers);
        }
        return r;
    }

    # List User's Roles
    #
    # + userId - The ID of the user you want to retrieve roles for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSRoles(string userId, map<string|string[]> headers = {}) returns oas:ListUserRolesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUserRolesResponse|error r = oasClient->listUserSRoles(userId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUserSRoles(userId, headers);
        }
        return r;
    }

    # List User's User Groups
    #
    # + userId - The ID of the user you want to retrieve groups for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSUserGroups(string userId, map<string|string[]> headers = {}) returns oas:ListUsersUserGroupsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUsersUserGroupsResponse|error r = oasClient->listUserSUserGroups(userId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUserSUserGroups(userId, headers);
        }
        return r;
    }

    # List Users
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listUsers(oas:ListUsersRequest payload, map<string|string[]> headers = {}) returns oas:ListUsersResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListUsersResponse|error r = oasClient->listUsers(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listUsers(payload, headers);
        }
        return r;
    }

    # List Workflows
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function listWorkflows(oas:ListWorkflowsRequest payload, map<string|string[]> headers = {}) returns oas:ListWorkflowsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ListWorkflowsResponse|error r = oasClient->listWorkflows(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->listWorkflows(payload, headers);
        }
        return r;
    }

    # Load Data Into FieldCollection
    #
    # + typedId - Specifies the typedId (format: `{id}.{type}`) of the FieldCollection to load data into. Type must be either `DMDS` or `DMT`
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - data loaded successfully into the DMFieldCollection 
    remote isolated function loadDataIntoFieldCollection(string typedId, oas:DatamartLoadfctypedIdBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->loadDataIntoFieldCollection(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->loadDataIntoFieldCollection(typedId, payload, headers);
        }
        return r;
    }

    # Mark as Read
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function markAsRead(record {} payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->markAsRead(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->markAsRead(payload, headers);
        }
        return r;
    }

    # Mark an Offer as Lost
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function markQuoteLost(string identifier, oas:MarkOfferAsLostRequest payload, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->markQuoteLost(identifier, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->markQuoteLost(identifier, payload, headers);
        }
        return r;
    }

    # Mass Delete Imports
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function massDeleteImports(string typedId, oas:ImportmanagerMassdeletetypedIdBody payload, map<string|string[]> headers = {}) returns oas:MassDeleteImportsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassDeleteImportsEnvelope|error r = oasClient->massDeleteImports(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massDeleteImports(typedId, payload, headers);
        }
        return r;
    }

    # Mass Delete Lookup Table Values
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function massDeleteLookupTableValues(string tableId, oas:TableIdBatchBody payload, map<string|string[]> headers = {}, *oas:MassDeleteLookupTableValuesQueries queries) returns oas:DeleteLookupTableValueResponse1|error {
        oas:Client oasClient = self.getOasClient();
        oas:DeleteLookupTableValueResponse1|error r = oasClient->massDeleteLookupTableValues(tableId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massDeleteLookupTableValues(tableId, payload, headers, queries = queries);
        }
        return r;
    }

    # Mass Edit Data Change Request Items
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function massEditDataChangeRequestItems(string id, oas:DcrmanagerAddmassopidBody payload, map<string|string[]> headers = {}) returns oas:DataChangeRequestMassChangeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataChangeRequestMassChangeEnvelope|error r = oasClient->massEditDataChangeRequestItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditDataChangeRequestItems(id, payload, headers);
        }
        return r;
    }

    # Mass Edit
    #
    # + typedId - The `typedId` of the object you want to perform the mass edit action for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - returns the number of edited records 
    remote isolated function massEditDataMartObject(string typedId, oas:MassEditRequest1 payload, map<string|string[]> headers = {}) returns oas:MassEditDatamartResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassEditDatamartResponse|error r = oasClient->massEditDataMartObject(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditDataMartObject(typedId, payload, headers);
        }
        return r;
    }

    # Mass Edit Imports
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function massEditImports(string typedId, oas:ImportmanagerMassedittypedIdBody payload, map<string|string[]> headers = {}) returns oas:MassEditImportsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassEditImportsEnvelope|error r = oasClient->massEditImports(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditImports(typedId, payload, headers);
        }
        return r;
    }

    # Mass Edit
    #
    # + tableId - The ID of the Lookup Table whose values you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - The response contains the number of modifed objects 
    remote isolated function massEditLookupTable(string tableId, oas:MassEditRequest payload, map<string|string[]> headers = {}) returns oas:MassEditResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassEditResponse|error r = oasClient->massEditLookupTable(tableId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditLookupTable(tableId, payload, headers);
        }
        return r;
    }

    # Mass Edit a Manual Price List Items
    #
    # + id - The ID of the Manual Price List whose products you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function massEditManualPriceListItems(string id, oas:MassEditMPLRequest payload, map<string|string[]> headers = {}) returns oas:MassEditManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassEditManualPriceListResponse|error r = oasClient->massEditManualPriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditManualPriceListItems(id, payload, headers);
        }
        return r;
    }

    # Mass Edit Price Grid Items
    #
    # + id - The `id` of the Live Price Grid whose items you want to edit. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - The response contains `"data":null` as the mass edit task is a background process whose results are not yet available within the response time 
    remote isolated function massEditPriceGridItems(string id, oas:MassEditPriceGridItemsRequest payload, map<string|string[]> headers = {}) returns oas:MassEditPriceGridItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassEditPriceGridItemsResponse|error r = oasClient->massEditPriceGridItems(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massEditPriceGridItems(id, payload, headers);
        }
        return r;
    }

    # Mass Submit Rebate Record Groups
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function massSubmitRebateRecordGroupItems(string typedId, oas:RebaterecordgroupMasssubmittypedIdBody payload, map<string|string[]> headers = {}) returns oas:MassSubmitRRGResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassSubmitRRGResponse|error r = oasClient->massSubmitRebateRecordGroupItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massSubmitRebateRecordGroupItems(typedId, payload, headers);
        }
        return r;
    }

    # Mass Submit Rebate Record Groups
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function massSubmitRebateRecordGroups(oas:RebaterecordgroupMasssubmittypedIdBody payload, map<string|string[]> headers = {}) returns oas:MassSubmitRebateRecordGroupsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassSubmitRebateRecordGroupsEnvelope|error r = oasClient->massSubmitRebateRecordGroups(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massSubmitRebateRecordGroups(payload, headers);
        }
        return r;
    }

    # Mass Update
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function massUpdate(string typeCode, oas:MassUpdateRequest payload, map<string|string[]> headers = {}) returns oas:MassUpdateResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:MassUpdateResponse|error r = oasClient->massUpdate(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->massUpdate(typeCode, payload, headers);
        }
        return r;
    }

    # Perform a Mass Action
    #
    # + id - The ID of the Price Grid that contains items you want to apply workflow actions to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function performMassAction(string id, oas:PerformMassActionRequest payload, map<string|string[]> headers = {}) returns oas:PerformMassActionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PerformMassActionResponse|error r = oasClient->performMassAction(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->performMassAction(id, payload, headers);
        }
        return r;
    }

    # Ping (without authentication)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - Partition is exists 
    remote isolated function pingWithout(map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->pingWithout(headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->pingWithout(headers);
        }
        return r;
    }

    # Preview a Custom Form Workflow
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function previewCustomFormWorkflow(record {} payload, map<string|string[]> headers = {}) returns oas:PreviewCustomFormWorkflowResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PreviewCustomFormWorkflowResponse|error r = oasClient->previewCustomFormWorkflow(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->previewCustomFormWorkflow(payload, headers);
        }
        return r;
    }

    # Preview a Rebate Record Group Workflow
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + payload - Request payload
    # + return - OK 
    remote isolated function previewRebateRecordGroupWorkflow(string typedId, oas:RebaterecordgroupPreviewtypedIdBody payload, map<string|string[]> headers = {}) returns oas:RebateRecordGroupWorkflowEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:RebateRecordGroupWorkflowEnvelope|error r = oasClient->previewRebateRecordGroupWorkflow(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->previewRebateRecordGroupWorkflow(typedId, payload, headers);
        }
        return r;
    }

    # Query API Execute
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - Successful execution 
    remote isolated function queryApiExecute(oas:QueryapiExecuteBody payload, map<string|string[]> headers = {}, *oas:QueryApiExecuteQueries queries) returns oas:QueryApiExecuteEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:QueryApiExecuteEnvelope|error r = oasClient->queryApiExecute(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->queryApiExecute(payload, headers, queries = queries);
        }
        return r;
    }

    # Query a Data Manager Object
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function queryDataManagerObject(oas:QueryDataManagerObjectRequest payload, map<string|string[]> headers = {}, *oas:QueryDataManagerObjectQueries queries) returns oas:QueryDataManagerObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QueryDataManagerObjectResponse|error r = oasClient->queryDataManagerObject(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->queryDataManagerObject(payload, headers, queries = queries);
        }
        return r;
    }

    # Recalculate a Calculation of a Step
    #
    # + typedId - The `typedId` of the Model Object you want to recalculate the step for
    # + stepName - Enter the name of the step you want to calculate
    # + calcName - The name of the calculation you want to recalculate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function recalculateCalculationOfStep(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, string calcName, record {} payload, map<string|string[]> headers = {}) returns oas:RecalculateCalculationOfStepResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RecalculateCalculationOfStepResponse|error r = oasClient->recalculateCalculationOfStep(typedId, stepName, calcName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->recalculateCalculationOfStep(typedId, stepName, calcName, payload, headers);
        }
        return r;
    }

    # Recalculate Items of a Parallel Calculation
    #
    # + typedId - The `typedId` of the Model Object you want to recalculate the step for
    # + stepName - Enter the name of the step you want to calculate
    # + calcName - The name of the calculation you want to recalculate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function recalculateItemsOfParallelCalculation(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, string calcName, oas:CalcNameItemBody payload, map<string|string[]> headers = {}) returns oas:ParallelCalculationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ParallelCalculationEnvelope|error r = oasClient->recalculateItemsOfParallelCalculation(typedId, stepName, calcName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->recalculateItemsOfParallelCalculation(typedId, stepName, calcName, payload, headers);
        }
        return r;
    }

    # Recalculate a Quote
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function recalculateQuote(oas:RecalculateQuoteRequest payload, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->recalculateQuote(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->recalculateQuote(payload, headers);
        }
        return r;
    }

    # Recalculate a Quote/Contract/Rebate Agreement/Compensation Plan
    #
    # + typedId - The `typedId` of the document you want to calculate
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function recalculateQuoteContractRebate(string typedId, map<string|string[]> headers = {}, *oas:RecalculateQuoteContractRebateQueries queries) returns oas:RecalculateClicEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:RecalculateClicEnvelope|error r = oasClient->recalculateQuoteContractRebate(typedId, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->recalculateQuoteContractRebate(typedId, headers, queries = queries);
        }
        return r;
    }

    # Deny a Calculation Grid Item
    #
    # + id - The `id` of the Calculation Grid you want to deny items for. You can retrieve the `id` of the CG, for example, by calling the `/fetch/CG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function rejectCalculationGridItem(string id, oas:DenyCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns oas:DenyCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DenyCalculationGridItemResponse|error r = oasClient->rejectCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->rejectCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Reject Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to reject
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function rejectItems(string typedId, oas:RejectClaimItemsRequest payload, map<string|string[]> headers = {}) returns oas:RejectClaimItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RejectClaimItemsResponse|error r = oasClient->rejectItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->rejectItems(typedId, payload, headers);
        }
        return r;
    }

    # Delete All Line Items
    #
    # + typedId - `typedId` of the object you want to remove all line items from
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function removeAllClicLineItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ClicOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicOperationEnvelope|error r = oasClient->removeAllClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->removeAllClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Remove Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to remove
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function removeItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:RemoveClaimItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RemoveClaimItemsResponse|error r = oasClient->removeItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->removeItems(typedId, payload, headers);
        }
        return r;
    }

    # Reply To a Comment
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function replyToComment(oas:CommentmanagerReplyBody payload, map<string|string[]> headers = {}) returns oas:CommentOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CommentOperationEnvelope|error r = oasClient->replyToComment(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->replyToComment(payload, headers);
        }
        return r;
    }

    # Resolve a Comment
    #
    # + typedId - The typedId of the comment thread
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function resolveComment(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ResolveCommentEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ResolveCommentEnvelope|error r = oasClient->resolveComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->resolveComment(typedId, payload, headers);
        }
        return r;
    }

    # Restore Default Data Sources
    #
    # + dataSourceName - The name of the Data Source you want to create. 
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function restoreDefaultDataSources("Product"|"Customer"|"uom"|"ccy"|"cal" dataSourceName, map<string|string[]> headers = {}) returns oas:RestoreDefaultDataSourcesResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RestoreDefaultDataSourcesResponse|error r = oasClient->restoreDefaultDataSources(dataSourceName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->restoreDefaultDataSources(dataSourceName, headers);
        }
        return r;
    }

    # Revoke a Compensation Record
    #
    # + typedId - `typedId` of the Compensation Record you want to revoke
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function revokeCompensationRecord(string typedId, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->revokeCompensationRecord(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->revokeCompensationRecord(typedId, headers);
        }
        return r;
    }

    # Revoke a Model
    #
    # + typedId - `typedId` of the model you want to revoke
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function revokeModel(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:RevokeModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RevokeModelResponse|error r = oasClient->revokeModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->revokeModel(typedId, payload, headers);
        }
        return r;
    }

    # Revoke a Price List
    #
    # + headers - Headers to be sent with the request 
    # + id - The id to be sent with the request
    # + payload - Request payload
    # + return - Example response 
    remote isolated function revokePriceList(string id, oas:PricelistmanagerSubmitidBody payload, map<string|string[]> headers = {}) returns oas:PriceListItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListItemResponse|error r = oasClient->revokePriceList(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->revokePriceList(id, payload, headers);
        }
        return r;
    }

    # Revoke a Deal
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function revokeQuote(string identifier, map<string|string[]> headers = {}) returns oas:RevokeDealResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RevokeDealResponse|error r = oasClient->revokeQuote(identifier, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->revokeQuote(identifier, headers);
        }
        return r;
    }

    # Revoke a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to revoke
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function revokeRebateRecordGroup(string typedId, map<string|string[]> headers = {}) returns oas:RevokeRebateRecordGroupEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:RevokeRebateRecordGroupEnvelope|error r = oasClient->revokeRebateRecordGroup(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->revokeRebateRecordGroup(typedId, headers);
        }
        return r;
    }

    # Run a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function runCalculation(oas:RunCalculationRequest payload, map<string|string[]> headers = {}) returns oas:RunCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RunCalculationResponse|error r = oasClient->runCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->runCalculation(payload, headers);
        }
        return r;
    }

    # Run a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function runDataLoad(oas:RunDataLoadRequest payload, map<string|string[]> headers = {}) returns oas:RunDataLoadResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RunDataLoadResponse|error r = oasClient->runDataLoad(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->runDataLoad(payload, headers);
        }
        return r;
    }

    # Run a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function runRebateCalculation(oas:RebaterecordCalculatesetBody payload, map<string|string[]> headers = {}) returns oas:RunRebateCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RunRebateCalculationResponse|error r = oasClient->runRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->runRebateCalculation(payload, headers);
        }
        return r;
    }

    # Save Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveCalculation(oas:SaveCalculationRequest payload, map<string|string[]> headers = {}) returns oas:SaveCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveCalculationResponse|error r = oasClient->saveCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveCalculation(payload, headers);
        }
        return r;
    }

    # Save a Temporary Data
    #
    # + typedId - `typedId` of the Temporary Quote you want to save
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveClicDraft(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ClicOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ClicOperationEnvelope|error r = oasClient->saveClicDraft(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveClicDraft(typedId, payload, headers);
        }
        return r;
    }

    # Save a Compensation Record
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveCompensationRecord(oas:SaveCompensationRecordRequest payload, map<string|string[]> headers = {}) returns oas:SaveCompensationRecordResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveCompensationRecordResponse|error r = oasClient->saveCompensationRecord(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveCompensationRecord(payload, headers);
        }
        return r;
    }

    # Save a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveDataLoad(oas:DatamartUpdatedataloadBody payload, map<string|string[]> headers = {}) returns oas:DataLoadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataLoadEnvelope|error r = oasClient->saveDataLoad(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveDataLoad(payload, headers);
        }
        return r;
    }

    # Save Import Change
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveImportChange(record {} payload, map<string|string[]> headers = {}) returns oas:SaveImportChangeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveImportChangeEnvelope|error r = oasClient->saveImportChange(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveImportChange(payload, headers);
        }
        return r;
    }

    # Save a Model
    #
    # + typedId - The `typedId` of the Model Object you want to save
    # + stepName - Enter the name of the step you want to save. Steps are defined in the Model Class that is associated to the Model Object
    # + headers - Headers to be sent with the request 
    # + payload - The `data` property can only contain the `state` field, all the rest fields will be ignored (and cannot be updated even with update/MO endpoint) 
    # + return - OK. Returns the updated Model Object 
    remote isolated function saveModel(string typedId, "definition"|"configuration"|"results"|"projections" stepName, oas:SaveModelRequest payload, map<string|string[]> headers = {}) returns oas:SaveModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveModelResponse|error r = oasClient->saveModel(typedId, stepName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveModel(typedId, stepName, payload, headers);
        }
        return r;
    }

    # Save a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function saveRebateCalculation(oas:SaveRebateCalculationRequest payload, map<string|string[]> headers = {}) returns oas:SaveRebateCalculationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveRebateCalculationResponse|error r = oasClient->saveRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->saveRebateCalculation(payload, headers);
        }
        return r;
    }

    # Search a KV Table
    #
    # + tableName - A name of the table you want to search the pattern for
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function searchKvTable(string tableName, oas:SearchKVTableRequest payload, map<string|string[]> headers = {}) returns oas:SearchKvTableEnvelope[]|error {
        oas:Client oasClient = self.getOasClient();
        oas:SearchKvTableEnvelope[]|error r = oasClient->searchKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->searchKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Search a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function searchProducts(oas:SearchProductRequest payload, map<string|string[]> headers = {}) returns oas:SearchProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SearchProductResponse|error r = oasClient->searchProducts(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->searchProducts(payload, headers);
        }
        return r;
    }

    # Search a Product (URL)
    #
    # + headers - Headers to be sent with the request 
    # + query - The query to be sent with the request
    # + return - OK 
    remote isolated function searchProductsByQuery(string query, map<string|string[]> headers = {}) returns oas:SearchProductURLResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SearchProductURLResponse|error r = oasClient->searchProductsByQuery(query, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->searchProductsByQuery(query, headers);
        }
        return r;
    }

    # Send a Document to Sign
    #
    # + typedId - `typedId` of the Compensation whose data you want to send via the e-signature system
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function sendDocumentToSign(string typedId, oas:CreateSignatureRequest payload, map<string|string[]> headers = {}) returns oas:CreateSignatureResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CreateSignatureResponse|error r = oasClient->sendDocumentToSign(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->sendDocumentToSign(typedId, payload, headers);
        }
        return r;
    }

    # Send an Email
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function sendEmail(oas:SendEmailRequest payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->sendEmail(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->sendEmail(payload, headers);
        }
        return r;
    }

    # Send a Validation Message
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function sendValidationMessage(oas:NotificationSendBody payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->sendValidationMessage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->sendValidationMessage(payload, headers);
        }
        return r;
    }

    # Mark an Offer as Lost (with reason)
    #
    # + typedId - `typedId` of the Quote you want set as lost
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function setClicLostReason(string typedId, oas:MarkOfferLostWithReasonRequest payload, map<string|string[]> headers = {}) returns oas:SetClicLostReasonEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:SetClicLostReasonEnvelope|error r = oasClient->setClicLostReason(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->setClicLostReason(typedId, payload, headers);
        }
        return r;
    }

    # Set a Default Pricing Logic
    #
    # + uniqueName - The name (`uniqueName`) of the logic that will be set as default. Leave blank to clear the default pricing logic
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function setDefaultPricingLogic(string uniqueName, map<string|string[]> headers = {}) returns oas:SetDefaultPricingLogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SetDefaultPricingLogicResponse|error r = oasClient->setDefaultPricingLogic(uniqueName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->setDefaultPricingLogic(uniqueName, headers);
        }
        return r;
    }

    # Set a Review as Done
    #
    # + typedId - typedId of the object to mark as reviewed
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Review successfully marked as done 
    remote isolated function setReviewAsDone(string typedId, record {} payload, map<string|string[]> headers = {}) returns http:Response|error {
        oas:Client oasClient = self.getOasClient();
        http:Response|error r = oasClient->setReviewAsDone(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->setReviewAsDone(typedId, payload, headers);
        }
        return r;
    }

    # Should Submit a RRG Asynchronously
    #
    # + typedId - `typedId` of the Rebate Record Group you want to return the async threshold boolean for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function shouldSubmitRrgAsynchronously(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:CheckFileExistsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:CheckFileExistsEnvelope|error r = oasClient->shouldSubmitRrgAsynchronously(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->shouldSubmitRrgAsynchronously(typedId, payload, headers);
        }
        return r;
    }

    # SQL Query a Data Manager Object
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - `sources` that SQL can use are query definitions. The sources become CTEs (Common Table Expression) in the final SQL. These are then used as a reference in the main query instead of referring to the actual tables directly. The request example compares the volume by month 2019 to 2020 
    # + return - OK 
    remote isolated function sqlQueryDataManagerObject(oas:DatamartSqlqueryBody payload, map<string|string[]> headers = {}, *oas:SqlQueryDataManagerObjectQueries queries) returns oas:QueryDataManagerObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QueryDataManagerObjectResponse|error r = oasClient->sqlQueryDataManagerObject(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->sqlQueryDataManagerObject(payload, headers, queries = queries);
        }
        return r;
    }

    # Submit Changes
    #
    # + typedId - typedId of the import
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitChanges(string typedId, oas:ImportmanagerSubmittypedIdBody payload, map<string|string[]> headers = {}) returns oas:ImportManagerUploadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ImportManagerUploadEnvelope|error r = oasClient->submitChanges(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitChanges(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Claim
    #
    # + typedId - `typedId` of the Claim you want to submit
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitClaim(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:SubmitClaimResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitClaimResponse|error r = oasClient->submitClaim(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitClaim(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Quote/Contract/Rebate Agreement
    #
    # + typedId - The `typedId` of the Contract, Quote, or Rebate Agreement you want to submit
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitClic(string typedId, oas:SubmitQuoteContractRebateAgreementRequest payload, map<string|string[]> headers = {}) returns oas:SubmitQuoteContractRebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitQuoteContractRebateAgreementResponse|error r = oasClient->submitClic(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitClic(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Contract
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function submitContract(oas:SubmitContractRequest payload, map<string|string[]> headers = {}) returns oas:ContractModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ContractModelResponse|error r = oasClient->submitContract(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitContract(payload, headers);
        }
        return r;
    }

    # Submit a Data Change Request
    #
    # + id - `id` of the DCR to be submitted
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitDataChangeRequest(string id, record {} payload, map<string|string[]> headers = {}) returns oas:SubmitDCRResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitDCRResponse|error r = oasClient->submitDataChangeRequest(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitDataChangeRequest(id, payload, headers);
        }
        return r;
    }

    # Submit a Data Change Request (async)
    #
    # + id - `id` of the DCR to be submitted
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitDataChangeRequestAsync(string id, record {} payload, map<string|string[]> headers = {}) returns oas:SubmitDCRAsyncResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitDCRAsyncResponse|error r = oasClient->submitDataChangeRequestAsync(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitDataChangeRequestAsync(id, payload, headers);
        }
        return r;
    }

    # Submit a Model
    #
    # + typedId - The `typedId` of the Model Object you want to submit
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK. Returns the Model Object 
    remote isolated function submitModel(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:SaveModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SaveModelResponse|error r = oasClient->submitModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitModel(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Price List
    #
    # + id - The ID of the Price List you want to submit. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function submitPriceList(string id, oas:PricelistmanagerSubmitidBody payload, map<string|string[]> headers = {}) returns oas:PriceListItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListItemResponse|error r = oasClient->submitPriceList(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitPriceList(id, payload, headers);
        }
        return r;
    }

    # Submit Products
    #
    # + id - The `id` of the Live Price Grid you want to submit items for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK - In case that more than one item is passed in the request, the body will not contain any data (`"data":null`). For a single item, the new PriceGridItem object is returned 
    remote isolated function submitProducts(string id, oas:SubmitProductsRequest payload, map<string|string[]> headers = {}) returns oas:SubmitProductsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitProductsResponse|error r = oasClient->submitProducts(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitProducts(id, payload, headers);
        }
        return r;
    }

    # Submit a Quote
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function submitQuote(oas:SubmitQuoteRequest payload, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->submitQuote(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitQuote(payload, headers);
        }
        return r;
    }

    # Submit a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to submit
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function submitRebateRecordGroup(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:SubmitRebateRecordGroup|error {
        oas:Client oasClient = self.getOasClient();
        oas:SubmitRebateRecordGroup|error r = oasClient->submitRebateRecordGroup(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->submitRebateRecordGroup(typedId, payload, headers);
        }
        return r;
    }

    # Syntax Check
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function syntaxCheck(oas:SyntaxCheckRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->syntaxCheck(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->syntaxCheck(payload, headers);
        }
        return r;
    }

    # Test a Logic
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function testLogic(oas:TestLogicRequest payload, map<string|string[]> headers = {}) returns oas:TestLogicEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:TestLogicEnvelope|error r = oasClient->testLogic(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->testLogic(payload, headers);
        }
        return r;
    }

    # Truncate a Table
    #
    # + tableName - The table you want to remove the keys from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function truncateTable(string tableName, map<string|string[]> headers = {}) returns oas:TruncateKVTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:TruncateKVTableResponse|error r = oasClient->truncateTable(tableName, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->truncateTable(tableName, headers);
        }
        return r;
    }

    # Undo Compensation Plan Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoCompensationPlanRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoCompensationPlanRevocation(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoCompensationPlanRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Compensation Record Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoCompensationRecordRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoCompensationRecordRevocation(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoCompensationRecordRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Agreement Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoRebateAgreementRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoRebateAgreementRevocation(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoRebateAgreementRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Record Group Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoRebateRecordGroupRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoRebateRecordGroupRevocation(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoRebateRecordGroupRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Record Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoRebateRecordRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoRebateRecordRevocation(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoRebateRecordRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Agreement & Promotion Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoRevokeContract(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoRevokeContract(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoRevokeContract(typedId, headers);
        }
        return r;
    }

    # Undo Quote Revocation
    #
    # + headers - Headers to be sent with the request 
    # + typedId - The typedId to be sent with the request
    # + return - OK 
    remote isolated function undoRevokeQuote(string typedId, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->undoRevokeQuote(typedId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->undoRevokeQuote(typedId, headers);
        }
        return r;
    }

    # Unresolve a Comment
    #
    # + typedId - The typedId of the comment thread
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function unresolveComment(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:ResolveCommentEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ResolveCommentEnvelope|error r = oasClient->unresolveComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->unresolveComment(typedId, payload, headers);
        }
        return r;
    }

    # Update an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateActionItem(oas:UpdateActionItemRequest payload, map<string|string[]> headers = {}) returns oas:UpdateActionItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateActionItemResponse|error r = oasClient->updateActionItem(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateActionItem(payload, headers);
        }
        return r;
    }

    # Update an Action Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateActionType(oas:UpdateAITBody payload, map<string|string[]> headers = {}) returns oas:UpdateActionTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateActionTypeResponse|error r = oasClient->updateActionType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateActionType(payload, headers);
        }
        return r;
    }

    # Update a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateCalculationGrid(oas:UpdateCalculationGridRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCalculationGridResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCalculationGridResponse|error r = oasClient->updateCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCalculationGrid(payload, headers);
        }
        return r;
    }

    # Update a Calculation Grid Item
    #
    # + id - `id` of the Calculation Grid Item you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateCalculationGridItem(string id, oas:UpdateCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCalculationGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCalculationGridItemResponse|error r = oasClient->updateCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Update a Claim
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateClaim(oas:UpdateClaimRequest payload, map<string|string[]> headers = {}) returns oas:UpdateClaimResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateClaimResponse|error r = oasClient->updateClaim(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateClaim(payload, headers);
        }
        return r;
    }

    # Update a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateClaimType(oas:UpdateClaimTypeRequest payload, map<string|string[]> headers = {}) returns oas:UpdateClaimTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateClaimTypeResponse|error r = oasClient->updateClaimType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateClaimType(payload, headers);
        }
        return r;
    }

    # Update CLIC Line Items
    #
    # + typedId - `typedId` of the CLIC object (e.g., a Quote) you want to update line items for
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateClicLineItems(string typedId, oas:UpdateCLICLineItemsRequest payload, map<string|string[]> headers = {}) returns oas:UpdateClicLineItemsEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateClicLineItemsEnvelope|error r = oasClient->updateClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Update a Compensation Record
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateCompensationRecord(oas:UpdateCompensationRecordRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCompensationRecordResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCompensationRecordResponse|error r = oasClient->updateCompensationRecord(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCompensationRecord(payload, headers);
        }
        return r;
    }

    # Update a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateCompensationType(oas:UpdateCompensationTypeRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCompensationTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCompensationTypeEnvelope|error r = oasClient->updateCompensationType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCompensationType(payload, headers);
        }
        return r;
    }

    # Update a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateConditionRecordItemMeta(oas:UpdateCRCIMBody payload, map<string|string[]> headers = {}) returns oas:UpdateConditionRecordItemMetaEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateConditionRecordItemMetaEnvelope|error r = oasClient->updateConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Update a Condition Record Set
    #
    # + id - `id` of the ConditionRecordSet object you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateConditionRecordSet(string id, oas:ConditionrecordsetUpdateidBody payload, map<string|string[]> headers = {}) returns oas:ConditionRecordSetOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConditionRecordSetOperationEnvelope|error r = oasClient->updateConditionRecordSet(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateConditionRecordSet(id, payload, headers);
        }
        return r;
    }

    # Update a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateConditionType(oas:UpdateConditionTypeRequest payload, map<string|string[]> headers = {}) returns oas:UpdateConditionTypeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateConditionTypeEnvelope|error r = oasClient->updateConditionType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateConditionType(payload, headers);
        }
        return r;
    }

    # Update a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateConfigurationStorage(oas:UpdateJCSBody payload, map<string|string[]> headers = {}) returns oas:ConfigurationStorageOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ConfigurationStorageOperationEnvelope|error r = oasClient->updateConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Update a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - The Custom Form was updated successfully. The response includes the updated data 
    remote isolated function updateCustomForm(oas:UpdateCustomFormRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCustomFormEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCustomFormEnvelope|error r = oasClient->updateCustomForm(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCustomForm(payload, headers);
        }
        return r;
    }

    # Update a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateCustomFormType(oas:UpdateCustomFormTypeRequest payload, map<string|string[]> headers = {}) returns oas:UpdateCustomFormTypeResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateCustomFormTypeResponse|error r = oasClient->updateCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCustomFormType(payload, headers);
        }
        return r;
    }

    # Update a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Returns customer record details 
    remote isolated function updateCustomer(oas:UpdateCustomerRequest payload, map<string|string[]> headers = {}) returns oas:CustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomerResponse|error r = oasClient->updateCustomer(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateCustomer(payload, headers);
        }
        return r;
    }

    # Update a Data Change Request Item
    #
    # + id - `id` of the Data Change Request whose item you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateDataChangeRequestItem(string id, oas:UpdateDCRIRequest payload, map<string|string[]> headers = {}) returns oas:UpdateDCRIResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateDCRIResponse|error r = oasClient->updateDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Update Data Change Request Mass Changes
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateDataChangeRequestMassChanges(string id, oas:DcrmanagerUpdatemassopidBody payload, map<string|string[]> headers = {}) returns oas:DataChangeRequestMassChangeEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:DataChangeRequestMassChangeEnvelope|error r = oasClient->updateDataChangeRequestMassChanges(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateDataChangeRequestMassChanges(id, payload, headers);
        }
        return r;
    }

    # Update a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Either `uniqueName` or `typedId` must be provided in the request 
    # + return - Example response 
    remote isolated function updateDataManagerEntity("DMF"|"DM"|"DMDS" typeCode, oas:UpdateDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns oas:DmObjectResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:DmObjectResponse|error r = oasClient->updateDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Update a File
    #
    # + typedId - `typedId` of the document whose attachment's metadata you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateFile(string typedId, oas:BdmanagerUpdatetypedIdBody payload, map<string|string[]> headers = {}) returns oas:UpdateFileEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateFileEnvelope|error r = oasClient->updateFile(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateFile(typedId, payload, headers);
        }
        return r;
    }

    # Update Job Status Tracker Entry
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - JST updated 
    remote isolated function updateJobStatusTrackerEntry(oas:OptimizationUpdatejstBody payload, map<string|string[]> headers = {}) returns oas:JobStatusTrackerUpdateEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:JobStatusTrackerUpdateEnvelope|error r = oasClient->updateJobStatusTrackerEntry(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateJobStatusTrackerEntry(payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Item
    #
    # + id - The ID of the Price Grid whose item you want to update. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - We have performed an update action on the `comments` field in our request sample >>> 
    # + return - Example response 
    remote isolated function updateLivePriceGridItem(string id, oas:UpdateLivePriceGridItemRequest payload, map<string|string[]> headers = {}) returns oas:PriceGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceGridItemResponse|error r = oasClient->updateLivePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLivePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Item (No Recalculation)
    #
    # + id - The ID of the Price Grid whose item you want to update. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - We have performed an update action on the `comments` field in our request sample >>> 
    # + return - Example response 
    remote isolated function updateLivePriceGridItemNo(string id, oas:UpdateLivePriceGridItemNoRecalcRequest payload, map<string|string[]> headers = {}) returns oas:PriceGridItemResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceGridItemResponse|error r = oasClient->updateLivePriceGridItemNo(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLivePriceGridItemNo(id, payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateLivePriceGridType(oas:UpdatePGTTBody payload, map<string|string[]> headers = {}) returns oas:LivePriceGridTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:LivePriceGridTypeOperationEnvelope|error r = oasClient->updateLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Update a Logic
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function updateLogic(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns oas:LogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LogicResponse|error r = oasClient->updateLogic(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLogic(id, payload, headers);
        }
        return r;
    }

    # Update a Logic (No syntax check)
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function updateLogicNo(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns oas:LogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LogicResponse|error r = oasClient->updateLogicNo(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLogicNo(id, payload, headers);
        }
        return r;
    }

    # Update a Logic (Partial)
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function updateLogicPartial(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns oas:LogicResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:LogicResponse|error r = oasClient->updateLogicPartial(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLogicPartial(id, payload, headers);
        }
        return r;
    }

    # Update a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateLookupTable(oas:UpdateLookupTableRequest payload, map<string|string[]> headers = {}) returns oas:UpdateLookupTableResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateLookupTableResponse|error r = oasClient->updateLookupTable(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLookupTable(payload, headers);
        }
        return r;
    }

    # Update a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateLookupTableValue(string tableId, oas:UpdateLookupTableValueRequest payload, map<string|string[]> headers = {}) returns oas:UpdateLookupTableValueResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateLookupTableValueResponse|error r = oasClient->updateLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Update a Manual Price List Item
    #
    # + id - The ID of the Manual Price List whose item you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateManualPriceListItem(string id, oas:UpdateManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:UpdateManualPriceListResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateManualPriceListResponse|error r = oasClient->updateManualPriceListItem(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateManualPriceListItem(id, payload, headers);
        }
        return r;
    }

    # Update an Object
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - <!-- theme: warning --> 
    # + return - OK - contains the updated object 
    remote isolated function updateObject(string typeCode, oas:UpdateObjectRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->updateObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateObject(typeCode, payload, headers);
        }
        return r;
    }

    # Update an Object (and return old data)
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - <!-- theme: warning --> 
    # + return - OK - contains the updated object and details of the previous version 
    remote isolated function updateObjectReturningOldData(string typeCode, oas:UpdateObjectReturnOldDataRequest payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->updateObjectReturningOldData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateObjectReturningOldData(typeCode, payload, headers);
        }
        return r;
    }

    # Update a Pricelist Detail
    #
    # + id - The ID of the Price List whose Item you want to update. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updatePriceListDetail(string id, oas:UpdatePricelistDetailRequest payload, map<string|string[]> headers = {}) returns oas:UpdatePricelistDetailResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdatePricelistDetailResponse|error r = oasClient->updatePriceListDetail(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updatePriceListDetail(id, payload, headers);
        }
        return r;
    }

    # Update a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updatePriceListType(oas:UpdatePLTTBody payload, map<string|string[]> headers = {}) returns oas:PriceListTypeOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:PriceListTypeOperationEnvelope|error r = oasClient->updatePriceListType(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updatePriceListType(payload, headers);
        }
        return r;
    }

    # Update a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Updates specified fields of the record. Only one record can be updated per request (unless batched).<p> 
    # + return - Returns full record details 
    remote isolated function updateProduct(oas:UpdateProductRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->updateProduct(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateProduct(payload, headers);
        }
        return r;
    }

    # Update a Quote/Contract/Rebate Agreement/Compensation Plan
    #
    # + typedId - The `typedId` of the Compensation Plan you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateQuoteContractRebateAgreement(string typedId, oas:ClicmanagerUpdatetypedIdBody payload, map<string|string[]> headers = {}) returns oas:UpdateClicEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateClicEnvelope|error r = oasClient->updateQuoteContractRebateAgreement(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateQuoteContractRebateAgreement(typedId, payload, headers);
        }
        return r;
    }

    # Update a Review Status
    #
    # + typedId - typedId of the object to update
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function updateReviewStatus(string typedId, record {} payload, map<string|string[]> headers = {}) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->updateReviewStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateReviewStatus(typedId, payload, headers);
        }
        return r;
    }

    # Update a Seller
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateSeller(oas:UpdateSellerRequest payload, map<string|string[]> headers = {}) returns oas:UpdateSellerEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateSellerEnvelope|error r = oasClient->updateSeller(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateSeller(payload, headers);
        }
        return r;
    }

    # Update a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateSellerExtension(oas:UpdateSXBody payload, map<string|string[]> headers = {}) returns oas:UpdateSellerExtensionEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateSellerExtensionEnvelope|error r = oasClient->updateSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateSellerExtension(payload, headers);
        }
        return r;
    }

    # Update a User
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify the user by `typedId` and define the new value of the field you want to update in the `data` object 
    # + return - Example response 
    remote isolated function updateUser(oas:UpdateUserRequest payload, map<string|string[]> headers = {}) returns oas:UserResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UserResponse|error r = oasClient->updateUser(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateUser(payload, headers);
        }
        return r;
    }

    # Update a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function updateWorkflowDelegation(oas:UpdateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns oas:UpdateWorkflowDelegationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpdateWorkflowDelegationResponse|error r = oasClient->updateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->updateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Upload a Bulk Data to Data Source
    #
    # + datasourceUniqueName - The unique name of the Data Source where you want to upload the data to. You can also use `typedId` or the source name
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function uploadBulkDataToDataSource(string datasourceUniqueName, oas:UploadBulkDataToDataSourceRequest payload, map<string|string[]> headers = {}) returns oas:BulkDataUploadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:BulkDataUploadEnvelope|error r = oasClient->uploadBulkDataToDataSource(datasourceUniqueName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->uploadBulkDataToDataSource(datasourceUniqueName, payload, headers);
        }
        return r;
    }

    # Upload Excel to Import Manager
    #
    # + typeCode - Target object type code
    # + target - Provides additional details about the target object, such as specifying a PX name if required
    # + slotId - ID of the Upload Slot
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - File uploaded successfully 
    remote isolated function uploadExcelToImportManager("P"|"PX" typeCode, string target, string slotId, oas:TypeCodetargetBody payload, map<string|string[]> headers = {}, *oas:UploadExcelToImportManagerQueries queries) returns oas:ImportManagerUploadEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:ImportManagerUploadEnvelope|error r = oasClient->uploadExcelToImportManager(typeCode, target, slotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->uploadExcelToImportManager(typeCode, target, slotId, payload, headers, queries = queries);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + typedId - `typedId` of the document you want to attach the file to
    # + slotId - The ID of the slot you want to use for the upload. retrieve the slot ID using the `/uploadmanager.newuploadslot` (Create an Upload Slot) endpoint
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function uploadFile(string typedId, string slotId, oas:TypedIdslotIdBody payload, map<string|string[]> headers = {}) returns oas:FileOperationEnvelope|error {
        oas:Client oasClient = self.getOasClient();
        oas:FileOperationEnvelope|error r = oasClient->uploadFile(typedId, slotId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->uploadFile(typedId, slotId, payload, headers);
        }
        return r;
    }

    # Upload a File to PX/CX/SX
    #
    # + typeCode - Type code of the table you want to upload the file to
    # + target - The name of the PX/CX/SX table
    # + uploadSlotId - `id` of the upload slot. Use the **uploadslotmanager.newuploadslot** endpoint to retrieve the `id`
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - Request payload
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function uploadFileToPxCxSx("PX"|"CX"|"SX" typeCode, string target, string uploadSlotId, oas:TargetuploadSlotIdBody payload, map<string|string[]> headers = {}, *oas:UploadFileToPxCxSxQueries queries) returns oas:GenericDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:GenericDataResponse|error r = oasClient->uploadFileToPxCxSx(typeCode, target, uploadSlotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->uploadFileToPxCxSx(typeCode, target, uploadSlotId, payload, headers, queries = queries);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + slotId - Enter the ID of the slot you want to use for the upload
    # + sku - Enter the `sku` of the product you want to add the product image to
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function uploadProductImage(string slotId, string sku, oas:TypedIdslotIdBody payload, map<string|string[]> headers = {}) returns error? {
        oas:Client oasClient = self.getOasClient();
        error? r = oasClient->uploadProductImage(slotId, sku, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->uploadProductImage(slotId, sku, payload, headers);
        }
        return r;
    }

    # Upsert a Compensation Plan
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function upsertCompensationPlan(oas:UpsertCompensationPlanRequest payload, map<string|string[]> headers = {}) returns oas:UpsertCompensationPlanResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpsertCompensationPlanResponse|error r = oasClient->upsertCompensationPlan(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertCompensationPlan(payload, headers);
        }
        return r;
    }

    # Upsert a Contract
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function upsertContract(oas:UpsertContractRequest payload, map<string|string[]> headers = {}) returns oas:ContractModelResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ContractModelResponse|error r = oasClient->upsertContract(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertContract(payload, headers);
        }
        return r;
    }

    # Upsert a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload - If the customer does not exist yet, at least the `customerId` must be specified in the payload.<p> 
    # + return - Returns customer record details 
    remote isolated function upsertCustomer(oas:UpsertCustomerRequest payload, map<string|string[]> headers = {}) returns oas:CustomerResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:CustomerResponse|error r = oasClient->upsertCustomer(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertCustomer(payload, headers);
        }
        return r;
    }

    # Upsert a Customer Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - **Please note**: The data sent in your request might be different from our sample request schema. Custom fields (`attribute1`..`attribute30`) can be retrieved using the **`/fetch/CXAM`** operation 
    # + return - OK 
    remote isolated function upsertCustomerExtension(oas:UpsertCustomerExtensionRequest payload, map<string|string[]> headers = {}) returns oas:UpsertCustomerExtensionResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpsertCustomerExtensionResponse|error r = oasClient->upsertCustomerExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertCustomerExtension(payload, headers);
        }
        return r;
    }

    # Upsert a Key
    #
    # + tableName - A name of the table you want to upsert the key into
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK. Returns `"data" : null` when successfully inserted/updated 
    remote isolated function upsertKey(string tableName, oas:UpsertKVKeyRequest payload, map<string|string[]> headers = {}) returns oas:UpsertKVKeyResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpsertKVKeyResponse|error r = oasClient->upsertKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertKey(tableName, payload, headers);
        }
        return r;
    }

    # Upsert a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function upsertLookupTableValue(string tableId, oas:UpsertLookupTableValueRequest payload, map<string|string[]> headers = {}) returns oas:UpsertLookupTableValueResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpsertLookupTableValueResponse|error r = oasClient->upsertLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Upsert a Product in a Manual Price List
    #
    # + id - The ID of the Manual Price List whose product you want to create or update
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Returns full record details 
    remote isolated function upsertManualPriceListProduct(string id, oas:UpsertProductManualPriceListRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->upsertManualPriceListProduct(id, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertManualPriceListProduct(id, payload, headers);
        }
        return r;
    }

    # Upsert an Object
    #
    # + typeCode - Enter the Type code of the entity you want to insert a data to. See [the list of Type codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + payload - The **`/integrate/P`** endpoint (Upsert a Product) is used in our example.<p> 
    # + return - Returns full record details 
    remote isolated function upsertObject("ACTT"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CLLI"|"CN"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DREG"|"DWT"|"ET"|"EVT"|"F"|"FE"|"FN"|"IDC"|"IE"|"ISH"|"JST"|"JLTV"|"JLTVM"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"P"|"PAM"|"PAPIJ"|"PBOME"|"PCOMP"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, oas:UpsertObjectRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->upsertObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertObject(typeCode, payload, headers);
        }
        return r;
    }

    # Upsert an Object (and return old data)
    #
    # + typeCode - Specify the type code for the entity you want to work with. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article.'
    # + headers - Headers to be sent with the request 
    # + payload - The **`/integrate/P/returnolddata`** endpoint (upserts a product) is used in our example.<p> 
    # + return - OK 
    remote isolated function upsertObjectReturningOldData(oas:TypeCodeEnum typeCode, oas:UpsertObjectReturnOldDataRequest payload, map<string|string[]> headers = {}) returns oas:UpsertObjectReturnOldDataResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:UpsertObjectReturnOldDataResponse|error r = oasClient->upsertObjectReturningOldData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertObjectReturningOldData(typeCode, payload, headers);
        }
        return r;
    }

    # Upsert a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Either `sku` or `typedId` must be specified in order to *update* an existing product 
    # + return - Returns full record details 
    remote isolated function upsertProduct(oas:UpsertProductRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->upsertProduct(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertProduct(payload, headers);
        }
        return r;
    }

    # Upsert a Product Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Returns full record details 
    remote isolated function upsertProductExtension(oas:UpsertProductExtensionRequest payload, map<string|string[]> headers = {}) returns oas:ProductResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ProductResponse|error r = oasClient->upsertProductExtension(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertProductExtension(payload, headers);
        }
        return r;
    }

    # Upsert a Quote
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function upsertQuote(oas:UpsertQuoteRequest payload, map<string|string[]> headers = {}) returns oas:QuoteResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:QuoteResponse|error r = oasClient->upsertQuote(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertQuote(payload, headers);
        }
        return r;
    }

    # Upsert a Rebate Agreement
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - Example response 
    remote isolated function upsertRebateAgreement(oas:UpsertRebateAgreementRequest payload, map<string|string[]> headers = {}) returns oas:RebateAgreementResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:RebateAgreementResponse|error r = oasClient->upsertRebateAgreement(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->upsertRebateAgreement(payload, headers);
        }
        return r;
    }

    # Validate Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to validate
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function validateItems(string typedId, oas:ValidateClaimItemsRequest payload, map<string|string[]> headers = {}) returns oas:ValidateClaimItemsResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ValidateClaimItemsResponse|error r = oasClient->validateItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->validateItems(typedId, payload, headers);
        }
        return r;
    }

    # Validate a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + payload - Request payload
    # + return - OK 
    remote isolated function validateWorkflowDelegation(oas:ValidateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns oas:ValidateWorkflowDelegationResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:ValidateWorkflowDelegationResponse|error r = oasClient->validateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->validateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Withdraw a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function withdrawDocument(string currentStepId, map<string|string[]> headers = {}) returns oas:WithdrawDocumentResponse|error {
        oas:Client oasClient = self.getOasClient();
        oas:WithdrawDocumentResponse|error r = oasClient->withdrawDocument(currentStepId, headers);
        if isAuthError(r) {
            check self.reauthenticate();
            oasClient = self.getOasClient();
            r = oasClient->withdrawDocument(currentStepId, headers);
        }
        return r;
    }
}

# Builds a freshly authenticated `oas:Client`. Which kind of HTTP auth is configured follows
# directly from which `PricefxCredentials` record was supplied:
#
# - `JwtCredentials` - the caller's token, sent as `X-PriceFx-jwt`. No exchange, so no network call
#   during initialization. Cannot be refreshed, since there are no credentials to re-authenticate
#   with; that is why it is documented for non-expiring integration tokens
# - `OAuth2Credentials` - an OAuth2 refresh token grant. Ballerina's `http` module fetches and
#   renews access tokens by itself
# - `ExternalJwtCredentials` - a bearer token whose value is Pricefx's `<systemName>;<jwt>` form.
#   Note this sends the scheme as `Bearer` where Pricefx's documentation writes `BEARER`; RFC 7235
#   defines the scheme as case-insensitive, so this should be equivalent, but it has not been
#   verified against a live partition
# - `BasicCredentials` - one Basic authenticated call to obtain a session token, then that token for
#   everything afterwards. Pricefx makes Basic auth deliberately slow (~500ms per request) and
#   issues the token as a cookie on the first such call, so this pays the penalty once per client
#   instead of once per request. If no token comes back it falls back to Basic auth per request,
#   which is slower but always correct
#
# + auth - The credentials supplied to the wrapper client
# + config - HTTP transport settings supplied to the wrapper client
# + serviceUrl - URL of the target service
# + return - A freshly authenticated `oas:Client`, or an error if authentication failed
isolated function createOasClient(readonly & PricefxCredentials auth, readonly & ConnectionConfig config, string serviceUrl) returns oas:Client|error {
    http:CredentialsConfig|http:BearerTokenConfig|oas:ApiKeysConfig|oas:OAuth2RefreshTokenGrantConfig oasAuth;
    if auth is JwtCredentials {
        oasAuth = {X\-PriceFx\-jwt: auth.jwt};
    } else if auth is OAuth2Credentials {
        oasAuth = {
            refreshUrl: string `${serviceUrl}/oauth/token`,
            refreshToken: auth.refreshToken,
            clientId: auth.clientId,
            clientSecret: auth.clientSecret ?: ""
        };
    } else if auth is ExternalJwtCredentials {
        oasAuth = {token: string `${auth.systemName};${auth.jwt}`};
    } else {
        string basicUsername = string `${auth.partition}/${auth.username}`;
        string? sessionJwt = bootstrapSessionJwt(serviceUrl, basicUsername, auth.password);
        oasAuth = sessionJwt is string ? {X\-PriceFx\-jwt: sessionJwt}
                                       : {username: basicUsername, password: auth.password};
    }
    oas:ConnectionConfig oasConfig = {
        auth: oasAuth,
        httpVersion: config.httpVersion,
        http1Settings: config.http1Settings,
        http2Settings: config.http2Settings,
        timeout: config.timeout,
        forwarded: config.forwarded,
        poolConfig: config.poolConfig,
        cache: config.cache,
        compression: config.compression,
        circuitBreaker: config.circuitBreaker,
        retryConfig: config.retryConfig,
        responseLimits: config.responseLimits,
        secureSocket: config.secureSocket,
        proxy: config.proxy,
        validation: config.validation,
        laxDataBinding: config.laxDataBinding
    };
    return new oas:Client(oasConfig, serviceUrl);
}

# Makes a single HTTP Basic authenticated call to `GET /login/extended` and returns the
# `X-PriceFx-jwt` session token Pricefx sets as a cookie on the response, so that every later
# request can use the token instead of re-sending credentials.
#
# This exists because Pricefx deliberately makes Basic auth slow - "the basic authentication leads
# to an extra 500 ms request execution time as the password verification is intentionally slow to
# mitigate brute-force password guess attacks" - and its documentation recommends reusing the
# issued JWT "and not user/pwd on every API call". Doing that here turns a per-request cost into a
# per-client one.
#
# It is a raw HTTP call rather than a generated operation because `login` is not exposed on the
# client at all (see docs/spec/sanitations.md item 575): callers must never manage this session
# themselves. Cookie support is not enabled on the client; the `Set-Cookie` header is read directly.
#
# Never returns an error. Anything unexpected - a network failure, a Pricefx deployment that does
# not serve this endpoint, a response without the cookie - yields `()` so the caller falls back to
# per-request Basic auth, which is slower but always correct. Failing initialization here would
# turn a performance optimization into an outage.
#
# + serviceUrl - URL of the target service
# + basicUsername - The Basic auth username, already prefixed with the partition
# + password - The Pricefx password
# + return - The session token, or `()` if one could not be obtained
isolated function bootstrapSessionJwt(string serviceUrl, string basicUsername, string password) returns string? {
    http:Client|error loginClient = new (serviceUrl, {auth: {username: basicUsername, password}});
    if loginClient is error {
        return ();
    }
    http:Response|error response = loginClient->get("/login/extended");
    if response is error {
        return ();
    }
    string[]|error setCookies = response.getHeaders("Set-Cookie");
    if setCookies is error {
        return ();
    }
    foreach string setCookie in setCookies {
        // e.g. `X-PriceFx-jwt=eyJ...; Path=/; HttpOnly` - take the value up to the first `;`
        if setCookie.startsWith(JWT_COOKIE_PREFIX) {
            string value = setCookie.substring(JWT_COOKIE_PREFIX.length());
            int? semicolon = value.indexOf(";");
            string token = semicolon is int ? value.substring(0, semicolon) : value;
            return token.trim() == "" ? () : token.trim();
        }
    }
    return ();
}

# Returns whether a client response/error represents an authentication failure (HTTP 401),
# which is the signal to re-authenticate and replay the request once.
#
# + r - The response value or error returned by an `oas` client operation
# + return - `true` if the result is an HTTP 401
isolated function isAuthError(any|error r) returns boolean {
    if r is http:Response {
        return r.statusCode == http:STATUS_UNAUTHORIZED;
    }
    if r is http:ClientRequestError {
        return r.detail().statusCode == http:STATUS_UNAUTHORIZED;
    }
    return false;
}
