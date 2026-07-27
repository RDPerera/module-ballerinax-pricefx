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

# The `ballerinax/pricefx` client. Wraps the generated `oas` client and adds transparent
# re-authentication: when a request comes back unauthenticated (the JWT is valid for ~30
# minutes), the client re-authenticates once and replays the request, so a long-lived client
# instance keeps working without manual re-initialization.
public isolated client class Client {
    final GeneratedClient oasClient;

    # Gets invoked to initialize the `connector`. Exchanges `config.auth` for a JWT
    # (`X-PriceFx-jwt`); refreshed automatically when it expires.
    #
    # + config - The configurations to be used when initializing the `connector`
    # + serviceUrl - URL of the target service
    # + return - An error if connector initialization, or authentication, failed
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://companynode.pricefx.com/pricefx/companypartition") returns error? {
        self.oasClient = check new GeneratedClient(config, serviceUrl);
    }

    # Submit a Calculation Grid Item
    #
    # + id - The `id` of the Calculation Grid you want to submit items for. You can retrieve the `id` of the CG, for example, by calling the `/fetch/CG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function acceptCalculationGridItem(string id, SubmitCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns SubmitCalculationGridItemResponse|error {
        SubmitCalculationGridItemResponse|error r = self.oasClient->acceptCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->acceptCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Add an Action Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addActionType(AddActionTypeRequest payload, map<string|string[]> headers = {}) returns AddActionTypeResponse|error {
        AddActionTypeResponse|error r = self.oasClient->addActionType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addActionType(payload, headers);
        }
        return r;
    }

    # Add an Approver Step
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addApproverStep(string currentStepId, AddApproverStepRequest payload, map<string|string[]> headers = {}) returns AddApproverStepResponse|error {
        AddApproverStepResponse|error r = self.oasClient->addApproverStep(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addApproverStep(currentStepId, payload, headers);
        }
        return r;
    }

    # Add a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addCalculation(AddCalculationRequest payload, map<string|string[]> headers = {}) returns AddCalculationResponse|error {
        AddCalculationResponse|error r = self.oasClient->addCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addCalculation(payload, headers);
        }
        return r;
    }

    # Add a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addCalculationGrid(AddCalculationGridRequest payload, map<string|string[]> headers = {}) returns AddCalculationGridResponse|error {
        AddCalculationGridResponse|error r = self.oasClient->addCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addCalculationGrid(payload, headers);
        }
        return r;
    }

    # Add a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, AddCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns AddCalculationGridItemResponse|error {
        AddCalculationGridItemResponse|error r = self.oasClient->addCalculationGridItem(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addCalculationGridItem(keyNumber, payload, headers);
        }
        return r;
    }

    # Add a Claim
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addClaim(AddClaimRequest payload, map<string|string[]> headers = {}) returns AddClaimResponse|error {
        AddClaimResponse|error r = self.oasClient->addClaim(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addClaim(payload, headers);
        }
        return r;
    }

    # Add a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addClaimType(AddClaimTypeRequest payload, map<string|string[]> headers = {}) returns AddClaimTypeResponse|error {
        AddClaimTypeResponse|error r = self.oasClient->addClaimType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addClaimType(payload, headers);
        }
        return r;
    }

    # Add a Comment
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addComment(CommentmanagerAddBody payload, map<string|string[]> headers = {}) returns CommentOperationEnvelope|error {
        CommentOperationEnvelope|error r = self.oasClient->addComment(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addComment(payload, headers);
        }
        return r;
    }

    # Add a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addCompensationType(AddCompensationTypeRequest payload, map<string|string[]> headers = {}) returns AddCompensationTypeEnvelope|error {
        AddCompensationTypeEnvelope|error r = self.oasClient->addCompensationType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addCompensationType(payload, headers);
        }
        return r;
    }

    # Add a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addConditionRecordItemMeta(AddCRCIMBody payload, map<string|string[]> headers = {}) returns ConditionRecordItemMetaOperationEnvelope|error {
        ConditionRecordItemMetaOperationEnvelope|error r = self.oasClient->addConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Add a Condition Record Set
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addConditionRecordSet(AddCRCSBody payload, map<string|string[]> headers = {}) returns ConditionRecordSetOperationEnvelope|error {
        ConditionRecordSetOperationEnvelope|error r = self.oasClient->addConditionRecordSet(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addConditionRecordSet(payload, headers);
        }
        return r;
    }

    # Add a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function addConditionType(AddConditionTypeRequest payload, map<string|string[]> headers = {}) returns AddConditionTypeEnvelope|error {
        AddConditionTypeEnvelope|error r = self.oasClient->addConditionType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addConditionType(payload, headers);
        }
        return r;
    }

    # Add a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addConfigurationStorage(AddJCSBody payload, map<string|string[]> headers = {}) returns ConfigurationStorageOperationEnvelope|error {
        ConfigurationStorageOperationEnvelope|error r = self.oasClient->addConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Add Contract Line Items
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function addContractLineItems(AddContractLineItemsRequest payload, map<string|string[]> headers = {}) returns contractModelResponse|error {
        contractModelResponse|error r = self.oasClient->addContractLineItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addContractLineItems(payload, headers);
        }
        return r;
    }

    # Add a Customer
    #
    # + headers - Headers to be sent with the request 
    # + return - Returns customer record details 
    remote isolated function addCustomer(AddCustomerRequest payload, map<string|string[]> headers = {}) returns customerResponse|error {
        customerResponse|error r = self.oasClient->addCustomer(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addCustomer(payload, headers);
        }
        return r;
    }

    # Add a Data Change Request
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addDataChangeRequest(AddDCRRequest payload, map<string|string[]> headers = {}) returns AddDCRResponse|error {
        AddDCRResponse|error r = self.oasClient->addDataChangeRequest(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addDataChangeRequest(payload, headers);
        }
        return r;
    }

    # Add a Data Change Request Item
    #
    # + id - `id` of the Data Change Request you want to add the Data Change Request Item to
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addDataChangeRequestItem(string id, AddDCRIRequest payload, map<string|string[]> headers = {}) returns AddDCRIResponse|error {
        AddDCRIResponse|error r = self.oasClient->addDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Add Line Items
    #
    # + typedId - typed ID of the target CLIC document 
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addLineItems(string typedId, ClicmanagerAdditemstypedIdBody payload, map<string|string[]> headers = {}) returns record {}|error {
        record {}|error r = self.oasClient->addLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Add a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addLivePriceGridType(AddPGTTBody payload, map<string|string[]> headers = {}) returns LivePriceGridTypeOperationEnvelope|error {
        LivePriceGridTypeOperationEnvelope|error r = self.oasClient->addLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Add a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload - The request must contain all fields that are part of the business key for that object and all non-nullable fields 
    # + return - OK 
    remote isolated function addLookupTable(AddLookupTableRequest payload, map<string|string[]> headers = {}) returns AddLookupTableResponse|error {
        AddLookupTableResponse|error r = self.oasClient->addLookupTable(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addLookupTable(payload, headers);
        }
        return r;
    }

    # Add a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addLookupTableValue(string tableId, AddLookupTableValueRequest payload, map<string|string[]> headers = {}) returns AddLookupTableValueResponse|error {
        AddLookupTableValueResponse|error r = self.oasClient->addLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Add Products to a Manual Pricelist
    #
    # + id - The ID of the Manual Price List where you want to add products to
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function addManualPriceListProducts(string id, AddProductsToManualPriceListRequest payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->addManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # Add Products to a Manual Price List (No Recalculation)
    #
    # + id - The ID of the Manual Price List where you want to add products to
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addManualPriceListProductsNoRecalc(string id, AddProductsToManualPriceListNoRecalcRequest payload, map<string|string[]> headers = {}) returns AddProductsToManualPriceListNoRecalcResponse|error {
        AddProductsToManualPriceListNoRecalcResponse|error r = self.oasClient->addManualPriceListProductsNoRecalc(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addManualPriceListProductsNoRecalc(id, payload, headers);
        }
        return r;
    }

    # Add a New Internationalization Message
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Created - the new internationalization messages have been added 
    remote isolated function addNewInternationalizationMessage(I18nmanagerPutBody payload, map<string|string[]> headers = {}) returns AddInternationalizationMessageEnvelope|error {
        AddInternationalizationMessageEnvelope|error r = self.oasClient->addNewInternationalizationMessage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addNewInternationalizationMessage(payload, headers);
        }
        return r;
    }

    # Add Price Grid Items to a Price Grid
    #
    # + id - The ID of the Live Price Grid where you want to add Price Grid Items to. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addPriceGridItemsToPriceGrid(string id, AddPriceGridItemsRequest payload, map<string|string[]> headers = {}) returns AddPriceGridItemsToPriceGridResponse|error {
        AddPriceGridItemsToPriceGridResponse|error r = self.oasClient->addPriceGridItemsToPriceGrid(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addPriceGridItemsToPriceGrid(id, payload, headers);
        }
        return r;
    }

    # Add a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function addPriceListType(AddPLTTBody payload, map<string|string[]> headers = {}) returns PriceListTypeOperationEnvelope|error {
        PriceListTypeOperationEnvelope|error r = self.oasClient->addPriceListType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addPriceListType(payload, headers);
        }
        return r;
    }

    # Add a Product
    #
    # + headers - Headers to be sent with the request 
    # + return - Returns full record details 
    remote isolated function addProduct(AddProductRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->addProduct(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addProduct(payload, headers);
        }
        return r;
    }

    # Add Products to a Quote
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function addQuoteProducts(AddProductsToQuoteRequest payload, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->addQuoteProducts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addQuoteProducts(payload, headers);
        }
        return r;
    }

    # Add Rebate Agreement Items
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function addRebateAgreementItems(GetCustomerRequest payload, map<string|string[]> headers = {}) returns rebateagreementResponse|error {
        rebateagreementResponse|error r = self.oasClient->addRebateAgreementItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addRebateAgreementItems(payload, headers);
        }
        return r;
    }

    # Add a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addRebateCalculation(AddRRSCBody payload, map<string|string[]> headers = {}) returns AddRebateCalculationResponse|error {
        AddRebateCalculationResponse|error r = self.oasClient->addRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addRebateCalculation(payload, headers);
        }
        return r;
    }

    # Add a Seller
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addSeller(AddSellerRequest payload, map<string|string[]> headers = {}) returns AddSellerEnvelope|error {
        AddSellerEnvelope|error r = self.oasClient->addSeller(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addSeller(payload, headers);
        }
        return r;
    }

    # Add a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addSellerExtension(AddSellerExtensionRequest payload, map<string|string[]> headers = {}) returns AddSellerExtensionResponse|error {
        AddSellerExtensionResponse|error r = self.oasClient->addSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addSellerExtension(payload, headers);
        }
        return r;
    }

    # Add a User
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function addUser(AddUserRequest payload, map<string|string[]> headers = {}) returns userResponse|error {
        userResponse|error r = self.oasClient->addUser(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addUser(payload, headers);
        }
        return r;
    }

    # Add a Watcher Step
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function addWatcherStep(string currentStepId, AddWatcherStepRequest payload, map<string|string[]> headers = {}) returns AddWatcherStepResponse|error {
        AddWatcherStepResponse|error r = self.oasClient->addWatcherStep(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->addWatcherStep(currentStepId, payload, headers);
        }
        return r;
    }

    # Approve a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function approveDocument(string currentStepId, ApproveDocumentRequest payload, map<string|string[]> headers = {}) returns ApproveDocumentResponse|error {
        ApproveDocumentResponse|error r = self.oasClient->approveDocument(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->approveDocument(currentStepId, payload, headers);
        }
        return r;
    }

    # Assign a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignBusinessRole(AssignBusinessRoleRequest payload, map<string|string[]> headers = {}) returns AssignBusinessRoleResponse|error {
        AssignBusinessRoleResponse|error r = self.oasClient->assignBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Business Role to a User
    #
    # + userId - The ID of the user you want to assign a role to. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignBusinessRoleToUser(string userId, AssignBusinessRoleToUserRequest payload, map<string|string[]> headers = {}) returns AssignBusinessRoleToUserResponse|error {
        AssignBusinessRoleToUserResponse|error r = self.oasClient->assignBusinessRoleToUser(userId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignBusinessRoleToUser(userId, payload, headers);
        }
        return r;
    }

    # Assign Customers
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function assignCustomers(AssignCustomersRequest payload, map<string|string[]> headers = {}) returns assignmentResponse|error {
        assignmentResponse|error r = self.oasClient->assignCustomers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignCustomers(payload, headers);
        }
        return r;
    }

    # Assign a Group to a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignGroupToBusinessRole(AssignGroupToBusinessRoleRequest payload, map<string|string[]> headers = {}) returns AssignGroupToBusinessRoleResponse|error {
        AssignGroupToBusinessRoleResponse|error r = self.oasClient->assignGroupToBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignGroupToBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Role to a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignRoleToBusinessRole(AssignRoleToBusinessRoleRequest payload, map<string|string[]> headers = {}) returns AssignRoleToBusinessRoleResponse|error {
        AssignRoleToBusinessRoleResponse|error r = self.oasClient->assignRoleToBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignRoleToBusinessRole(payload, headers);
        }
        return r;
    }

    # Assign a Role to a User
    #
    # + userId - The ID of the user you want to assign a role to. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignRoleToUser(string userId, AssignRoleToUserRequest payload, map<string|string[]> headers = {}) returns AssignRoleToUserResponse|error {
        AssignRoleToUserResponse|error r = self.oasClient->assignRoleToUser(userId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignRoleToUser(userId, payload, headers);
        }
        return r;
    }

    # Assign a Role to Users
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignRoleToUsers(AssignRoleToUsersRequest payload, map<string|string[]> headers = {}) returns AssignRoleToUsersResponse|error {
        AssignRoleToUsersResponse|error r = self.oasClient->assignRoleToUsers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignRoleToUsers(payload, headers);
        }
        return r;
    }

    # Assign a User Group to Users
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignUserGroupToUsers(AssignUserGroupToUsersRequest payload, map<string|string[]> headers = {}) returns AssignUserGroupToUsersResponse|error {
        AssignUserGroupToUsersResponse|error r = self.oasClient->assignUserGroupToUsers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignUserGroupToUsers(payload, headers);
        }
        return r;
    }

    # Assign a User to a User Group
    #
    # + userId - The ID of the user you want to add to the group. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function assignUserToUserGroup(string userId, AssignUserToUserGroupRequest payload, map<string|string[]> headers = {}) returns AssignUserToUserGroupResponse|error {
        AssignUserToUserGroupResponse|error r = self.oasClient->assignUserToUserGroup(userId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->assignUserToUserGroup(userId, payload, headers);
        }
        return r;
    }

    # Insert Bulk Customers
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify customer field names in the `header` object and fields values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function bulkInsertCustomers(InsertBulkCustomersRequest payload, map<string|string[]> headers = {}) returns loaddataResponse|error {
        loaddataResponse|error r = self.oasClient->bulkInsertCustomers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->bulkInsertCustomers(payload, headers);
        }
        return r;
    }

    # Insert Bulk Products
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify product field names in the `header` object and fields values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function bulkInsertProducts(InsertBulkProductsRequest payload, map<string|string[]> headers = {}) returns loaddataResponse|error {
        loaddataResponse|error r = self.oasClient->bulkInsertProducts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->bulkInsertProducts(payload, headers);
        }
        return r;
    }

    # Calculate a Calculation Grid
    #
    # + id - `id` of the Calculation Grid you want to calculate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateCalculationGrid(string id, CalculateCalculationGridRequest payload, map<string|string[]> headers = {}) returns CalculateCalculationGridResponse|error {
        CalculateCalculationGridResponse|error r = self.oasClient->calculateCalculationGrid(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateCalculationGrid(id, payload, headers);
        }
        return r;
    }

    # Calculate a CFS
    #
    # + id - The `id` is the `typedId` without the type suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateCfs(string id, map<string|string[]> headers = {}) returns CalculateCFSResponse|error {
        CalculateCFSResponse|error r = self.oasClient->calculateCfs(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateCfs(id, headers);
        }
        return r;
    }

    # Calculate a Claim
    #
    # + typedId - The `typedId` of the claim whose items you want to calculate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateClaim(string typedId, CalculateClaimRequest payload, map<string|string[]> headers = {}) returns CalculateClaimResponse|error {
        CalculateClaimResponse|error r = self.oasClient->calculateClaim(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateClaim(typedId, payload, headers);
        }
        return r;
    }

    # Calculate a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to start the calculation for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateManualPriceList(string id, map<string|string[]> headers = {}) returns CalculateManualPriceListResponse|error {
        CalculateManualPriceListResponse|error r = self.oasClient->calculateManualPriceList(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateManualPriceList(id, headers);
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
    remote isolated function calculateModelObjectStep(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, map<string|string[]> headers = {}, *CalculateModelObjectStepQueries queries) returns ModelCalculationStepEnvelope|error {
        ModelCalculationStepEnvelope|error r = self.oasClient->calculateModelObjectStep(typedId, stepName, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateModelObjectStep(typedId, stepName, headers, queries = queries);
        }
        return r;
    }

    # Calculate a Price Grid
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculatePriceGrid(string id, map<string|string[]> headers = {}) returns CalculatePriceGridResponse|error {
        CalculatePriceGridResponse|error r = self.oasClient->calculatePriceGrid(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculatePriceGrid(id, headers);
        }
        return r;
    }

    # Calculate a Pricelist
    #
    # + id - The ID of the Price List you want to calculate. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculatePriceList(string id, PricelistmanagerCalculateidBody payload, map<string|string[]> headers = {}) returns CalculatePricelistResponse|error {
        CalculatePricelistResponse|error r = self.oasClient->calculatePriceList(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculatePriceList(id, payload, headers);
        }
        return r;
    }

    # Calculate a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to calculate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function calculateRebateRecordGroup(string typedId, RebaterecordgroupCalculatetypedIdBody payload, map<string|string[]> headers = {}) returns CalculateRebateRecordGroupEnvelope|error {
        CalculateRebateRecordGroupEnvelope|error r = self.oasClient->calculateRebateRecordGroup(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->calculateRebateRecordGroup(typedId, payload, headers);
        }
        return r;
    }

    # Cancel a Calculation Step
    #
    # + typedId - The `typedId` of the Model Object you want to cancel the calculation step for
    # + stepName - The name of the step you want to cancel
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function cancelCalculationStep(string typedId, string stepName, map<string|string[]> headers = {}) returns JobStatusTrackerResponse|error {
        JobStatusTrackerResponse|error r = self.oasClient->cancelCalculationStep(typedId, stepName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->cancelCalculationStep(typedId, stepName, headers);
        }
        return r;
    }

    # Cancel a CFS Calculation
    #
    # + id - The `id` is the `typedId` without the type suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function cancelCfsCalculation(string id, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->cancelCfsCalculation(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->cancelCfsCalculation(id, headers);
        }
        return r;
    }

    # Cancel a Calculation
    #
    # + typedId - The `typedId` of the claim whose item calculation you want to cancel
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function cancelClaimCalculation(string typedId, record {} payload, map<string|string[]> headers = {}) returns CancelClaimCalculationResponse|error {
        CancelClaimCalculationResponse|error r = self.oasClient->cancelClaimCalculation(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->cancelClaimCalculation(typedId, payload, headers);
        }
        return r;
    }

    # Cancel a Job
    #
    # + id - `id` if the job you want to cancel
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function cancelJob(string id, record {} payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->cancelJob(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->cancelJob(id, payload, headers);
        }
        return r;
    }

    # Cancel a Calculation
    #
    # + id - The ID of the Live Price Grid whose running calculation should be cancelled
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function cancelPriceGridCalculation(string id, map<string|string[]> headers = {}) returns CancelCalculationResponse|error {
        CancelCalculationResponse|error r = self.oasClient->cancelPriceGridCalculation(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->cancelPriceGridCalculation(id, headers);
        }
        return r;
    }

    # Change a Current User Password
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function changeCurrentUserPassword(ChangeCurrentUserPasswordRequest payload, map<string|string[]> headers = {}) returns ChangeCurrentUserPasswordResponse|error {
        ChangeCurrentUserPasswordResponse|error r = self.oasClient->changeCurrentUserPassword(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->changeCurrentUserPassword(payload, headers);
        }
        return r;
    }

    # Change a Custom Form Status
    #
    # + typedId - The `typedId` of the Custom Form whose status you want to change
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function changeCustomFormStatus(string typedId, ChangeCustomFormStatusRequest payload, map<string|string[]> headers = {}) returns ChangeCustomFormStatusResponse|error {
        ChangeCustomFormStatusResponse|error r = self.oasClient->changeCustomFormStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->changeCustomFormStatus(typedId, payload, headers);
        }
        return r;
    }

    remote isolated function changeTermsOfUse(AccountmanagerChangetermsofuseBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->changeTermsOfUse(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->changeTermsOfUse(payload, headers);
        }
        return r;
    }

    # Change a User Password
    #
    # + userId - Enter the ID of the user whose password you want to change. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function changeUserPassword(string userId, ChangeUserPasswordRequest payload, map<string|string[]> headers = {}) returns ChangeUserPasswordResponse|error {
        ChangeUserPasswordResponse|error r = self.oasClient->changeUserPassword(userId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->changeUserPassword(userId, payload, headers);
        }
        return r;
    }

    # Check a File
    #
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function checkFileExists(string binaryDataId, map<string|string[]> headers = {}) returns CheckFileExistsEnvelope|error {
        CheckFileExistsEnvelope|error r = self.oasClient->checkFileExists(binaryDataId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->checkFileExists(binaryDataId, headers);
        }
        return r;
    }

    # Convert to a Deal
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function convertQuoteToDeal(string identifier, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->convertQuoteToDeal(identifier, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->convertQuoteToDeal(identifier, headers);
        }
        return r;
    }

    # Convert to Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function convertToPriceList(string id, map<string|string[]> headers = {}) returns ConvertPriceListResponse|error {
        ConvertPriceListResponse|error r = self.oasClient->convertToPriceList(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->convertToPriceList(id, headers);
        }
        return r;
    }

    # Copy a Logic
    #
    # + id - The ID of the logic. you want to copy. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyLogic(string id, map<string|string[]> headers = {}) returns CopyLogicResponse|error {
        CopyLogicResponse|error r = self.oasClient->copyLogic(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyLogic(id, headers);
        }
        return r;
    }

    # Copy a Lookup Table
    #
    # + tableId - Enter the ID of the table you want to copy
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyLookupTable(string tableId, map<string|string[]> headers = {}) returns CopyLookupTableResponse|error {
        CopyLookupTableResponse|error r = self.oasClient->copyLookupTable(tableId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyLookupTable(tableId, headers);
        }
        return r;
    }

    # Copy a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to copy
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function copyManualPriceList(string id, map<string|string[]> headers = {}) returns manualpricelistResponse|error {
        manualpricelistResponse|error r = self.oasClient->copyManualPriceList(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyManualPriceList(id, headers);
        }
        return r;
    }

    # Copy a Price Grid
    #
    # + id - The `id` of the Live Price Grid you want to copy. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyPriceGrid(string id, map<string|string[]> headers = {}) returns CopyPriceGridResponse|error {
        CopyPriceGridResponse|error r = self.oasClient->copyPriceGrid(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyPriceGrid(id, headers);
        }
        return r;
    }

    # Copy a Quote
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyQuote(string typedId, record {} payload, map<string|string[]> headers = {}) returns CopyQuoteEnvelope|error {
        CopyQuoteEnvelope|error r = self.oasClient->copyQuote(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyQuote(typedId, payload, headers);
        }
        return r;
    }

    # Copy Roles
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function copyRoles(CopyRolesRequest payload, map<string|string[]> headers = {}) returns CopyRolesResponse|error {
        CopyRolesResponse|error r = self.oasClient->copyRoles(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyRoles(payload, headers);
        }
        return r;
    }

    # Copy a User
    #
    # + userid - The ID of the user you want to copy. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function copyUser(string userid, map<string|string[]> headers = {}) returns CopyUserResponse|error {
        CopyUserResponse|error r = self.oasClient->copyUser(userid, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->copyUser(userid, headers);
        }
        return r;
    }

    # Count Keys
    #
    # + tableName - The table to count keys from
    # + headers - Headers to be sent with the request 
    # + return - OK - the number of keys 
    remote isolated function countKeys(string tableName, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->countKeys(tableName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->countKeys(tableName, headers);
        }
        return r;
    }

    # Count Mass Action Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function countMassActionItems(string id, CountMassActionItemsRequest payload, map<string|string[]> headers = {}) returns CountMassActionItemsResponse|error {
        CountMassActionItemsResponse|error r = self.oasClient->countMassActionItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->countMassActionItems(id, payload, headers);
        }
        return r;
    }

    # Create an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function createActionItem(AddActionItemRequest payload, map<string|string[]> headers = {}) returns AddActionItemResponse|error {
        AddActionItemResponse|error r = self.oasClient->createActionItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createActionItem(payload, headers);
        }
        return r;
    }

    # Get an Authentication Token (API V2 only)
    #
    # + headers - Headers to be sent with the request 
    # + return - Login was successful. The response contains the access token, token type and the refresh token 
    remote isolated function createAuthToken(CreateAuthTokenHeaders headers, GetAuthenticationTokenAPIv2Request payload) returns tokenResponse|error {
        tokenResponse|error r = self.oasClient->createAuthToken(headers, payload);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createAuthToken(headers, payload);
        }
        return r;
    }

    # Create a Quote
    #
    # + typeCode - Enter the type code of the entity you want to create
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createClic("Q"|"QTMP" typeCode, ClicmanagerCreateTypeCodeBody payload, map<string|string[]> headers = {}) returns ClicOperationEnvelope|error {
        ClicOperationEnvelope|error r = self.oasClient->createClic(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createClic(typeCode, payload, headers);
        }
        return r;
    }

    # Create a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function createCustomForm(CreateCustomFormRequest payload, map<string|string[]> headers = {}) returns CreateCustomFormEnvelope|error {
        CreateCustomFormEnvelope|error r = self.oasClient->createCustomForm(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createCustomForm(payload, headers);
        }
        return r;
    }

    # Create a Custom Form Revision
    #
    # + typedId - `typedId` of the Custom Form you want to create a revision from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createCustomFormRevision(string typedId, record {} payload, map<string|string[]> headers = {}) returns CustomFormRevisionEnvelope|error {
        CustomFormRevisionEnvelope|error r = self.oasClient->createCustomFormRevision(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createCustomFormRevision(typedId, payload, headers);
        }
        return r;
    }

    # Create a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createCustomFormType(CreateCustomFormTypeRequest payload, map<string|string[]> headers = {}) returns CreateCustomFormTypeResponse|error {
        CreateCustomFormTypeResponse|error r = self.oasClient->createCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createCustomFormType(payload, headers);
        }
        return r;
    }

    # Create a DMFieldCollection
    #
    # + fcType - The type of FC (FieldCollection) you want to create
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createDMFieldCollection("DMDS"|"DMT" fcType, DatamartCreatefcfcTypeBody payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->createDMFieldCollection(fcType, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDMFieldCollection(fcType, payload, headers);
        }
        return r;
    }

    # Create a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Either `uniqueName` or `typedId` must be provided in the request 
    # + return - Example response 
    remote isolated function createDataManagerEntity("DMF"|"DM"|"DMDS" typeCode, CreateDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns dmobjectResponse|error {
        dmobjectResponse|error r = self.oasClient->createDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Create a KV Table
    #
    # + tableName - A name of the table you want create. Only lower case letters, numbers and underscores are allowed. Do not use special characters
    # + headers - Headers to be sent with the request 
    # + payload - The sample request creates a table with four columns: sku, customer, record and payload (TEXT).<br> 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function createKvTable(string tableName, CreateKVTableRequest payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->createKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Create a Manual Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function createManualPriceList(CreateManualPriceListRequest payload, map<string|string[]> headers = {}) returns manualpricelistResponse|error {
        manualpricelistResponse|error r = self.oasClient->createManualPriceList(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createManualPriceList(payload, headers);
        }
        return r;
    }

    # Create a Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createPriceList(CreatePriceListRequest payload, map<string|string[]> headers = {}) returns CreatePriceListResponse|error {
        CreatePriceListResponse|error r = self.oasClient->createPriceList(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createPriceList(payload, headers);
        }
        return r;
    }

    # Create a Revision
    #
    # + id - The ID of the Price List you want to create a revision for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function createPriceListRevision(string id, CreateRevisionRequest payload, map<string|string[]> headers = {}) returns pricelistitemResponse|error {
        pricelistitemResponse|error r = self.oasClient->createPriceListRevision(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createPriceListRevision(id, payload, headers);
        }
        return r;
    }

    # Create a New Revision
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function createQuoteRevision(string identifier, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->createQuoteRevision(identifier, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createQuoteRevision(identifier, headers);
        }
        return r;
    }

    # 1. Create an Upload Slot
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Slot created 
    remote isolated function createUploadSlot(map<string|string[]> headers = {}, *CreateUploadSlotQueries queries) returns CreateUploadSlotEnvelope|error {
        CreateUploadSlotEnvelope|error r = self.oasClient->createUploadSlot(headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createUploadSlot(headers, queries = queries);
        }
        return r;
    }

    # Create a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function createWorkflowDelegation(CreateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns CreateWorkflowDelegationResponse|error {
        CreateWorkflowDelegationResponse|error r = self.oasClient->createWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->createWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Deactivate a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deactivateWorkflowDelegation(DeactivateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns DeactivateWorkflowDelegationResponse|error {
        DeactivateWorkflowDelegationResponse|error r = self.oasClient->deactivateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deactivateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Delete an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteActionItem(DeleteActionItemRequest payload, map<string|string[]> headers = {}) returns DeleteActionItemResponse|error {
        DeleteActionItemResponse|error r = self.oasClient->deleteActionItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteActionItem(payload, headers);
        }
        return r;
    }

    # Delete an Action Item Type
    #
    # + headers - Headers to be sent with the request 
    # + payload - The general delete request. Deletes the object specified by `typedId` in the request body 
    # + return - OK 
    remote isolated function deleteActionItemType(record {record {string typedId;} data;} payload, map<string|string[]> headers = {}) returns DeleteActionItemTypeResponse|error {
        DeleteActionItemTypeResponse|error r = self.oasClient->deleteActionItemType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteActionItemType(payload, headers);
        }
        return r;
    }

    # Delete an Authentication Token (API V2 only)
    #
    # + headers - Headers to be sent with the request 
    # + return - Logout successful 
    remote isolated function deleteAuthToken(DeleteAuthTokenHeaders headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->deleteAuthToken(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteAuthToken(headers);
        }
        return r;
    }

    # Delete a Business Role
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteBusinessRole(DeleteBusinessRoleRequest payload, map<string|string[]> headers = {}) returns DeleteBusinessRoleResponse|error {
        DeleteBusinessRoleResponse|error r = self.oasClient->deleteBusinessRole(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteBusinessRole(payload, headers);
        }
        return r;
    }

    # Delete a Calculated Field Set
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCalculatedFieldSet(DeleteCalculatedFieldSetRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteCalculatedFieldSet(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCalculatedFieldSet(payload, headers);
        }
        return r;
    }

    # Delete a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - returns the deleted object's data 
    remote isolated function deleteCalculation(DeleteCalculationRequest payload, map<string|string[]> headers = {}) returns DeleteCalculationResponse|error {
        DeleteCalculationResponse|error r = self.oasClient->deleteCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCalculation(payload, headers);
        }
        return r;
    }

    # Delete a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCalculationGrid(DeleteCalculationGridRequest payload, map<string|string[]> headers = {}) returns DeleteCalculationGridResponse|error {
        DeleteCalculationGridResponse|error r = self.oasClient->deleteCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCalculationGrid(payload, headers);
        }
        return r;
    }

    # Delete a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, DeleteCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns DeleteCalculationGridItemResponse|error {
        DeleteCalculationGridItemResponse|error r = self.oasClient->deleteCalculationGridItem(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCalculationGridItem(keyNumber, payload, headers);
        }
        return r;
    }

    # Delete a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteClaimType(DeleteClaimTypeRequest payload, map<string|string[]> headers = {}) returns DeleteClaimTypeResponse|error {
        DeleteClaimTypeResponse|error r = self.oasClient->deleteClaimType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteClaimType(payload, headers);
        }
        return r;
    }

    # Delete Column Values
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + columnName - The name of the column/attribute you want to remove values from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteColumnValues(string typeCode, string columnName, map<string|string[]> headers = {}) returns DeleteColumnValuesResponse|error {
        DeleteColumnValuesResponse|error r = self.oasClient->deleteColumnValues(typeCode, columnName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteColumnValues(typeCode, columnName, headers);
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
        error? r = self.oasClient->deleteColumnValuesMatrix(tableId, columnName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteColumnValuesMatrix(tableId, columnName, headers);
        }
        return r;
    }

    # Delete a Comment
    #
    # + typedId - Comment or CommentThread typedId
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteComment(string typedId, map<string|string[]> headers = {}) returns DeleteCommentEnvelope|error {
        DeleteCommentEnvelope|error r = self.oasClient->deleteComment(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteComment(typedId, headers);
        }
        return r;
    }

    # Delete a Compensation Plan
    #
    # + headers - Headers to be sent with the request 
    # + return - OK. Returns the deleted Compensation Plan object 
    remote isolated function deleteCompensationPlan(DeleteCompensationPlanRequest payload, map<string|string[]> headers = {}) returns DeleteCompensationPlanResponse|error {
        DeleteCompensationPlanResponse|error r = self.oasClient->deleteCompensationPlan(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCompensationPlan(payload, headers);
        }
        return r;
    }

    # Delete a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - returns the deleted object 
    remote isolated function deleteCompensationType(DeleteCOHTBody payload, map<string|string[]> headers = {}) returns DeleteCompensationTypeEnvelope|error {
        DeleteCompensationTypeEnvelope|error r = self.oasClient->deleteCompensationType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCompensationType(payload, headers);
        }
        return r;
    }

    # Delete a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteConditionRecordItemMeta(DeleteCRCIMBody payload, map<string|string[]> headers = {}) returns ConditionRecordItemMetaOperationEnvelope|error {
        ConditionRecordItemMetaOperationEnvelope|error r = self.oasClient->deleteConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Delete a Condition Records Set
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteConditionRecordSet(DcrmanagerDeletemassopidBody payload, map<string|string[]> headers = {}) returns ConditionRecordSetOperationEnvelope|error {
        ConditionRecordSetOperationEnvelope|error r = self.oasClient->deleteConditionRecordSet(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteConditionRecordSet(payload, headers);
        }
        return r;
    }

    # Delete a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteConditionType(DeleteConditionTypeRequest payload, map<string|string[]> headers = {}) returns DeleteConditionTypeEnvelope|error {
        DeleteConditionTypeEnvelope|error r = self.oasClient->deleteConditionType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteConditionType(payload, headers);
        }
        return r;
    }

    # Delete a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteConfigurationStorage(record {} payload, map<string|string[]> headers = {}) returns ConfigurationStorageOperationEnvelope|error {
        ConfigurationStorageOperationEnvelope|error r = self.oasClient->deleteConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Delete a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteCustomForm(DeleteCustomFormRequest payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->deleteCustomForm(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCustomForm(payload, headers);
        }
        return r;
    }

    # Delete a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCustomFormType(DeleteCFOTBody payload, map<string|string[]> headers = {}) returns DeleteCustomFormTypeEnvelope|error {
        DeleteCustomFormTypeEnvelope|error r = self.oasClient->deleteCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCustomFormType(payload, headers);
        }
        return r;
    }

    # Delete a Customer
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCustomer(DeleteCustomerRequest payload, map<string|string[]> headers = {}) returns DeleteCustomerResponse|error {
        DeleteCustomerResponse|error r = self.oasClient->deleteCustomer(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCustomer(payload, headers);
        }
        return r;
    }

    # Delete a Customer Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteCustomerExtension(DeleteCustomerExtensionRequest payload, map<string|string[]> headers = {}) returns DeleteCustomerExtensionResponse|error {
        DeleteCustomerExtensionResponse|error r = self.oasClient->deleteCustomerExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteCustomerExtension(payload, headers);
        }
        return r;
    }

    # Delete a Data Change Request Item
    #
    # + id - `id` of the Data Change Request whose item you want to delete
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteDataChangeRequestItem(string id, DeleteDCRIRequest payload, map<string|string[]> headers = {}) returns DeleteDCRIResponse|error {
        DeleteDCRIResponse|error r = self.oasClient->deleteDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Delete a Data Change Request Mass Change
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteDataChangeRequestMassChange(string id, DcrmanagerDeletemassopidBody payload, map<string|string[]> headers = {}) returns DataChangeRequestMassChangeEnvelope|error {
        DataChangeRequestMassChangeEnvelope|error r = self.oasClient->deleteDataChangeRequestMassChange(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDataChangeRequestMassChange(id, payload, headers);
        }
        return r;
    }

    # Delete a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to delete
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteDataManagerEntity("DM"|"DMF"|"DMDS" typeCode, DeleteDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns DeleteDataManagerEntityResponse|error {
        DeleteDataManagerEntityResponse|error r = self.oasClient->deleteDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Delete Datamart Orphan Objects
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteDatamartOrphanObjects(map<string|string[]> headers = {}) returns DatamartOrphanObjectsEnvelope|error {
        DatamartOrphanObjectsEnvelope|error r = self.oasClient->deleteDatamartOrphanObjects(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteDatamartOrphanObjects(headers);
        }
        return r;
    }

    # Delete a File
    #
    # + typedId - `typedId` of the document whose attachment you want to delete
    # + binaryDataId - If the `typedId` is, for example, 1145.BD then the binaryDataId is **1145**
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteFile(string typedId, string binaryDataId, record {} payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->deleteFile(typedId, binaryDataId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteFile(typedId, binaryDataId, payload, headers);
        }
        return r;
    }

    # Delete Import Changes
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function deleteImportChanges(ImportmanagerDeletechangesBody payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->deleteImportChanges(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteImportChanges(payload, headers);
        }
        return r;
    }

    # Delete Internationalization Messages
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - the internationalization keys have been deleted successfully 
    remote isolated function deleteInternationalizationMessages(I18nmanagerDeleteKeysBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->deleteInternationalizationMessages(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteInternationalizationMessages(payload, headers);
        }
        return r;
    }

    # Delete a Key
    #
    # + headers - Headers to be sent with the request 
    # + return - OK. Returns `null` when successfully deleted 
    remote isolated function deleteKey(string tableName, DeleteKVKeyRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deleteKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteKey(tableName, payload, headers);
        }
        return r;
    }

    # Delete a Live Price Grid
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteLivePriceGrid(DeleteLivePriceGridRequest payload, map<string|string[]> headers = {}) returns DeleteLivePriceGridResponse|error {
        DeleteLivePriceGridResponse|error r = self.oasClient->deleteLivePriceGrid(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteLivePriceGrid(payload, headers);
        }
        return r;
    }

    # Delete a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deleteLivePriceGridType(DeletePLTTBody payload, map<string|string[]> headers = {}) returns LivePriceGridTypeOperationEnvelope|error {
        LivePriceGridTypeOperationEnvelope|error r = self.oasClient->deleteLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Delete a Logic
    #
    # + id - The ID of the logic you want to delete. `id`  is the `typedId` without **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484835.F** is **2147484835**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteLogic(string id, map<string|string[]> headers = {}) returns DeleteLogicResponse|error {
        DeleteLogicResponse|error r = self.oasClient->deleteLogic(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteLogic(id, headers);
        }
        return r;
    }

    # Delete a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify the `typedId` of the Lookup Table (Company Parameters) you want to delete 
    # + return - OK 
    remote isolated function deleteLookupTable(DeleteLookupTableRequest payload, map<string|string[]> headers = {}) returns DeleteLookupTableResponse|error {
        DeleteLookupTableResponse|error r = self.oasClient->deleteLookupTable(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteLookupTable(payload, headers);
        }
        return r;
    }

    # Delete a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deleteLookupTableValue(string tableId, DeleteLookupTableValueRequest payload, map<string|string[]> headers = {}) returns DeleteLookupTableValueResponse|error {
        DeleteLookupTableValueResponse|error r = self.oasClient->deleteLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Delete a Manual Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function deleteManualPriceList(DeleteManualPriceListRequest payload, map<string|string[]> headers = {}) returns manualpricelistResponse|error {
        manualpricelistResponse|error r = self.oasClient->deleteManualPriceList(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteManualPriceList(payload, headers);
        }
        return r;
    }

    # Delete a Product from a Manual Price List
    #
    # + id - The ID of the Manual Price List whose product you want to delete
    # + headers - Headers to be sent with the request 
    # + return - Returns full record details 
    remote isolated function deleteManualPriceListProduct(string id, DeleteProductFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->deleteManualPriceListProduct(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteManualPriceListProduct(id, payload, headers);
        }
        return r;
    }

    # Delete Products from a Manual Price List
    #
    # + id - The ID of the Manual Price List whose products you want to delete
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteManualPriceListProducts(string id, DeleteProductsFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns DeleteProductsFromManualPriceListResponse|error {
        DeleteProductsFromManualPriceListResponse|error r = self.oasClient->deleteManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # Delete a Notification
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteNotification(NotificationSetreadBody payload, map<string|string[]> headers = {}) returns DeleteNotificationEnvelope|error {
        DeleteNotificationEnvelope|error r = self.oasClient->deleteNotification(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteNotification(payload, headers);
        }
        return r;
    }

    # Delete Objects
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteObjects(string typeCode, DeleteObjectsForceFilterRequest payload, map<string|string[]> headers = {}) returns DeleteObjectsResponse|error {
        DeleteObjectsResponse|error r = self.oasClient->deleteObjects(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteObjects(typeCode, payload, headers);
        }
        return r;
    }

    # Delete a Price Grid Item
    #
    # + id - The ID of the Price Grid you want to delete the Price Grid Item from
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function deletePriceGridItem(string id, DeletePriceGridItemRequest payload, map<string|string[]> headers = {}) returns pricegriditemResponse|error {
        pricegriditemResponse|error r = self.oasClient->deletePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deletePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Delete a Price Grid Item (Filter)
    #
    # + id - The ID of the Price Grid that contains Price Grid Items you want to delete
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function deletePriceGridItemFilter(string id, DeletePriceGridItemFilterRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->deletePriceGridItemFilter(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deletePriceGridItemFilter(id, payload, headers);
        }
        return r;
    }

    # Delete a Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deletePriceList(DeletePriceListRequest payload, map<string|string[]> headers = {}) returns DeletePriceListResponse|error {
        DeletePriceListResponse|error r = self.oasClient->deletePriceList(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deletePriceList(payload, headers);
        }
        return r;
    }

    # Delete a Price List Item
    #
    # + id - Enter the ID of the Price List where you want to delete an item from
    # + headers - Headers to be sent with the request 
    # + return - OK - Returns a number of deleted items 
    remote isolated function deletePriceListItems(string id, DeletePriceListItemRequest payload, map<string|string[]> headers = {}) returns DeletePriceListItemResponse|error {
        DeletePriceListItemResponse|error r = self.oasClient->deletePriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deletePriceListItems(id, payload, headers);
        }
        return r;
    }

    # Delete a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deletePriceListType(DeletePLTTBody payload, map<string|string[]> headers = {}) returns PriceListTypeOperationEnvelope|error {
        PriceListTypeOperationEnvelope|error r = self.oasClient->deletePriceListType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deletePriceListType(payload, headers);
        }
        return r;
    }

    # Delete a Product
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteProduct(DeleteProductRequest payload, map<string|string[]> headers = {}) returns DeleteProductResponse|error {
        DeleteProductResponse|error r = self.oasClient->deleteProduct(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteProduct(payload, headers);
        }
        return r;
    }

    # Delete a Product Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteProductExtension(DeleteProductExtensionRequest payload, map<string|string[]> headers = {}) returns DeleteProductExtensionResponse|error {
        DeleteProductExtensionResponse|error r = self.oasClient->deleteProductExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteProductExtension(payload, headers);
        }
        return r;
    }

    # Delete a Rebate Agreement
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function deleteRebateAgreement(DeleteRebateAgreementRequest payload, map<string|string[]> headers = {}) returns rebateagreementResponse|error {
        rebateagreementResponse|error r = self.oasClient->deleteRebateAgreement(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteRebateAgreement(payload, headers);
        }
        return r;
    }

    # Delete a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteRebateCalculation(DeleteRebateCalculationRequest payload, map<string|string[]> headers = {}) returns DeleteRebateCalculationResponse|error {
        DeleteRebateCalculationResponse|error r = self.oasClient->deleteRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteRebateCalculation(payload, headers);
        }
        return r;
    }

    # Delete a Seller
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteSeller(DeleteSellerRequest payload, map<string|string[]> headers = {}) returns DeleteSellerEnvelope|error {
        DeleteSellerEnvelope|error r = self.oasClient->deleteSeller(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteSeller(payload, headers);
        }
        return r;
    }

    # Delete a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteSellerExtension(DeleteSellerExtensionRequest payload, map<string|string[]> headers = {}) returns DeleteSellerExtensionResponse|error {
        DeleteSellerExtensionResponse|error r = self.oasClient->deleteSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteSellerExtension(payload, headers);
        }
        return r;
    }

    # 3. Delete an Upload Slot
    #
    # + slotId - Enter the ID of the slot you want to delete
    # + headers - Headers to be sent with the request 
    # + return - Slot deleted 
    remote isolated function deleteUploadSlot(string slotId, map<string|string[]> headers = {}) returns UploadSlotOperationEnvelope|error {
        UploadSlotOperationEnvelope|error r = self.oasClient->deleteUploadSlot(slotId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteUploadSlot(slotId, headers);
        }
        return r;
    }

    # 3. Delete an Upload Slot
    #
    # + slotId - Enter the ID of the slot you want to delete
    # + headers - Headers to be sent with the request 
    # + return - Slot deleted 
    remote isolated function deleteUploadSlotViaGet(string slotId, map<string|string[]> headers = {}) returns DeleteUploadSlotResponse|error {
        DeleteUploadSlotResponse|error r = self.oasClient->deleteUploadSlotViaGet(slotId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteUploadSlotViaGet(slotId, headers);
        }
        return r;
    }

    # Delete a User
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function deleteUser(DeleteUserRequest payload, map<string|string[]> headers = {}) returns userResponse|error {
        userResponse|error r = self.oasClient->deleteUser(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteUser(payload, headers);
        }
        return r;
    }

    # Delete a User Group
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteUserGroup(DeleteUserGroupRequest payload, map<string|string[]> headers = {}) returns DeleteUserGroupResponse|error {
        DeleteUserGroupResponse|error r = self.oasClient->deleteUserGroup(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteUserGroup(payload, headers);
        }
        return r;
    }

    # Delete a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deleteWorkflowDelegation(DeleteWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns DeleteWorkflowDelegationResponse|error {
        DeleteWorkflowDelegationResponse|error r = self.oasClient->deleteWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deleteWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Deny a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function denyDocument(string currentStepId, DenyDocumentRequest payload, map<string|string[]> headers = {}) returns DenyDocumentResponse|error {
        DenyDocumentResponse|error r = self.oasClient->denyDocument(currentStepId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->denyDocument(currentStepId, payload, headers);
        }
        return r;
    }

    # Deny a Live Price Grid Item
    #
    # + id - The ID of the Price Grid that contains the Price Grid Item you want to deny
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function denyLivePriceGridItem(string id, DenyLivePriceGridItemRequest payload, map<string|string[]> headers = {}) returns pricegriditemResponse|error {
        pricegriditemResponse|error r = self.oasClient->denyLivePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->denyLivePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Deploy a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function deployConfigurationStorage(JcsmanagerDeployBody payload, map<string|string[]> headers = {}) returns ConfigurationStorageOperationEnvelope|error {
        ConfigurationStorageOperationEnvelope|error r = self.oasClient->deployConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->deployConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Download an Attachment
    #
    # + binaryDataId - If the typedId is, for example, 1146.BD then the binaryDataId is **1146**
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - binary data 
    remote isolated function downloadAttachmentData(string binaryDataId, map<string|string[]> headers = {}, *DownloadAttachmentDataQueries queries) returns byte[]|error {
        byte[]|error r = self.oasClient->downloadAttachmentData(binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadAttachmentData(binaryDataId, headers, queries = queries);
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
    remote isolated function downloadFile(string typedId, string binaryDataId, map<string|string[]> headers = {}, *DownloadFileQueries queries) returns FileDownloadEnvelope|error {
        FileDownloadEnvelope|error r = self.oasClient->downloadFile(typedId, binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadFile(typedId, binaryDataId, headers, queries = queries);
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
    remote isolated function downloadFileViaPost(string typedId, string binaryDataId, map<string|string[]> headers = {}, *DownloadFileViaPostQueries queries) returns http:Response|error {
        http:Response|error r = self.oasClient->downloadFileViaPost(typedId, binaryDataId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadFileViaPost(typedId, binaryDataId, headers, queries = queries);
        }
        return r;
    }

    # Download a Live Price Grid Excel File
    #
    # + id13 - IDs of the Price Grids you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function downloadLivePriceGridExcelFile(string id1, string id2, string id3, string id4, string id5, string id6, string id7, string id8, string id9, string id10, string id11, string id12, string id13, map<string|string[]> headers = {}, *DownloadLivePriceGridExcelFileQueries queries) returns http:Response|error {
        http:Response|error r = self.oasClient->downloadLivePriceGridExcelFile(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10, id11, id12, id13, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->downloadLivePriceGridExcelFile(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10, id11, id12, id13, headers, queries = queries);
        }
        return r;
    }

    # Drop a KV Table
    #
    # + tableName - A name of the table you want drop. Only lower case letters, numbers and underscores are allowed. Do not use special characters
    # + headers - Headers to be sent with the request 
    # + return - Table dropped 
    remote isolated function dropKvTable(string tableName, record {} payload, map<string|string[]> headers = {}) returns record {}|error {
        record {}|error r = self.oasClient->dropKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->dropKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Duplicate a Compensation Plan
    #
    # + typedId - The `typedId` of the Compensation Plan you want to duplicate
    # + headers - Headers to be sent with the request 
    # + return - OK. Returns the duplicated object 
    remote isolated function duplicateCompensationPlan(string typedId, map<string|string[]> headers = {}) returns DuplicateCompensationPlanEnvelope|error {
        DuplicateCompensationPlanEnvelope|error r = self.oasClient->duplicateCompensationPlan(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->duplicateCompensationPlan(typedId, headers);
        }
        return r;
    }

    # Duplicate a Custom Form
    #
    # + typedId - `typedId` of the Custom Form you want to duplicate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function duplicateCustomForm(string typedId, record {} payload, map<string|string[]> headers = {}) returns CustomFormRevisionEnvelope|error {
        CustomFormRevisionEnvelope|error r = self.oasClient->duplicateCustomForm(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->duplicateCustomForm(typedId, payload, headers);
        }
        return r;
    }

    # Duplicate a Model
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function duplicateModel(string typedId, OptimizationModelduplicatetypedIdBody payload, map<string|string[]> headers = {}) returns ModelDuplicationEnvelope|error {
        ModelDuplicationEnvelope|error r = self.oasClient->duplicateModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->duplicateModel(typedId, payload, headers);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + ownerTypedId - The `TypedId` of the document owning the attachment
    # + binaryDataId - The `binaryDataId` of the attachment to replace
    # + slotId - The upload `slot_id` containing the new file
    # + headers - Headers to be sent with the request 
    # + request - Optional direct file payload; if omitted, the file from the slot is used 
    # + return - Attachment replaced 
    remote isolated function editAttachment(string ownerTypedId, string binaryDataId, string slotId, BinaryDataIdslotIdBody payload, map<string|string[]> headers = {}) returns FileDownloadEnvelope|error {
        FileDownloadEnvelope|error r = self.oasClient->editAttachment(ownerTypedId, binaryDataId, slotId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->editAttachment(ownerTypedId, binaryDataId, slotId, payload, headers);
        }
        return r;
    }

    # Edit a Comment
    #
    # + typedId - typedId of the comment you want to edit
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function editComment(string typedId, CommentmanagerEdittypedIdBody payload, map<string|string[]> headers = {}) returns CommentOperationEnvelope|error {
        CommentOperationEnvelope|error r = self.oasClient->editComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->editComment(typedId, payload, headers);
        }
        return r;
    }

    # Execute a Data Load Logic
    #
    # + typedId - The `typedId` of the Data Load you want to evaluate
    # + logicName - The name of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeDataLoadLogic(string typedId, string logicName, map<string|string[]> headers = {}) returns ExecuteDataLoadLogicResponse|error {
        ExecuteDataLoadLogicResponse|error r = self.oasClient->executeDataLoadLogic(typedId, logicName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeDataLoadLogic(typedId, logicName, headers);
        }
        return r;
    }

    # Execute Library Function
    #
    # + formulaName - Name of the formula library containing the function
    # + elementName - Name of the library element containing the function
    # + functionName - Name of the function to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLibraryFunction(string formulaName, string elementName, string functionName, ElementNamefunctionNameBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->executeLibraryFunction(formulaName, elementName, functionName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLibraryFunction(formulaName, elementName, functionName, payload, headers);
        }
        return r;
    }

    # Execute a Logic
    #
    # + typeCode - The `typeCode` of the Action Item you want to execute the calculation for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLogic(string typeCode, record {} payload, map<string|string[]> headers = {}) returns ExecuteActionItemLogicResponse|error {
        ExecuteActionItemLogicResponse|error r = self.oasClient->executeLogic(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLogic(typeCode, payload, headers);
        }
        return r;
    }

    # Execute a Logic Without a Context in a Service
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Example response 
    remote isolated function executeLogicInService(string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}) returns logicResponse|error {
        logicResponse|error r = self.oasClient->executeLogicInService(uniqueName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLogicInService(uniqueName, payload, headers);
        }
        return r;
    }

    # Execute a Logic Without a Context in a Service (Read-Only)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLogicInServiceReadOnly(string uniqueName, map<string|string[]> headers = {}) returns ExecuteLogicReadOnlyResponse|error {
        ExecuteLogicReadOnlyResponse|error r = self.oasClient->executeLogicInServiceReadOnly(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLogicInServiceReadOnly(uniqueName, headers);
        }
        return r;
    }

    # Execute a Logic (Read-Only)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeLogicRead(string uniqueName, map<string|string[]> headers = {}) returns ExecuteLogicReadOnlyResponse|error {
        ExecuteLogicReadOnlyResponse|error r = self.oasClient->executeLogicRead(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLogicRead(uniqueName, headers);
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
    remote isolated function executeLogicWithout(string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}, *ExecuteLogicWithoutQueries queries) returns ExecuteLogicWithoutProductContextResponse|error {
        ExecuteLogicWithoutProductContextResponse|error r = self.oasClient->executeLogicWithout(uniqueName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeLogicWithout(uniqueName, payload, headers, queries = queries);
        }
        return r;
    }

    # Execute a Model Logic
    #
    # + typedId - The `typedId` of the Model Object you want to execute the logic for
    # + stepName - The name of the step you want to execute the logic for
    # + formulaName - The name of the logic you want to execute
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function executeModelLogic(string typedId, string stepName, string formulaName, ExecuteModelLogicRequest payload, map<string|string[]> headers = {}) returns ExecuteModelLogicResponse|error {
        ExecuteModelLogicResponse|error r = self.oasClient->executeModelLogic(typedId, stepName, formulaName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeModelLogic(typedId, stepName, formulaName, payload, headers);
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
    remote isolated function executeNamedProductLogic(string sku, string uniqueName, record {record {} data?;} payload, map<string|string[]> headers = {}) returns ExecuteLogicResponse|error {
        ExecuteLogicResponse|error r = self.oasClient->executeNamedProductLogic(sku, uniqueName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeNamedProductLogic(sku, uniqueName, payload, headers);
        }
        return r;
    }

    # Execute an Assigned Logic
    #
    # + sku - The `sku` or `typedId` of the product you want to execute the logic for
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function executeProductLogic(string sku, record {record {} data?;} payload, map<string|string[]> headers = {}) returns ExecuteAssignedLogicResponse|error {
        ExecuteAssignedLogicResponse|error r = self.oasClient->executeProductLogic(sku, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->executeProductLogic(sku, payload, headers);
        }
        return r;
    }

    # Export a PDF File
    #
    # + uniqueName - Specify the `uniqueName` of the A&P you want to download
    # + headers - Headers to be sent with the request 
    # + return - OK - returns the file data 
    remote isolated function exportContractPdf(string uniqueName, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->exportContractPdf(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportContractPdf(uniqueName, headers);
        }
        return r;
    }

    # Export a CSV File
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns the ZIP file (binary data): `Content-Type: application/zip` 
    remote isolated function exportCsvFile(ExportCSVFileRequest payload, map<string|string[]> headers = {}, *ExportCsvFileQueries queries) returns error? {
        error? r = self.oasClient->exportCsvFile(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportCsvFile(payload, headers, queries = queries);
        }
        return r;
    }

    # Export Datamart
    #
    # + fcTypedIdOrSourceName - Restricts the export to a specific source, identified by either the 'typedId' or 'sourceName'. 
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function exportDatamart(string fcTypedIdOrSourceName, ExportDatamartRequest payload, map<string|string[]> headers = {}, *ExportDatamartQueries queries) returns ExportDatamartResponse|error {
        ExportDatamartResponse|error r = self.oasClient->exportDatamart(fcTypedIdOrSourceName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportDatamart(fcTypedIdOrSourceName, payload, headers, queries = queries);
        }
        return r;
    }

    # Export an Excel File (XLSX)
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns the XLSX file (binary data): `Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` 
    remote isolated function exportExcelFileXlsx(ExportExcelFileRequest payload, map<string|string[]> headers = {}, *ExportExcelFileXlsxQueries queries) returns error? {
        error? r = self.oasClient->exportExcelFileXlsx(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportExcelFileXlsx(payload, headers, queries = queries);
        }
        return r;
    }

    # Export Models
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - A ZIP file containing the exported model JSON files 
    remote isolated function exportModels(OptimizationModelexportBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->exportModels(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportModels(payload, headers);
        }
        return r;
    }

    # Export a DOCX File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function exportQuoteDocx(string uniqueName, map<string|string[]> headers = {}, *ExportQuoteDocxQueries queries) returns error? {
        error? r = self.oasClient->exportQuoteDocx(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportQuoteDocx(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Export an Excel File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns a file data 
    remote isolated function exportQuoteExcel(string uniqueName, map<string|string[]> headers = {}, *ExportQuoteExcelQueries queries) returns error? {
        error? r = self.oasClient->exportQuoteExcel(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportQuoteExcel(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Export a PDF File
    #
    # + uniqueName - Specify the `uniqueName` of the quote you want to download
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - returns the file data 
    remote isolated function exportQuotePdf(string uniqueName, map<string|string[]> headers = {}, *ExportQuotePdfQueries queries) returns record {}|error {
        record {}|error r = self.oasClient->exportQuotePdf(uniqueName, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->exportQuotePdf(uniqueName, headers, queries = queries);
        }
        return r;
    }

    # Fetch Activities
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchActivities(ActivitylogFetchBody payload, map<string|string[]> headers = {}) returns record {}|FetchActivitiesEnvelope|error {
        record {}|FetchActivitiesEnvelope|error r = self.oasClient->fetchActivities(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->fetchActivities(payload, headers);
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
    # + return - OK 
    remote isolated function fetchDataMartObject(string objectId, GetDMObjectRequest payload, map<string|string[]> headers = {}, *FetchDataMartObjectQueries queries) returns GetDMObjectResponse|error {
        GetDMObjectResponse|error r = self.oasClient->fetchDataMartObject(objectId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->fetchDataMartObject(objectId, payload, headers, queries = queries);
        }
        return r;
    }

    # Fetch Pending Reviews
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function fetchPendingReviews(map<string|string[]> headers = {}) returns FetchPendingReviewsEnvelope|error {
        FetchPendingReviewsEnvelope|error r = self.oasClient->fetchPendingReviews(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->fetchPendingReviews(headers);
        }
        return r;
    }

    # Generate a JWT Token
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function generateJwtToken(GenerateJWTTokenRequest payload, map<string|string[]> headers = {}) returns GenerateJWTTokenResponse|error {
        GenerateJWTTokenResponse|error r = self.oasClient->generateJwtToken(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->generateJwtToken(payload, headers);
        }
        return r;
    }

    # Generate Parameters
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function generateParameters(GenerateParametersRequest payload, map<string|string[]> headers = {}) returns GenerateParametersResponse|error {
        GenerateParametersResponse|error r = self.oasClient->generateParameters(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->generateParameters(payload, headers);
        }
        return r;
    }

    # Generate a JWT Token (time limited)
    #
    # + minutes - The number of minutes in which the token expires
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function generateTimedJwtToken(string minutes, map<string|string[]> headers = {}) returns GenerateJWTTokenTimeLimitedResponse|error {
        GenerateJWTTokenTimeLimitedResponse|error r = self.oasClient->generateTimedJwtToken(minutes, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->generateTimedJwtToken(minutes, headers);
        }
        return r;
    }

    # Get Action Status
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getActionStatus(string actionUUID, map<string|string[]> headers = {}) returns GetActionStatusResponse|error {
        GetActionStatusResponse|error r = self.oasClient->getActionStatus(actionUUID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getActionStatus(actionUUID, headers);
        }
        return r;
    }

    # Get Advanced Configuration Property
    #
    # + propertyname - Name of the configuration property to retrieve
    # + headers - Headers to be sent with the request 
    # + return - Property found 
    remote isolated function getAdvancedConfigurationProperty(string propertyname, map<string|string[]> headers = {}) returns AdvancedConfigPropertyEnvelope|error {
        AdvancedConfigPropertyEnvelope|error r = self.oasClient->getAdvancedConfigurationProperty(propertyname, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getAdvancedConfigurationProperty(propertyname, headers);
        }
        return r;
    }

    # Get a Calculation Grid
    #
    # + id - ID of the Calculation Grid you want to retrieve
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getCalculationGrid(string id, record {} payload, map<string|string[]> headers = {}) returns GetCalculationGridResponse|error {
        GetCalculationGridResponse|error r = self.oasClient->getCalculationGrid(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCalculationGrid(id, payload, headers);
        }
        return r;
    }

    # Get a Calculation Grid Item
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + id - `id` of the Calculation Grid Item you want to fetch
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getCalculationGridItem("1"|"2"|"3"|"4"|"5"|"6" keyNumber, string id, record {} payload, map<string|string[]> headers = {}) returns GetCalculationGridItemResponse|error {
        GetCalculationGridItemResponse|error r = self.oasClient->getCalculationGridItem(keyNumber, id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCalculationGridItem(keyNumber, id, payload, headers);
        }
        return r;
    }

    # Get a Calculation Status
    #
    # + typedId - The `typedId` of the Model Object you want to retrieve the calculation status for
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getCalculationStatus(string typedId, map<string|string[]> headers = {}) returns JobStatusTrackerResponse|error {
        JobStatusTrackerResponse|error r = self.oasClient->getCalculationStatus(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCalculationStatus(typedId, headers);
        }
        return r;
    }

    # Get a Temporary Data
    #
    # + typedId - `typedId` of the Quote you want to retrieve the temporary data from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getClicDraftHeader(string typedId, record {} payload, map<string|string[]> headers = {}) returns ClicDraftHeaderEnvelope|error {
        ClicDraftHeaderEnvelope|error r = self.oasClient->getClicDraftHeader(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getClicDraftHeader(typedId, payload, headers);
        }
        return r;
    }

    # Get Folder Statistics
    #
    # + typedId - typedId of the document whose folder statistics you want to fetch
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function getClicFolderStats(string typedId, map<string|string[]> headers = {}, *GetClicFolderStatsQueries queries) returns ClicFolderStatsEnvelope|error {
        ClicFolderStatsEnvelope|error r = self.oasClient->getClicFolderStats(typedId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getClicFolderStats(typedId, headers, queries = queries);
        }
        return r;
    }

    # Get a Quote/Contract/Rebate Agreement/Compensation Plan Header
    #
    # + typedId - The `typedId` of the Contract, Quote, or Rebate Agreement you want to return details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getClicHeader(string typedId, map<string|string[]> headers = {}) returns GetQuoteContractRebateAgreementResponse|error {
        GetQuoteContractRebateAgreementResponse|error r = self.oasClient->getClicHeader(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getClicHeader(typedId, headers);
        }
        return r;
    }

    # Get a Condition Record Item
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getConditionRecordItem(record {} payload, map<string|string[]> headers = {}) returns ConditionRecordItemEnvelope|error {
        ConditionRecordItemEnvelope|error r = self.oasClient->getConditionRecordItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getConditionRecordItem(payload, headers);
        }
        return r;
    }

    # Get a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getConditionRecordItemMeta(FetchCRCIMBody payload, map<string|string[]> headers = {}) returns ConditionRecordItemMetaEnvelope|error {
        ConditionRecordItemMetaEnvelope|error r = self.oasClient->getConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Get Condition Record Set Items With Set Id Validation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getConditionRecordSetItems(ConditionrecordsetFetchCRCI3Body payload, map<string|string[]> headers = {}) returns ConditionRecordSetItemsEnvelope|error {
        ConditionRecordSetItemsEnvelope|error r = self.oasClient->getConditionRecordSetItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getConditionRecordSetItems(payload, headers);
        }
        return r;
    }

    # Get a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getConfigurationStorage(FetchJCSBody payload, map<string|string[]> headers = {}) returns GetConfigurationStorageEnvelope|error {
        GetConfigurationStorageEnvelope|error r = self.oasClient->getConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Get a Contract
    #
    # + uniqueName - `uniqueName` of the Contract you want to retrieve details for. Alternatively, `typedId` can be also used
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getContract(string uniqueName, map<string|string[]> headers = {}) returns contractModelResponse|error {
        contractModelResponse|error r = self.oasClient->getContract(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getContract(uniqueName, headers);
        }
        return r;
    }

    # Get a Custom Form
    #
    # + typedId - The `typedId` of the Custom Form you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getCustomForm(string typedId, map<string|string[]> headers = {}) returns GetCustomFormResponse|error {
        GetCustomFormResponse|error r = self.oasClient->getCustomForm(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCustomForm(typedId, headers);
        }
        return r;
    }

    # Get a Customer
    #
    # + id - The ID of the Customer you want to retrieve details for. The `id` is the `typedId` without the **C** suffix. For example, the `id` parameter of the item with `typedId` = **2147492200.C**  is **2147492200**
    # + headers - Headers to be sent with the request 
    # + return - Returns customer record details 
    remote isolated function getCustomer(string id, map<string|string[]> headers = {}) returns customerResponse|error {
        customerResponse|error r = self.oasClient->getCustomer(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getCustomer(id, headers);
        }
        return r;
    }

    # Get a Data Change Request
    #
    # + id - `id` of the Data Change Request you want to retrieve
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDataChangeRequest(string id, GetDCRRequest payload, map<string|string[]> headers = {}) returns GetDCRResponse|error {
        GetDCRResponse|error r = self.oasClient->getDataChangeRequest(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDataChangeRequest(id, payload, headers);
        }
        return r;
    }

    # Get a Data Change Request (changes only)
    #
    # + id - `id` of the Data Change Request you want to retrieve changed items for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDataChangeRequestChanges(string id, GetDCRRequestChangeOnly payload, map<string|string[]> headers = {}) returns GetDCRResponseChangeOnly|error {
        GetDCRResponseChangeOnly|error r = self.oasClient->getDataChangeRequestChanges(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDataChangeRequestChanges(id, payload, headers);
        }
        return r;
    }

    # Get Data Change Request Mass Changes
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDataChangeRequestMassChanges(string id, DcrmanagerFetchmassopidBody payload, map<string|string[]> headers = {}) returns DataChangeRequestMassChangeEnvelope|error {
        DataChangeRequestMassChangeEnvelope|error r = self.oasClient->getDataChangeRequestMassChanges(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDataChangeRequestMassChanges(id, payload, headers);
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
    remote isolated function getDataMartObject(string objectId, map<string|string[]> headers = {}, *GetDataMartObjectQueries queries) returns DataMartObjectEnvelope|error {
        DataMartObjectEnvelope|error r = self.oasClient->getDataMartObject(objectId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDataMartObject(objectId, headers, queries = queries);
        }
        return r;
    }

    # Get a Default Pricing Logic Name
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDefaultPricingLogicName(map<string|string[]> headers = {}) returns GetDefaultPricingLogicNameResponse|error {
        GetDefaultPricingLogicNameResponse|error r = self.oasClient->getDefaultPricingLogicName(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDefaultPricingLogicName(headers);
        }
        return r;
    }

    # Get a DM Export File
    #
    # + fileName - The name of the file previously created by a `datamart.export` request. The filename needs to be an exact match - no wildcards allowed, hence only one file at the time can be fetched
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getDmExportFile(string fileName, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->getDmExportFile(fileName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDmExportFile(fileName, headers);
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
    # + return - OK 
    remote isolated function getDmObjectNo(string objectId, GetDMObjectNoCountRequest payload, map<string|string[]> headers = {}) returns GetDMObjectNoCountResponse|error {
        GetDMObjectNoCountResponse|error r = self.oasClient->getDmObjectNo(objectId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getDmObjectNo(objectId, payload, headers);
        }
        return r;
    }

    # Get External Application Properties
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getExternalApplicationProperties(map<string|string[]> headers = {}) returns GetexternalapppropertiesResponse|error {
        GetexternalapppropertiesResponse|error r = self.oasClient->getExternalApplicationProperties(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getExternalApplicationProperties(headers);
        }
        return r;
    }

    # Get a Key
    #
    # + tableName - A name of the table you want to retrieve the "payload" from
    # + headers - Headers to be sent with the request 
    # + return - OK. The "payload" is returned 
    remote isolated function getKey(string tableName, GetKVKeyRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->getKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getKey(tableName, payload, headers);
        }
        return r;
    }

    # Get a Live Price Grid
    #
    # + id - The `id` of the Live Price Grid you want to retrieve details for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLivePriceGrid(string id, map<string|string[]> headers = {}) returns GetLivePriceGridResponse|error {
        GetLivePriceGridResponse|error r = self.oasClient->getLivePriceGrid(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getLivePriceGrid(id, headers);
        }
        return r;
    }

    # Get a Logic
    #
    # + id - The ID of the logic you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLogic(string id, map<string|string[]> headers = {}) returns GetLogicResponse|error {
        GetLogicResponse|error r = self.oasClient->getLogic(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getLogic(id, headers);
        }
        return r;
    }

    # Get Logic References
    #
    # + tableId - Enter the ID of the table you want to retrieve logic references for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getLogicReferences(string tableId, map<string|string[]> headers = {}) returns GetLogicReferencesResponse|error {
        GetLogicReferencesResponse|error r = self.oasClient->getLogicReferences(tableId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getLogicReferences(tableId, headers);
        }
        return r;
    }

    # Get a Loki Log
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function getLokiLog(map<string|string[]> headers = {}, *GetLokiLogQueries queries) returns LokiLogEnvelope|error {
        LokiLogEnvelope|error r = self.oasClient->getLokiLog(headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getLokiLog(headers, queries = queries);
        }
        return r;
    }

    # Get MCP Roles
    #
    # + headers - Headers to be sent with the request 
    # + return - Roles received 
    remote isolated function getMcpRoles(map<string|string[]> headers = {}) returns McpRolesEnvelope|error {
        McpRolesEnvelope|error r = self.oasClient->getMcpRoles(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMcpRoles(headers);
        }
        return r;
    }

    # Get MCP Tools
    #
    # + headers - Headers to be sent with the request 
    # + return - Roles received 
    remote isolated function getMcpTools(map<string|string[]> headers = {}) returns McpToolsEnvelope|error {
        McpToolsEnvelope|error r = self.oasClient->getMcpTools(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getMcpTools(headers);
        }
        return r;
    }

    # 1. Create an Upload Slot
    #
    # + headers - Headers to be sent with the request 
    # + return - Slot created 
    remote isolated function getNewUploadSlot(map<string|string[]> headers = {}) returns CreateUploadSlotResponse|error {
        CreateUploadSlotResponse|error r = self.oasClient->getNewUploadSlot(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getNewUploadSlot(headers);
        }
        return r;
    }

    # Get a One Time Token
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getOneTimeToken(map<string|string[]> headers = {}) returns GetOneTimeTokenResponse|error {
        GetOneTimeTokenResponse|error r = self.oasClient->getOneTimeToken(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getOneTimeToken(headers);
        }
        return r;
    }

    # Get a Parallel Calculation Item
    #
    # + id - `id` of the Parallel Calculation Item (PCI) you want to retrieve
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getParallelCalculationItem(string id, record {} payload, map<string|string[]> headers = {}) returns GetParallelCalculationItemResponse|error {
        GetParallelCalculationItemResponse|error r = self.oasClient->getParallelCalculationItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getParallelCalculationItem(id, payload, headers);
        }
        return r;
    }

    # Get a Price List
    #
    # + id - The ID of the Price List you want to retrieve details for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getPriceList(string id, map<string|string[]> headers = {}) returns GetPriceListResponse|error {
        GetPriceListResponse|error r = self.oasClient->getPriceList(id, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getPriceList(id, headers);
        }
        return r;
    }

    # Get Product Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getProductAttributeMeta(record {} payload, map<string|string[]> headers = {}) returns ProductAttributeMetaEnvelope|error {
        ProductAttributeMetaEnvelope|error r = self.oasClient->getProductAttributeMeta(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getProductAttributeMeta(payload, headers);
        }
        return r;
    }

    # List BoM for a Product
    #
    # + sku - The `sku` of the product you want to retrieve the Bill of Materials for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getProductBomTree(string sku, map<string|string[]> headers = {}) returns ListBoMForProductResponse|error {
        ListBoMForProductResponse|error r = self.oasClient->getProductBomTree(sku, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getProductBomTree(sku, headers);
        }
        return r;
    }

    # Get Competition Data
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getProductCompetition(GetCompetitionDataRequest payload, map<string|string[]> headers = {}) returns GetCompetitionDataResponse|error {
        GetCompetitionDataResponse|error r = self.oasClient->getProductCompetition(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getProductCompetition(payload, headers);
        }
        return r;
    }

    # Get a Product Set
    #
    # + label - Enter the name of the product set you want to retrieve
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getProductSetCompetition(string label, GetProductSetRequest payload, map<string|string[]> headers = {}) returns GetProductSetResponse|error {
        GetProductSetResponse|error r = self.oasClient->getProductSetCompetition(label, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getProductSetCompetition(label, payload, headers);
        }
        return r;
    }

    # Get Query API Metadata
    #
    # + headers - Headers to be sent with the request 
    # + return - Metadata returned 
    remote isolated function getQueryApiMetadata(QueryapiExecuteBody payload, map<string|string[]> headers = {}) returns QueryApiMetadataEnvelope|error {
        QueryApiMetadataEnvelope|error r = self.oasClient->getQueryApiMetadata(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getQueryApiMetadata(payload, headers);
        }
        return r;
    }

    # Get a Quote
    #
    # + typedID - Enter the quote typed ID. You get the `typedId` in the response when fetching all quotes using the `/quotemanager.fetchlist` endpoint
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getQuote(string typedID, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->getQuote(typedID, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getQuote(typedID, headers);
        }
        return r;
    }

    # Get a Rebate Agreement
    #
    # + uniqueName - The `uniqueName` of the Rebate Agreement you want to retrieve details for
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getRebateAgreement(string uniqueName, map<string|string[]> headers = {}) returns rebateagreementResponse|error {
        rebateagreementResponse|error r = self.oasClient->getRebateAgreement(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRebateAgreement(uniqueName, headers);
        }
        return r;
    }

    # Get a Rebate Record Group
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getRebateRecordGroup(record {} payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->getRebateRecordGroup(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getRebateRecordGroup(payload, headers);
        }
        return r;
    }

    # Get a Seller Extension
    #
    # + sellerId - The `SellerId` of the seller in the Seller Extension table you want to retrieve details for
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSellerExtension(string sellerId, string sXCategory, map<string|string[]> headers = {}) returns SellerExtensionEnvelope|error {
        SellerExtensionEnvelope|error r = self.oasClient->getSellerExtension(sellerId, sXCategory, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSellerExtension(sellerId, sXCategory, headers);
        }
        return r;
    }

    # Get a Signature Status
    #
    # + typedId - `typedId` of the Compensation document you want to retrieve the signature status for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSignatureStatus(string typedId, record {} payload, map<string|string[]> headers = {}) returns GetSignatureStatusResponse|error {
        GetSignatureStatusResponse|error r = self.oasClient->getSignatureStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSignatureStatus(typedId, payload, headers);
        }
        return r;
    }

    # Get a Signed Document
    #
    # + uniqueName - A `uniqueName` of the Compensation Plan you want to download a signed file for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSignedDocument(string uniqueName, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->getSignedDocument(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSignedDocument(uniqueName, headers);
        }
        return r;
    }

    # Get a Step Calculation Status
    #
    # + typedId - The `typedId` of the Model Object you want to retrieve the calculation status for
    # + stepName - The name of the step you want to calculate
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function getStepCalculationStatus(string typedId, string stepName, map<string|string[]> headers = {}) returns JobStatusTrackerResponse|error {
        JobStatusTrackerResponse|error r = self.oasClient->getStepCalculationStatus(typedId, stepName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getStepCalculationStatus(typedId, stepName, headers);
        }
        return r;
    }

    # Get a Summary
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getSummary(string typedId, record {} payload, map<string|string[]> headers = {}) returns GetClaimItemsSummaryResponse|error {
        GetClaimItemsSummaryResponse|error r = self.oasClient->getSummary(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getSummary(typedId, payload, headers);
        }
        return r;
    }

    # Get a Table Info
    #
    # + tableName - A name of the table you want to retrieve information about
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getTableInfo(string tableName, map<string|string[]> headers = {}) returns GetKVTableInfoResponse|error {
        GetKVTableInfoResponse|error r = self.oasClient->getTableInfo(tableName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getTableInfo(tableName, headers);
        }
        return r;
    }

    # Get Upload Progress
    #
    # + uploadslot - Upload Slot Id
    # + headers - Headers to be sent with the request 
    # + return - The request response contains the current status of the upload slot, including progress information 
    remote isolated function getUploadProgress(string uploadslot, map<string|string[]> headers = {}) returns UploadSlotOperationEnvelope|error {
        UploadSlotOperationEnvelope|error r = self.oasClient->getUploadProgress(uploadslot, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getUploadProgress(uploadslot, headers);
        }
        return r;
    }

    # Get a User Audit Report
    #
    # + typeCode - Specify whether you want to retrieve a report based on user roles (`R`), user groups (`UG`), or business roles (`BR`)
    # + id - Specify the `id`of the user role, user group, or business role for which you want to retrieve users. Call the `/fetch/R`, `/fetch/UG`, or `/fetch/BR` endpoint to retrieve a list with corresponding user roles, user groups, or business roles
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getUserAuditReport("R"|"UG"|"BR" typeCode, string id, record {} payload, map<string|string[]> headers = {}) returns UserAuditReportEnvelope|error {
        UserAuditReportEnvelope|error r = self.oasClient->getUserAuditReport(typeCode, id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getUserAuditReport(typeCode, id, payload, headers);
        }
        return r;
    }

    # Get a Workflow Document
    #
    # + typedId - The `typedId` of the approvable object you want to retrieve workflow details for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function getWorkflowDocument(string typedId, map<string|string[]> headers = {}) returns GetWorkflowDocumentResponse|error {
        GetWorkflowDocumentResponse|error r = self.oasClient->getWorkflowDocument(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->getWorkflowDocument(typedId, headers);
        }
        return r;
    }

    # Import Line Items (w/o Input Types)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - `ServerMessageExtended` property contains information about what was imported 
    remote isolated function importClicLineItems(string typedId, ClicmanagerImportlineitemstypedIdBody payload, map<string|string[]> headers = {}) returns ClicOperationEnvelope|error {
        ClicOperationEnvelope|error r = self.oasClient->importClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Import a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function importDataLoad(ImportDataLoadRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->importDataLoad(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importDataLoad(payload, headers);
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
        error? r = self.oasClient->importDataMartFile(slotId, typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importDataMartFile(slotId, typedId, headers);
        }
        return r;
    }

    # Import Models
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function importModels(OptimizationModelimportBody payload, map<string|string[]> headers = {}) returns ModelDuplicationEnvelope|error {
        ModelDuplicationEnvelope|error r = self.oasClient->importModels(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importModels(payload, headers);
        }
        return r;
    }

    # Import Competition Data
    #
    # + headers - Headers to be sent with the request 
    # + payload - The competition product details 
    # + return - OK 
    remote isolated function importProductCompetition(ImportCompetitionDataRequest payload, map<string|string[]> headers = {}) returns ImportCompetitionDataResponse|error {
        ImportCompetitionDataResponse|error r = self.oasClient->importProductCompetition(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importProductCompetition(payload, headers);
        }
        return r;
    }

    # Import a File
    #
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + slotId - The ID that is returned by the **/uploadmanager.newuploadslot** (Create an Upload Slot) endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Accepted 
    remote isolated function importSellerExtensionFile(string sXCategory, string slotId, ImportSXFileRequest payload, map<string|string[]> headers = {}, *ImportSellerExtensionFileQueries queries) returns error? {
        error? r = self.oasClient->importSellerExtensionFile(sXCategory, slotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->importSellerExtensionFile(sXCategory, slotId, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Customer Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify customer extension field names in the `header` object and field values in the `data` object.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function insertBulkCustomerExtensions(InsertBulkCustomerExtensionsRequest payload, map<string|string[]> headers = {}) returns loaddataResponse|error {
        loaddataResponse|error r = self.oasClient->insertBulkCustomerExtensions(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkCustomerExtensions(payload, headers);
        }
        return r;
    }

    # Insert Bulk Data
    #
    # + typeCode - Specify the type code for the entity you want to work with. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article.'
    # + headers - Headers to be sent with the request 
    # + payload - The **`/loaddata/P`** endpoint (Insert Bulk Products) is used in our example.<p> 
    # + return - Returns the number of inserted or updated objects 
    remote isolated function insertBulkData(TypeCodeEnum typeCode, InsertBulkDataRequest payload, map<string|string[]> headers = {}) returns loaddataResponse|error {
        loaddataResponse|error r = self.oasClient->insertBulkData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkData(typeCode, payload, headers);
        }
        return r;
    }

    # Insert Bulk Data From a File
    #
    # + typeCode - Enter the type code of the entity you want to insert a data to. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function insertBulkDataFromFile("C"|"CDESC"|"CX"|"JLTV"|"LTV"|"MLTV"|"P"|"PBOME"|"PCOMP"|"PDESC"|"PR"|"PX"|"PXREF"|"SL"|"SX"|"TODO"|"UG" typeCode, InsertBulkDataFromFileRequest payload, map<string|string[]> headers = {}, *InsertBulkDataFromFileQueries queries) returns InsertBulkDataFromFileResponse|error {
        InsertBulkDataFromFileResponse|error r = self.oasClient->insertBulkDataFromFile(typeCode, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkDataFromFile(typeCode, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Data From a File (async)
    #
    # + typeCode - Enter the type code of the entity you want to insert a data to. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function insertBulkDataFromFileAsync("C"|"CDESC"|"CX"|"JLTV"|"LTV"|"MLTV"|"P"|"PBOME"|"PCOMP"|"PDESC"|"PR"|"PX"|"PXREF"|"SL"|"SX"|"TODO"|"UG" typeCode, InsertBulkDataFromFileAsyncRequest payload, map<string|string[]> headers = {}, *InsertBulkDataFromFileAsyncQueries queries) returns InsertBulkDataFromFileAsyncResponse|error {
        InsertBulkDataFromFileAsyncResponse|error r = self.oasClient->insertBulkDataFromFileAsync(typeCode, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkDataFromFileAsync(typeCode, payload, headers, queries = queries);
        }
        return r;
    }

    # Insert Bulk Data to Lookup Table
    #
    # + typeCode - Enter the type code of the Lookup Table entity you want to insert a data to
    # + headers - Headers to be sent with the request 
    # + payload - We used `/lookuptablemanager.loaddata/MLTV` in the request example to insert bulk data to Matrix Lookup Table. Notice that the `lookupTable` is used in the `header` section and then ID of the Lookup Table in the `data` section 
    # + return - OK 
    remote isolated function insertBulkDataToLookupTable("JLTV"|"JLTVM"|"LT"|"LTT"|"LTV"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM" typeCode, InsertBulkDataToLookupTableRequest payload, map<string|string[]> headers = {}) returns InsertBulkDataLookupTableResponse|error {
        InsertBulkDataLookupTableResponse|error r = self.oasClient->insertBulkDataToLookupTable(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkDataToLookupTable(typeCode, payload, headers);
        }
        return r;
    }

    # Insert Bulk KV Data
    #
    # + tableName - A name of the table you want upload data to
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function insertBulkKvData(string tableName, InsertBulkKVDataRequest payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->insertBulkKvData(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkKvData(tableName, payload, headers);
        }
        return r;
    }

    # Insert Bulk Product Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify product extension field names in the `header` object and field values in the `data` object 
    # + return - OK 
    remote isolated function insertBulkProductExtensions(InsertBulkProductExtensionsRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->insertBulkProductExtensions(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkProductExtensions(payload, headers);
        }
        return r;
    }

    # Insert Bulk Seller Extensions
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify seller extension field names in the `header` object and field values in the `data` object 
    # + return - OK 
    remote isolated function insertBulkSellerExtensions(InsertBulkProductExtensionsRequest1 payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->insertBulkSellerExtensions(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->insertBulkSellerExtensions(payload, headers);
        }
        return r;
    }

    # List Accrual Records
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listAccrualRecords(ListAccrualRecordsRequest payload, map<string|string[]> headers = {}) returns ListAccrualRecordsResponse|error {
        ListAccrualRecordsResponse|error r = self.oasClient->listAccrualRecords(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAccrualRecords(payload, headers);
        }
        return r;
    }

    # List Action Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listActionItems(FetchAIBody payload, map<string|string[]> headers = {}) returns ListActionItemsResponse|error {
        ListActionItemsResponse|error r = self.oasClient->listActionItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listActionItems(payload, headers);
        }
        return r;
    }

    # List Action Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - A general fetch request. A filter can be applied 
    # + return - OK 
    remote isolated function listActionTypes(record {int endRow?; record {}? oldValues?; string operationType?; int startRow?; string textMatchStyle?; record {string _constructor?; string operator?; record {string fieldName?; string operator?; string value?;}[] criteria?;} data?;} payload, map<string|string[]> headers = {}) returns ListActionTypesResponse|error {
        ListActionTypesResponse|error r = self.oasClient->listActionTypes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listActionTypes(payload, headers);
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
    remote isolated function listAllLookupTableValues(string tableId, ListAllLookupTableValuesRequest payload, map<string|string[]> headers = {}, *ListAllLookupTableValuesQueries queries) returns ListAllLookupTableValuesResponse|error {
        ListAllLookupTableValuesResponse|error r = self.oasClient->listAllLookupTableValues(tableId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAllLookupTableValues(tableId, payload, headers, queries = queries);
        }
        return r;
    }

    # List All Lookup Tables
    #
    # + headers - Headers to be sent with the request 
    # + payload - You can specify the start and end row to limit the number of retrieved Lookup Tables / Company Parameters 
    # + return - Returns the Company Parameter table / Lookup table fields. The `name` property is the same as `uniqueName` if the `owner` is `null`. If the `owner` field is non-null, then the `name` will be the name of the table (DMT or LT) in the context of the owner 
    remote isolated function listAllLookupTables(ListAllLookupTablesRequest payload, map<string|string[]> headers = {}) returns ListAllLookupTablesResponse|error {
        ListAllLookupTablesResponse|error r = self.oasClient->listAllLookupTables(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAllLookupTables(payload, headers);
        }
        return r;
    }

    # List Attribute Fields' Metadata
    #
    # + typeCode - Enter the type code of the entity you want to retrieve information for. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listAttributeFieldsMetadata("ACTT"|"AI"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CL"|"CLLI"|"CLLIAM"|"CLR"|"CLT"|"CN"|"CO"|"COAM"|"COCT"|"COCTAM"|"COHT"|"COHTAM"|"COLI"|"COR"|"CORAM"|"COROLI"|"CORS"|"CORSC"|"COT"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX10"|"CX20"|"CX3"|"CX30"|"CX50"|"CX6"|"CX8"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DP"|"DPR"|"DPT"|"DREF"|"DREG"|"EDL"|"ET"|"EVT"|"F"|"FE"|"FN"|"HEVT"|"HRT"|"HRTAM"|"IDC"|"IE"|"ISH"|"JLTV"|"JLTV2"|"JLTVM"|"JST"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MC"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MN"|"MO"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"NT"|"P"|"PAM"|"PBOME"|"PCOMP"|"PCOMPCO"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLPGTT"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX10"|"PX20"|"PX3"|"PX30"|"PX50"|"PX6"|"PX8"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAROLI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"SL"|"SLAM"|"SX10"|"SX20"|"SX3"|"SX30"|"SX50"|"SX6"|"SX8"|"SXAM"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, map<string|string[]> headers = {}, *ListAttributeFieldsMetadataQueries queries) returns ListAttributeFieldsMetadata|error {
        ListAttributeFieldsMetadata|error r = self.oasClient->listAttributeFieldsMetadata(typeCode, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listAttributeFieldsMetadata(typeCode, headers, queries = queries);
        }
        return r;
    }

    # List Calculated Field Sets
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCalculatedFieldSets(map<string|string[]> headers = {}) returns ListCalculatedFieldSetsResponse|error {
        ListCalculatedFieldSetsResponse|error r = self.oasClient->listCalculatedFieldSets(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCalculatedFieldSets(headers);
        }
        return r;
    }

    # List Calculation Grid Items
    #
    # + keyNumber - Use CGI1..CGI6 in the path, where numbers from 1 to 6 refer to Calculation Grid Item keys
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCalculationGridItems("1"|"2"|"3"|"4"|"5"|"6" keyNumber, ListCalculationGridItemsRequest payload, map<string|string[]> headers = {}) returns ListCalculationGridItemsResponse|error {
        ListCalculationGridItemsResponse|error r = self.oasClient->listCalculationGridItems(keyNumber, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCalculationGridItems(keyNumber, payload, headers);
        }
        return r;
    }

    # List Calculation Grids
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCalculationGrids(record {} payload, map<string|string[]> headers = {}) returns ListCalculationGridsResponse|error {
        ListCalculationGridsResponse|error r = self.oasClient->listCalculationGrids(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCalculationGrids(payload, headers);
        }
        return r;
    }

    # List Calculations
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCalculations(ListCalculationsRequest payload, map<string|string[]> headers = {}) returns ListCalculationsResponse|error {
        ListCalculationsResponse|error r = self.oasClient->listCalculations(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCalculations(payload, headers);
        }
        return r;
    }

    # List Charts
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCharts(map<string|string[]> headers = {}) returns ListChartsResponse|error {
        ListChartsResponse|error r = self.oasClient->listCharts(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCharts(headers);
        }
        return r;
    }

    # List Claim Types
    #
    # + headers - Headers to be sent with the request 
    # + payload - The example of the request body contains the filter. The call returns Claim Types whose `name` equals to "claimType" 
    # + return - OK 
    remote isolated function listClaimTypes(ListClaimTypesRequest payload, map<string|string[]> headers = {}) returns ListClaimTypesResponse|error {
        ListClaimTypesResponse|error r = self.oasClient->listClaimTypes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listClaimTypes(payload, headers);
        }
        return r;
    }

    # List Claims
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function listClaims(ListClaimsRequest payload, map<string|string[]> headers = {}) returns ListClaimsResponse|error {
        ListClaimsResponse|error r = self.oasClient->listClaims(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listClaims(payload, headers);
        }
        return r;
    }

    # List CLIC Objects
    #
    # + typedId - The `typedId` of the Quote/Contract/Rebate Agreement/Compensation Plan you want to retrieve line items for
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listClicObjects(string typedId, GetCLICrequest payload, map<string|string[]> headers = {}, *ListClicObjectsQueries queries) returns GetCLICresponse|error {
        GetCLICresponse|error r = self.oasClient->listClicObjects(typedId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listClicObjects(typedId, payload, headers, queries = queries);
        }
        return r;
    }

    # List Comment Threads
    #
    # + typedId - typedId of the object you want to fetch comments for
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCommentThreads(string typedId, CommentmanagerFetchthreadstypedIdBody payload, map<string|string[]> headers = {}, *ListCommentThreadsQueries queries) returns ListCommentThreadsEnvelope|error {
        ListCommentThreadsEnvelope|error r = self.oasClient->listCommentThreads(typedId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCommentThreads(typedId, payload, headers, queries = queries);
        }
        return r;
    }

    # List Compensation Plans
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCompensationPlans(ListCompensationPlansRequest payload, map<string|string[]> headers = {}) returns ListCompensationPlansResponse|error {
        ListCompensationPlansResponse|error r = self.oasClient->listCompensationPlans(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCompensationPlans(payload, headers);
        }
        return r;
    }

    # List Compensation Records
    #
    # + compensationRecordSetId - ID of the CompensationRecordSet into which this Compensation Record belongs. By default it belongs to "Default" CompensationRecordSet, but you can change it when you create the Compensation Record. This can be useful if you create different "kinds" of Compensation Records which will be used to calculate different results at different times
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCompensationRecords(string compensationRecordSetId, ListCompensationRecordsRequest payload, map<string|string[]> headers = {}) returns ListCompensationRecordsResponse|error {
        ListCompensationRecordsResponse|error r = self.oasClient->listCompensationRecords(compensationRecordSetId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCompensationRecords(compensationRecordSetId, payload, headers);
        }
        return r;
    }

    # List Compensation Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCompensationTypes(ListCompensationTypesRequest payload, map<string|string[]> headers = {}) returns ListCompensationTypesEnvelope|error {
        ListCompensationTypesEnvelope|error r = self.oasClient->listCompensationTypes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCompensationTypes(payload, headers);
        }
        return r;
    }

    # List Condition Record Sets
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listConditionRecordSets(record {} payload, map<string|string[]> headers = {}) returns ListConditionRecordSetsEnvelope|error {
        ListConditionRecordSetsEnvelope|error r = self.oasClient->listConditionRecordSets(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listConditionRecordSets(payload, headers);
        }
        return r;
    }

    # List Condition Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listConditionTypes(ListConditionTypesRequest payload, map<string|string[]> headers = {}) returns ListConditionTypesEnvelope|error {
        ListConditionTypesEnvelope|error r = self.oasClient->listConditionTypes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listConditionTypes(payload, headers);
        }
        return r;
    }

    # List Contract Calculations
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listContractCalculations(record {} payload, map<string|string[]> headers = {}) returns ListContractCalculationsEnvelope|error {
        ListContractCalculationsEnvelope|error r = self.oasClient->listContractCalculations(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listContractCalculations(payload, headers);
        }
        return r;
    }

    # List Contract Price Records
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listContractPriceRecords(FetchCPRBody payload, map<string|string[]> headers = {}) returns ListContractPriceRecords|error {
        ListContractPriceRecords|error r = self.oasClient->listContractPriceRecords(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listContractPriceRecords(payload, headers);
        }
        return r;
    }

    # List Contracts
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listContracts(ListContractsRequest payload, map<string|string[]> headers = {}) returns contractResponse|error {
        contractResponse|error r = self.oasClient->listContracts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listContracts(payload, headers);
        }
        return r;
    }

    # List Custom Form Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCustomFormTypes(ListCustomFormTypesRequest payload, map<string|string[]> headers = {}) returns ListCustomFormTypesResponse|error {
        ListCustomFormTypesResponse|error r = self.oasClient->listCustomFormTypes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCustomFormTypes(payload, headers);
        }
        return r;
    }

    # List Custom Forms
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listCustomForms(ListCustomFormsRequest payload, map<string|string[]> headers = {}) returns ListCustomFormsEnvelope|error {
        ListCustomFormsEnvelope|error r = self.oasClient->listCustomForms(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCustomForms(payload, headers);
        }
        return r;
    }

    # List Customer Assignments
    #
    # + typedId - The `typedId` of the entity you want to retrieve assignments for
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listCustomerAssignments(string typedId, ListCustomerAssignmentsRequest payload, map<string|string[]> headers = {}) returns assignmentResponse|error {
        assignmentResponse|error r = self.oasClient->listCustomerAssignments(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCustomerAssignments(typedId, payload, headers);
        }
        return r;
    }

    # List Customer Extension Objects
    #
    # + customerMasterExtensionName - Enter the name of Customer Extension you want to retrieve objects from. You can find the name in **Administration** > **Configuration** > **Master Data** > **Customer Master Extension** or using the **/configurationmanager.get/customerextension** endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listCustomerExtensionObjects(string customerMasterExtensionName, ListCustomerExtensionObjectsRequest payload, map<string|string[]> headers = {}, *ListCustomerExtensionObjectsQueries queries) returns ListCustomerExtensionObjectsResponse|error {
        ListCustomerExtensionObjectsResponse|error r = self.oasClient->listCustomerExtensionObjects(customerMasterExtensionName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCustomerExtensionObjects(customerMasterExtensionName, payload, headers, queries = queries);
        }
        return r;
    }

    # List Customers
    #
    # + headers - Headers to be sent with the request 
    # + return - Returns customer record details 
    remote isolated function listCustomers(ListCustomersRequest payload, map<string|string[]> headers = {}) returns customerResponse|error {
        customerResponse|error r = self.oasClient->listCustomers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listCustomers(payload, headers);
        }
        return r;
    }

    # List Data Loads
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDataLoads(map<string|string[]> headers = {}) returns ListDataLoadsResponse|error {
        ListDataLoadsResponse|error r = self.oasClient->listDataLoads(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDataLoads(headers);
        }
        return r;
    }

    # List Data Loads (with validation and schedules)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDataLoadsWith(map<string|string[]> headers = {}) returns ListDataLoadsWithValidationResponse|error {
        ListDataLoadsWithValidationResponse|error r = self.oasClient->listDataLoadsWith(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDataLoadsWith(headers);
        }
        return r;
    }

    # List Data Manager Entities
    #
    # + typeCode - The type code of the **Field Collection**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listDataManagerEntities("DM"|"DMDS"|"DMF"|"DMT" typeCode, ListDataManagerEntitiesRequest payload, map<string|string[]> headers = {}) returns dmobjectResponse|error {
        dmobjectResponse|error r = self.oasClient->listDataManagerEntities(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDataManagerEntities(typeCode, payload, headers);
        }
        return r;
    }

    # List Datamart Orphan Objects
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDatamartOrphanObjects(map<string|string[]> headers = {}) returns DatamartOrphanObjectsEnvelope|error {
        DatamartOrphanObjectsEnvelope|error r = self.oasClient->listDatamartOrphanObjects(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDatamartOrphanObjects(headers);
        }
        return r;
    }

    # List Delegated Workflows
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listDelegatedWorkflows(ListDelegatedWorkflowsRequest payload, map<string|string[]> headers = {}) returns ListDelegatedWorkflowsResponse|error {
        ListDelegatedWorkflowsResponse|error r = self.oasClient->listDelegatedWorkflows(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listDelegatedWorkflows(payload, headers);
        }
        return r;
    }

    # List Elements
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to list elements for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listElements(string uniqueName, map<string|string[]> headers = {}) returns ListElementsResponse|error {
        ListElementsResponse|error r = self.oasClient->listElements(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listElements(uniqueName, headers);
        }
        return r;
    }

    # List Email Tasks
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listEmailTasks(NotificationListBody payload, map<string|string[]> headers = {}) returns ListEmailTasksEnvelope|error {
        ListEmailTasksEnvelope|error r = self.oasClient->listEmailTasks(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listEmailTasks(payload, headers);
        }
        return r;
    }

    # List Entity Fields
    #
    # + typeCode - Enter the type code of the entity you want to retrieve information for. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function listEntityFields("ACTT"|"AI"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CL"|"CLLI"|"CLLIAM"|"CLR"|"CLT"|"CN"|"CO"|"COAM"|"COCT"|"COCTAM"|"COHT"|"COHTAM"|"COLI"|"COR"|"CORAM"|"COROLI"|"CORS"|"CORSC"|"COT"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX10"|"CX20"|"CX3"|"CX30"|"CX50"|"CX6"|"CX8"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DP"|"DPR"|"DPT"|"DREF"|"DREG"|"EDL"|"ET"|"EVT"|"F"|"FE"|"FN"|"HEVT"|"HRT"|"HRTAM"|"IDC"|"IE"|"ISH"|"JLTV"|"JLTV2"|"JLTVM"|"JST"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MC"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MN"|"MO"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"NT"|"P"|"PAM"|"PBOME"|"PCOMP"|"PCOMPCO"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLPGTT"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX10"|"PX20"|"PX3"|"PX30"|"PX50"|"PX6"|"PX8"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAROLI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"SL"|"SLAM"|"SX10"|"SX20"|"SX3"|"SX30"|"SX50"|"SX6"|"SX8"|"SXAM"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, map<string|string[]> headers = {}, *ListEntityFieldsQueries queries) returns ListEntityFieldsResponse|error {
        ListEntityFieldsResponse|error r = self.oasClient->listEntityFields(typeCode, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listEntityFields(typeCode, headers, queries = queries);
        }
        return r;
    }

    # List Event Tasks
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listEventTasks(NotificationListBody payload, map<string|string[]> headers = {}) returns ListEventTasksEnvelope|error {
        ListEventTasksEnvelope|error r = self.oasClient->listEventTasks(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listEventTasks(payload, headers);
        }
        return r;
    }

    # List Files
    #
    # + typedId - `typedId` of the document you want to list attachments for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listFiles(string typedId, BdmanagerListtypedIdBody payload, map<string|string[]> headers = {}) returns ListFilesEnvelope|error {
        ListFilesEnvelope|error r = self.oasClient->listFiles(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listFiles(typedId, payload, headers);
        }
        return r;
    }

    # List Functions
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listFunctions(map<string|string[]> headers = {}) returns ListFunctionsResponse|error {
        ListFunctionsResponse|error r = self.oasClient->listFunctions(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listFunctions(headers);
        }
        return r;
    }

    # List Groups of the Business Role
    #
    # + businessroleId - The ID of the business role you want to retrieve user roles for. The `businessroleId` is the `typedId` without the `BR` suffix. For example, `businessroleId` of the **53.BR** is **53**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listGroupsOfBusinessRole(string businessroleId, map<string|string[]> headers = {}) returns ListGroupsOfBusinessRoleResponse|error {
        ListGroupsOfBusinessRoleResponse|error r = self.oasClient->listGroupsOfBusinessRole(businessroleId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listGroupsOfBusinessRole(businessroleId, headers);
        }
        return r;
    }

    # List ImportManager Changes
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listImportManagerChanges(string uniqueName, record {} payload, map<string|string[]> headers = {}) returns ListImportManagerChangesEnvelope|error {
        ListImportManagerChangesEnvelope|error r = self.oasClient->listImportManagerChanges(uniqueName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listImportManagerChanges(uniqueName, payload, headers);
        }
        return r;
    }

    # List Internationalization Messages
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - contains the messages for the locale 
    remote isolated function listInternationalizationMessages(I18nmanagerFetchWithExtraDataBody payload, map<string|string[]> headers = {}) returns ListInternationalizationMessagesEnvelope|error {
        ListInternationalizationMessagesEnvelope|error r = self.oasClient->listInternationalizationMessages(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listInternationalizationMessages(payload, headers);
        }
        return r;
    }

    # List Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns ListClaimItemsResponse|error {
        ListClaimItemsResponse|error r = self.oasClient->listItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listItems(typedId, payload, headers);
        }
        return r;
    }

    # List Jobs
    #
    # + headers - Headers to be sent with the request 
    # + payload - A general fetch request. A filter can be applied 
    # + return - OK 
    remote isolated function listJobs(record {int endRow?; record {}? oldValues?; string operationType?; int startRow?; string textMatchStyle?; record {string _constructor?; string operator?; record {string fieldName?; string operator?; string value?;}[] criteria?;} data?;} payload, map<string|string[]> headers = {}) returns ListJSTResponse|error {
        ListJSTResponse|error r = self.oasClient->listJobs(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listJobs(payload, headers);
        }
        return r;
    }

    # List KV Tables
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listKvTables(map<string|string[]> headers = {}) returns ListKVTablesResponse|error {
        ListKVTablesResponse|error r = self.oasClient->listKvTables(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listKvTables(headers);
        }
        return r;
    }

    # List Libraries
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLibraries(map<string|string[]> headers = {}) returns ListLibrariesResponse|error {
        ListLibrariesResponse|error r = self.oasClient->listLibraries(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLibraries(headers);
        }
        return r;
    }

    # List Live Price Grid Items
    #
    # + id - The `id` of the Live Price Grid you want to retrieve items for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLivePriceGridItems(string id, ListLivePriceGridItemsRequest payload, map<string|string[]> headers = {}) returns ListLivePriceGridItemsResponse|error {
        ListLivePriceGridItemsResponse|error r = self.oasClient->listLivePriceGridItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLivePriceGridItems(id, payload, headers);
        }
        return r;
    }

    # List Live Price Grid Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLivePriceGridTypes(map<string|string[]> headers = {}) returns ListLivePriceGridTypesEnvelope|error {
        ListLivePriceGridTypesEnvelope|error r = self.oasClient->listLivePriceGridTypes(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLivePriceGridTypes(headers);
        }
        return r;
    }

    # List Live Price Grids
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLivePriceGrids(ListLivePriceGridsRequest payload, map<string|string[]> headers = {}) returns ListLivePriceGridsResponse|error {
        ListLivePriceGridsResponse|error r = self.oasClient->listLivePriceGrids(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLivePriceGrids(payload, headers);
        }
        return r;
    }

    # List Logic Parameters (Input Fields)
    #
    # + uniqueName - The name (`uniqueName`) of the logic you want to list parameters for. If omitted, the logic as specified in the product’s master is used, otherwise the passed logic is used
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLogicParametersInput(string uniqueName, map<string|string[]> headers = {}) returns ListLogicInputFieldsResponse|error {
        ListLogicInputFieldsResponse|error r = self.oasClient->listLogicParametersInput(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLogicParametersInput(uniqueName, headers);
        }
        return r;
    }

    # List Logics
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLogics(map<string|string[]> headers = {}) returns ListLogicsResponse|error {
        ListLogicsResponse|error r = self.oasClient->listLogics(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLogics(headers);
        }
        return r;
    }

    # List Logins
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listLogins(BdmanagerListtypedIdBody payload, map<string|string[]> headers = {}) returns ListLoginsEnvelope|error {
        ListLoginsEnvelope|error r = self.oasClient->listLogins(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listLogins(payload, headers);
        }
        return r;
    }

    # List Products From a Manual Price List
    #
    # + id - The ID of the Manual Price List you want to retrieve products from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listManualPriceListProducts(string id, ListProductsFromManualPriceListRequest payload, map<string|string[]> headers = {}) returns ListProductsFromManualPriceListResponse|error {
        ListProductsFromManualPriceListResponse|error r = self.oasClient->listManualPriceListProducts(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listManualPriceListProducts(id, payload, headers);
        }
        return r;
    }

    # List Manual Price Lists
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listManualPriceLists(ListManualPriceListsRequest payload, map<string|string[]> headers = {}) returns manualpricelistResponse|error {
        manualpricelistResponse|error r = self.oasClient->listManualPriceLists(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listManualPriceLists(payload, headers);
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
    remote isolated function listModelLogicParameters(string typedId, string stepName, string formulaName, map<string|string[]> headers = {}) returns ListModelLogicParametersResponse|error {
        ListModelLogicParametersResponse|error r = self.oasClient->listModelLogicParameters(typedId, stepName, formulaName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listModelLogicParameters(typedId, stepName, formulaName, headers);
        }
        return r;
    }

    # List Notifications
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listNotifications(NotificationListBody payload, map<string|string[]> headers = {}) returns ListNotificationsEnvelope|error {
        ListNotificationsEnvelope|error r = self.oasClient->listNotifications(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listNotifications(payload, headers);
        }
        return r;
    }

    # List Parallel Calculation Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listParallelCalculationItems(ListParallelCalculationItemsRequest payload, map<string|string[]> headers = {}) returns ListParallelCalculationItemsResponse|error {
        ListParallelCalculationItemsResponse|error r = self.oasClient->listParallelCalculationItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listParallelCalculationItems(payload, headers);
        }
        return r;
    }

    # List Pending Approvals
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listPendingApprovals(map<string|string[]> headers = {}) returns ListPendingApprovalsResponse|error {
        ListPendingApprovalsResponse|error r = self.oasClient->listPendingApprovals(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listPendingApprovals(headers);
        }
        return r;
    }

    # List Price List Items
    #
    # + id - The ID of the Price List you want to retrieve items for. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listPriceListItems(string id, ListPriceListItemsRequest payload, map<string|string[]> headers = {}) returns pricelistitemResponse|error {
        pricelistitemResponse|error r = self.oasClient->listPriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listPriceListItems(id, payload, headers);
        }
        return r;
    }

    # List Price List Types
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listPriceListTypes(map<string|string[]> headers = {}) returns ListPriceListTypesEnvelope|error {
        ListPriceListTypesEnvelope|error r = self.oasClient->listPriceListTypes(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listPriceListTypes(headers);
        }
        return r;
    }

    # List Price Lists
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listPriceLists(ListPriceListsRequest payload, map<string|string[]> headers = {}) returns ListPriceListsResponse|error {
        ListPriceListsResponse|error r = self.oasClient->listPriceLists(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listPriceLists(payload, headers);
        }
        return r;
    }

    # List Product Extension Objects
    #
    # + productMasterExtensionName - Enter the name of Product Extension you want to retrieve objects from. You can find the name in **Administration** > **Configuration** > **Master Data** > **Product Master Extension** or using the **/configurationmanager.get/productextension** endpoint
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A Product Extension response 
    remote isolated function listProductExtensionObjects(string productMasterExtensionName, ListProductExtensionObjectsRequest payload, map<string|string[]> headers = {}, *ListProductExtensionObjectsQueries queries) returns ProductExtensionResponse|error {
        ProductExtensionResponse|error r = self.oasClient->listProductExtensionObjects(productMasterExtensionName, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listProductExtensionObjects(productMasterExtensionName, payload, headers, queries = queries);
        }
        return r;
    }

    # List Product Sets
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listProductSets(ListProductSetsRequest payload, map<string|string[]> headers = {}) returns ListProductSetsResponse|error {
        ListProductSetsResponse|error r = self.oasClient->listProductSets(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listProductSets(payload, headers);
        }
        return r;
    }

    # List Products
    #
    # + headers - Headers to be sent with the request 
    # + return - Returns full record details 
    remote isolated function listProducts(ListProductsRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->listProducts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listProducts(payload, headers);
        }
        return r;
    }

    # List Products
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listQuoteProducts(ListProductsRequest1 payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->listQuoteProducts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listQuoteProducts(payload, headers);
        }
        return r;
    }

    # List Quotes
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listQuotes(ListQuotesRequest payload, map<string|string[]> headers = {}) returns ListQuotesResponse|error {
        ListQuotesResponse|error r = self.oasClient->listQuotes(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listQuotes(payload, headers);
        }
        return r;
    }

    # List Rebate Agreement Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRebateAgreementItems(ListRebateAgreementItemsRequest payload, map<string|string[]> headers = {}) returns ListRebateAgreementItemsResponse|error {
        ListRebateAgreementItemsResponse|error r = self.oasClient->listRebateAgreementItems(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRebateAgreementItems(payload, headers);
        }
        return r;
    }

    # List Rebate Agreements
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRebateAgreements(ListRebateAgreementsRequest payload, map<string|string[]> headers = {}) returns ListRebateAgreementsResponse|error {
        ListRebateAgreementsResponse|error r = self.oasClient->listRebateAgreements(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRebateAgreements(payload, headers);
        }
        return r;
    }

    # List Rebate Calculations
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRebateCalculations(FetchRRSCBody payload, map<string|string[]> headers = {}) returns ListRebateCalculationsResponse|error {
        ListRebateCalculationsResponse|error r = self.oasClient->listRebateCalculations(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRebateCalculations(payload, headers);
        }
        return r;
    }

    # List Recommendations
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRecommendations(ListRecommendationsRequest payload, map<string|string[]> headers = {}) returns ListRecommendationsEnvelope|error {
        ListRecommendationsEnvelope|error r = self.oasClient->listRecommendations(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRecommendations(payload, headers);
        }
        return r;
    }

    # List Roles of the Business Role
    #
    # + businessroleId - The ID of the business role you want to retrieve user roles for. The `businessroleId` is the `typedId` without the `BR` suffix. For example, `businessroleId` of the **53.BR** is **53**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRolesOfBusinessRole(string businessroleId, map<string|string[]> headers = {}) returns ListRolesOfBusinessRoleResponse|error {
        ListRolesOfBusinessRoleResponse|error r = self.oasClient->listRolesOfBusinessRole(businessroleId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRolesOfBusinessRole(businessroleId, headers);
        }
        return r;
    }

    # List Rollups
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listRollups(ListRollupsRequest payload, map<string|string[]> headers = {}) returns ListRollupsResponse|error {
        ListRollupsResponse|error r = self.oasClient->listRollups(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listRollups(payload, headers);
        }
        return r;
    }

    # List Security & Configuration Events
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listSecurityConfigurationEvents(NotificationListBody payload, map<string|string[]> headers = {}) returns ListSecurityConfigEventsEnvelope|error {
        ListSecurityConfigEventsEnvelope|error r = self.oasClient->listSecurityConfigurationEvents(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listSecurityConfigurationEvents(payload, headers);
        }
        return r;
    }

    # List Seller Extensions
    #
    # + sXCategory - The Seller Extension category (the `Name` from the *Seller Master Extension* table)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listSellerExtensions(string sXCategory, map<string|string[]> headers = {}) returns SellerExtensionEnvelope|error {
        SellerExtensionEnvelope|error r = self.oasClient->listSellerExtensions(sXCategory, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listSellerExtensions(sXCategory, headers);
        }
        return r;
    }

    # List Sellers
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listSellers(ListSellersRequest payload, map<string|string[]> headers = {}) returns ListSellersEnvelope|error {
        ListSellersEnvelope|error r = self.oasClient->listSellers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listSellers(payload, headers);
        }
        return r;
    }

    # List Tasks
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function listTasks(map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->listTasks(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listTasks(headers);
        }
        return r;
    }

    # List Type Codes
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function listTypeCodes(map<string|string[]> headers = {}) returns typecodesResponse|error? {
        typecodesResponse|error? r = self.oasClient->listTypeCodes(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listTypeCodes(headers);
        }
        return r;
    }

    # List Unique CLIC Items
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUniqueClicItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns ListUniqueCLICItemsResponse|error {
        ListUniqueCLICItemsResponse|error r = self.oasClient->listUniqueClicItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUniqueClicItems(typedId, payload, headers);
        }
        return r;
    }

    # List User's Business Roles
    #
    # + userId - The ID of the user you want to retrieve business roles for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSBusinessRoles(string userId, map<string|string[]> headers = {}) returns ListUserBusinessRolesResponse|error {
        ListUserBusinessRolesResponse|error r = self.oasClient->listUserSBusinessRoles(userId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUserSBusinessRoles(userId, headers);
        }
        return r;
    }

    # List User's Pending Approvals
    #
    # + loginName - The login name of the user you want to retrieve Pending Workflows for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSPendingApprovals(string loginName, map<string|string[]> headers = {}) returns ListUserPendingApprovalsResponse|error {
        ListUserPendingApprovalsResponse|error r = self.oasClient->listUserSPendingApprovals(loginName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUserSPendingApprovals(loginName, headers);
        }
        return r;
    }

    # List User's Roles
    #
    # + userId - The ID of the user you want to retrieve roles for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSRoles(string userId, map<string|string[]> headers = {}) returns ListUserRolesResponse|error {
        ListUserRolesResponse|error r = self.oasClient->listUserSRoles(userId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUserSRoles(userId, headers);
        }
        return r;
    }

    # List User's User Groups
    #
    # + userId - The ID of the user you want to retrieve groups for. The `userId` is the `typedId` without the `U` suffix. For example, `userId` of the **2147490806.U** is **2147490806**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUserSUserGroups(string userId, map<string|string[]> headers = {}) returns ListUsersUserGroupsResponse|error {
        ListUsersUserGroupsResponse|error r = self.oasClient->listUserSUserGroups(userId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUserSUserGroups(userId, headers);
        }
        return r;
    }

    # List Users
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listUsers(ListUsersRequest payload, map<string|string[]> headers = {}) returns ListUsersResponse|error {
        ListUsersResponse|error r = self.oasClient->listUsers(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listUsers(payload, headers);
        }
        return r;
    }

    # List Workflows
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function listWorkflows(ListWorkflowsRequest payload, map<string|string[]> headers = {}) returns ListWorkflowsResponse|error {
        ListWorkflowsResponse|error r = self.oasClient->listWorkflows(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->listWorkflows(payload, headers);
        }
        return r;
    }

    # Load Data Into FieldCollection
    #
    # + typedId - Specifies the typedId (format: `{id}.{type}`) of the FieldCollection to load data into. Type must be either `DMDS` or `DMT`
    # + headers - Headers to be sent with the request 
    # + return - OK - data loaded successfully into the DMFieldCollection 
    remote isolated function loadDataIntoFieldCollection(string typedId, DatamartLoadfctypedIdBody payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->loadDataIntoFieldCollection(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->loadDataIntoFieldCollection(typedId, payload, headers);
        }
        return r;
    }

    # User Login (V1)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function login(map<string|string[]> headers = {}) returns UserLoginResponse|error {
        UserLoginResponse|error r = self.oasClient->login(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->login(headers);
        }
        return r;
    }

    # Mark as Read
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function markAsRead(record {} payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->markAsRead(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->markAsRead(payload, headers);
        }
        return r;
    }

    # Mark an Offer as Lost
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function markQuoteLost(string identifier, MarkOfferAsLostRequest payload, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->markQuoteLost(identifier, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->markQuoteLost(identifier, payload, headers);
        }
        return r;
    }

    # Mass Delete Imports
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massDeleteImports(string typedId, ImportmanagerMassdeletetypedIdBody payload, map<string|string[]> headers = {}) returns MassDeleteImportsEnvelope|error {
        MassDeleteImportsEnvelope|error r = self.oasClient->massDeleteImports(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massDeleteImports(typedId, payload, headers);
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
    remote isolated function massDeleteLookupTableValues(string tableId, TableIdBatchBody payload, map<string|string[]> headers = {}, *MassDeleteLookupTableValuesQueries queries) returns DeleteLookupTableValueResponse1|error {
        DeleteLookupTableValueResponse1|error r = self.oasClient->massDeleteLookupTableValues(tableId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massDeleteLookupTableValues(tableId, payload, headers, queries = queries);
        }
        return r;
    }

    # Mass Edit Data Change Request Items
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massEditDataChangeRequestItems(string id, DcrmanagerAddmassopidBody payload, map<string|string[]> headers = {}) returns DataChangeRequestMassChangeEnvelope|error {
        DataChangeRequestMassChangeEnvelope|error r = self.oasClient->massEditDataChangeRequestItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditDataChangeRequestItems(id, payload, headers);
        }
        return r;
    }

    # Mass Edit
    #
    # + typedId - The `typedId` of the object you want to perform the mass edit action for
    # + headers - Headers to be sent with the request 
    # + return - OK - returns the number of edited records 
    remote isolated function massEditDataMartObject(string typedId, MassEditRequest1 payload, map<string|string[]> headers = {}) returns MassEditDatamartResponse|error {
        MassEditDatamartResponse|error r = self.oasClient->massEditDataMartObject(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditDataMartObject(typedId, payload, headers);
        }
        return r;
    }

    # Mass Edit Imports
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massEditImports(string typedId, ImportmanagerMassedittypedIdBody payload, map<string|string[]> headers = {}) returns MassEditImportsEnvelope|error {
        MassEditImportsEnvelope|error r = self.oasClient->massEditImports(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditImports(typedId, payload, headers);
        }
        return r;
    }

    # Mass Edit
    #
    # + tableId - The ID of the Lookup Table whose values you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK - The response contains the number of modifed objects 
    remote isolated function massEditLookupTable(string tableId, MassEditRequest payload, map<string|string[]> headers = {}) returns MassEditResponse|error {
        MassEditResponse|error r = self.oasClient->massEditLookupTable(tableId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditLookupTable(tableId, payload, headers);
        }
        return r;
    }

    # Mass Edit a Manual Price List Items
    #
    # + id - The ID of the Manual Price List whose products you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massEditManualPriceListItems(string id, MassEditMPLRequest payload, map<string|string[]> headers = {}) returns MassEditManualPriceListResponse|error {
        MassEditManualPriceListResponse|error r = self.oasClient->massEditManualPriceListItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditManualPriceListItems(id, payload, headers);
        }
        return r;
    }

    # Mass Edit Price Grid Items
    #
    # + id - The `id` of the Live Price Grid whose items you want to edit. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK - The response contains `"data":null` as the mass edit task is a background process whose results are not yet available within the response time 
    remote isolated function massEditPriceGridItems(string id, MassEditPriceGridItemsRequest payload, map<string|string[]> headers = {}) returns MassEditPriceGridItemsResponse|error {
        MassEditPriceGridItemsResponse|error r = self.oasClient->massEditPriceGridItems(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massEditPriceGridItems(id, payload, headers);
        }
        return r;
    }

    # Mass Submit Rebate Record Groups
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massSubmitRebateRecordGroupItems(string typedId, RebaterecordgroupMasssubmittypedIdBody payload, map<string|string[]> headers = {}) returns MassSubmitRRGResponse|error {
        MassSubmitRRGResponse|error r = self.oasClient->massSubmitRebateRecordGroupItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massSubmitRebateRecordGroupItems(typedId, payload, headers);
        }
        return r;
    }

    # Mass Submit Rebate Record Groups
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massSubmitRebateRecordGroups(RebaterecordgroupMasssubmittypedIdBody payload, map<string|string[]> headers = {}) returns MassSubmitRebateRecordGroupsEnvelope|error {
        MassSubmitRebateRecordGroupsEnvelope|error r = self.oasClient->massSubmitRebateRecordGroups(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massSubmitRebateRecordGroups(payload, headers);
        }
        return r;
    }

    # Mass Update
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function massUpdate(string typeCode, MassUpdateRequest payload, map<string|string[]> headers = {}) returns MassUpdateResponse|error {
        MassUpdateResponse|error r = self.oasClient->massUpdate(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->massUpdate(typeCode, payload, headers);
        }
        return r;
    }

    # OAuth Authorization Request
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Found 
    remote isolated function oauthAuthorize(map<string|string[]> headers = {}, *OauthAuthorizeQueries queries) returns error? {
        error? r = self.oasClient->oauthAuthorize(headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->oauthAuthorize(headers, queries = queries);
        }
        return r;
    }

    # Access Token Request
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function oauthToken(map<string|string[]> headers = {}, *OauthTokenQueries queries) returns OAuthTokenResponse|error {
        OAuthTokenResponse|error r = self.oasClient->oauthToken(headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->oauthToken(headers, queries = queries);
        }
        return r;
    }

    # Perform a Mass Action
    #
    # + id - The ID of the Price Grid that contains items you want to apply workflow actions to
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function performMassAction(string id, PerformMassActionRequest payload, map<string|string[]> headers = {}) returns PerformMassActionResponse|error {
        PerformMassActionResponse|error r = self.oasClient->performMassAction(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->performMassAction(id, payload, headers);
        }
        return r;
    }

    # Ping (without authentication)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK - Partition is exists 
    remote isolated function pingWithout(map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->pingWithout(headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->pingWithout(headers);
        }
        return r;
    }

    # Preview a Custom Form Workflow
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function previewCustomFormWorkflow(record {} payload, map<string|string[]> headers = {}) returns PreviewCustomFormWorkflowResponse|error {
        PreviewCustomFormWorkflowResponse|error r = self.oasClient->previewCustomFormWorkflow(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->previewCustomFormWorkflow(payload, headers);
        }
        return r;
    }

    # Preview a Rebate Record Group Workflow
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function previewRebateRecordGroupWorkflow(string typedId, RebaterecordgroupPreviewtypedIdBody payload, map<string|string[]> headers = {}) returns RebateRecordGroupWorkflowEnvelope|error {
        RebateRecordGroupWorkflowEnvelope|error r = self.oasClient->previewRebateRecordGroupWorkflow(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->previewRebateRecordGroupWorkflow(typedId, payload, headers);
        }
        return r;
    }

    # Query API Execute
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - Successful execution 
    remote isolated function queryApiExecute(QueryapiExecuteBody payload, map<string|string[]> headers = {}, *QueryApiExecuteQueries queries) returns QueryApiExecuteEnvelope|error {
        QueryApiExecuteEnvelope|error r = self.oasClient->queryApiExecute(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->queryApiExecute(payload, headers, queries = queries);
        }
        return r;
    }

    # Query a Data Manager Object
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function queryDataManagerObject(QueryDataManagerObjectRequest payload, map<string|string[]> headers = {}, *QueryDataManagerObjectQueries queries) returns QueryDataManagerObjectResponse|error {
        QueryDataManagerObjectResponse|error r = self.oasClient->queryDataManagerObject(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->queryDataManagerObject(payload, headers, queries = queries);
        }
        return r;
    }

    # Recalculate a Calculation of a Step
    #
    # + typedId - The `typedId` of the Model Object you want to recalculate the step for
    # + stepName - Enter the name of the step you want to calculate
    # + calcName - The name of the calculation you want to recalculate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function recalculateCalculationOfStep(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, string calcName, record {} payload, map<string|string[]> headers = {}) returns RecalculateCalculationOfStepResponse|error {
        RecalculateCalculationOfStepResponse|error r = self.oasClient->recalculateCalculationOfStep(typedId, stepName, calcName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->recalculateCalculationOfStep(typedId, stepName, calcName, payload, headers);
        }
        return r;
    }

    # Recalculate Items of a Parallel Calculation
    #
    # + typedId - The `typedId` of the Model Object you want to recalculate the step for
    # + stepName - Enter the name of the step you want to calculate
    # + calcName - The name of the calculation you want to recalculate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function recalculateItemsOfParallelCalculation(string typedId, "definition"|"configuration"|"results"|"projections"|"parallel" stepName, string calcName, CalcNameItemBody payload, map<string|string[]> headers = {}) returns ParallelCalculationEnvelope|error {
        ParallelCalculationEnvelope|error r = self.oasClient->recalculateItemsOfParallelCalculation(typedId, stepName, calcName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->recalculateItemsOfParallelCalculation(typedId, stepName, calcName, payload, headers);
        }
        return r;
    }

    # Recalculate a Quote
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function recalculateQuote(RecalculateQuoteRequest payload, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->recalculateQuote(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->recalculateQuote(payload, headers);
        }
        return r;
    }

    # Recalculate a Quote/Contract/Rebate Agreement/Compensation Plan
    #
    # + typedId - The `typedId` of the document you want to calculate
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK 
    remote isolated function recalculateQuoteContractRebate(string typedId, map<string|string[]> headers = {}, *RecalculateQuoteContractRebateQueries queries) returns RecalculateClicEnvelope|error {
        RecalculateClicEnvelope|error r = self.oasClient->recalculateQuoteContractRebate(typedId, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->recalculateQuoteContractRebate(typedId, headers, queries = queries);
        }
        return r;
    }

    # Refresh an Authentication Token (API V2 only)
    #
    # + headers - Headers to be sent with the request 
    # + payload - Provide the referesh token 
    # + return - Login was successful. The response contains the access token, token type and the refresh token 
    remote isolated function refreshAuthToken(RefreshAuthTokenHeaders headers, TokenRefreshBody payload) returns tokenResponse|error {
        tokenResponse|error r = self.oasClient->refreshAuthToken(headers, payload);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->refreshAuthToken(headers, payload);
        }
        return r;
    }

    # Deny a Calculation Grid Item
    #
    # + id - The `id` of the Calculation Grid you want to deny items for. You can retrieve the `id` of the CG, for example, by calling the `/fetch/CG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function rejectCalculationGridItem(string id, DenyCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns DenyCalculationGridItemResponse|error {
        DenyCalculationGridItemResponse|error r = self.oasClient->rejectCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->rejectCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Reject Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to reject
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function rejectItems(string typedId, RejectClaimItemsRequest payload, map<string|string[]> headers = {}) returns RejectClaimItemsResponse|error {
        RejectClaimItemsResponse|error r = self.oasClient->rejectItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->rejectItems(typedId, payload, headers);
        }
        return r;
    }

    # Delete All Line Items
    #
    # + typedId - `typedId` of the object you want to remove all line items from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function removeAllClicLineItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns ClicOperationEnvelope|error {
        ClicOperationEnvelope|error r = self.oasClient->removeAllClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->removeAllClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Remove Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to remove
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function removeItems(string typedId, record {} payload, map<string|string[]> headers = {}) returns RemoveClaimItemsResponse|error {
        RemoveClaimItemsResponse|error r = self.oasClient->removeItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->removeItems(typedId, payload, headers);
        }
        return r;
    }

    # Reply To a Comment
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function replyToComment(CommentmanagerReplyBody payload, map<string|string[]> headers = {}) returns CommentOperationEnvelope|error {
        CommentOperationEnvelope|error r = self.oasClient->replyToComment(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->replyToComment(payload, headers);
        }
        return r;
    }

    # Resolve a Comment
    #
    # + typedId - The typedId of the comment thread
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function resolveComment(string typedId, record {} payload, map<string|string[]> headers = {}) returns ResolveCommentEnvelope|error {
        ResolveCommentEnvelope|error r = self.oasClient->resolveComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->resolveComment(typedId, payload, headers);
        }
        return r;
    }

    # Restore Default Data Sources
    #
    # + dataSourceName - The name of the Data Source you want to create. 
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function restoreDefaultDataSources("Product"|"Customer"|"uom"|"ccy"|"cal" dataSourceName, map<string|string[]> headers = {}) returns RestoreDefaultDataSourcesResponse|error {
        RestoreDefaultDataSourcesResponse|error r = self.oasClient->restoreDefaultDataSources(dataSourceName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->restoreDefaultDataSources(dataSourceName, headers);
        }
        return r;
    }

    # Revoke a Compensation Record
    #
    # + typedId - `typedId` of the Compensation Record you want to revoke
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function revokeCompensationRecord(string typedId, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->revokeCompensationRecord(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->revokeCompensationRecord(typedId, headers);
        }
        return r;
    }

    # Revoke a Model
    #
    # + typedId - `typedId` of the model you want to revoke
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function revokeModel(string typedId, record {} payload, map<string|string[]> headers = {}) returns RevokeModelResponse|error {
        RevokeModelResponse|error r = self.oasClient->revokeModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->revokeModel(typedId, payload, headers);
        }
        return r;
    }

    # Revoke a Price List
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function revokePriceList(string id, PricelistmanagerSubmitidBody payload, map<string|string[]> headers = {}) returns pricelistitemResponse|error {
        pricelistitemResponse|error r = self.oasClient->revokePriceList(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->revokePriceList(id, payload, headers);
        }
        return r;
    }

    # Revoke a Deal
    #
    # + identifier - Can be either the `uniqueName` or the `typedId`
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function revokeQuote(string identifier, map<string|string[]> headers = {}) returns RevokeDealResponse|error {
        RevokeDealResponse|error r = self.oasClient->revokeQuote(identifier, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->revokeQuote(identifier, headers);
        }
        return r;
    }

    # Revoke a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to revoke
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function revokeRebateRecordGroup(string typedId, map<string|string[]> headers = {}) returns RevokeRebateRecordGroupEnvelope|error {
        RevokeRebateRecordGroupEnvelope|error r = self.oasClient->revokeRebateRecordGroup(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->revokeRebateRecordGroup(typedId, headers);
        }
        return r;
    }

    # Run a Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function runCalculation(RunCalculationRequest payload, map<string|string[]> headers = {}) returns RunCalculationResponse|error {
        RunCalculationResponse|error r = self.oasClient->runCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->runCalculation(payload, headers);
        }
        return r;
    }

    # Run a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function runDataLoad(RunDataLoadRequest payload, map<string|string[]> headers = {}) returns RunDataLoadResponse|error {
        RunDataLoadResponse|error r = self.oasClient->runDataLoad(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->runDataLoad(payload, headers);
        }
        return r;
    }

    # Run a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function runRebateCalculation(RebaterecordCalculatesetBody payload, map<string|string[]> headers = {}) returns RunRebateCalculationResponse|error {
        RunRebateCalculationResponse|error r = self.oasClient->runRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->runRebateCalculation(payload, headers);
        }
        return r;
    }

    # Authenticate with SAML
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - OK - Redirects to the target page if a valid session exists 
    remote isolated function samlSignOn(map<string|string[]> headers = {}, *SamlSignOnQueries queries) returns error? {
        error? r = self.oasClient->samlSignOn(headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->samlSignOn(headers, queries = queries);
        }
        return r;
    }

    # Save Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveCalculation(SaveCalculationRequest payload, map<string|string[]> headers = {}) returns SaveCalculationResponse|error {
        SaveCalculationResponse|error r = self.oasClient->saveCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveCalculation(payload, headers);
        }
        return r;
    }

    # Save a Temporary Data
    #
    # + typedId - `typedId` of the Temporary Quote you want to save
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveClicDraft(string typedId, record {} payload, map<string|string[]> headers = {}) returns ClicOperationEnvelope|error {
        ClicOperationEnvelope|error r = self.oasClient->saveClicDraft(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveClicDraft(typedId, payload, headers);
        }
        return r;
    }

    # Save a Compensation Record
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveCompensationRecord(SaveCompensationRecordRequest payload, map<string|string[]> headers = {}) returns SaveCompensationRecordResponse|error {
        SaveCompensationRecordResponse|error r = self.oasClient->saveCompensationRecord(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveCompensationRecord(payload, headers);
        }
        return r;
    }

    # Save a Data Load
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveDataLoad(DatamartUpdatedataloadBody payload, map<string|string[]> headers = {}) returns DataLoadEnvelope|error {
        DataLoadEnvelope|error r = self.oasClient->saveDataLoad(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveDataLoad(payload, headers);
        }
        return r;
    }

    # Save Import Change
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveImportChange(record {} payload, map<string|string[]> headers = {}) returns SaveImportChangeEnvelope|error {
        SaveImportChangeEnvelope|error r = self.oasClient->saveImportChange(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveImportChange(payload, headers);
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
    remote isolated function saveModel(string typedId, "definition"|"configuration"|"results"|"projections" stepName, SaveModelRequest payload, map<string|string[]> headers = {}) returns SaveModelResponse|error {
        SaveModelResponse|error r = self.oasClient->saveModel(typedId, stepName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveModel(typedId, stepName, payload, headers);
        }
        return r;
    }

    # Save a Rebate Calculation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function saveRebateCalculation(SaveRebateCalculationRequest payload, map<string|string[]> headers = {}) returns SaveRebateCalculationResponse|error {
        SaveRebateCalculationResponse|error r = self.oasClient->saveRebateCalculation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->saveRebateCalculation(payload, headers);
        }
        return r;
    }

    # Search a KV Table
    #
    # + tableName - A name of the table you want to search the pattern for
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function searchKvTable(string tableName, SearchKVTableRequest payload, map<string|string[]> headers = {}) returns SearchKvTableEnvelope[]|error {
        SearchKvTableEnvelope[]|error r = self.oasClient->searchKvTable(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->searchKvTable(tableName, payload, headers);
        }
        return r;
    }

    # Search a Product
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function searchProducts(SearchProductRequest payload, map<string|string[]> headers = {}) returns SearchProductResponse|error {
        SearchProductResponse|error r = self.oasClient->searchProducts(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->searchProducts(payload, headers);
        }
        return r;
    }

    # Search a Product (URL)
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function searchProductsByQuery(string query, map<string|string[]> headers = {}) returns SearchProductURLResponse|error {
        SearchProductURLResponse|error r = self.oasClient->searchProductsByQuery(query, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->searchProductsByQuery(query, headers);
        }
        return r;
    }

    # Send a Document to Sign
    #
    # + typedId - `typedId` of the Compensation whose data you want to send via the e-signature system
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function sendDocumentToSign(string typedId, CreateSignatureRequest payload, map<string|string[]> headers = {}) returns CreateSignatureResponse|error {
        CreateSignatureResponse|error r = self.oasClient->sendDocumentToSign(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->sendDocumentToSign(typedId, payload, headers);
        }
        return r;
    }

    # Send an Email
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function sendEmail(SendEmailRequest payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->sendEmail(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->sendEmail(payload, headers);
        }
        return r;
    }

    # Send a Validation Message
    #
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function sendValidationMessage(NotificationSendBody payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->sendValidationMessage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->sendValidationMessage(payload, headers);
        }
        return r;
    }

    # Mark an Offer as Lost (with reason)
    #
    # + typedId - `typedId` of the Quote you want set as lost
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function setClicLostReason(string typedId, MarkOfferLostWithReasonRequest payload, map<string|string[]> headers = {}) returns SetClicLostReasonEnvelope|error {
        SetClicLostReasonEnvelope|error r = self.oasClient->setClicLostReason(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->setClicLostReason(typedId, payload, headers);
        }
        return r;
    }

    # Set a Default Pricing Logic
    #
    # + uniqueName - The name (`uniqueName`) of the logic that will be set as default. Leave blank to clear the default pricing logic
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function setDefaultPricingLogic(string uniqueName, map<string|string[]> headers = {}) returns SetDefaultPricingLogicResponse|error {
        SetDefaultPricingLogicResponse|error r = self.oasClient->setDefaultPricingLogic(uniqueName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->setDefaultPricingLogic(uniqueName, headers);
        }
        return r;
    }

    # Set a Review as Done
    #
    # + typedId - typedId of the object to mark as reviewed
    # + headers - Headers to be sent with the request 
    # + return - Review successfully marked as done 
    remote isolated function setReviewAsDone(string typedId, record {} payload, map<string|string[]> headers = {}) returns http:Response|error {
        http:Response|error r = self.oasClient->setReviewAsDone(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->setReviewAsDone(typedId, payload, headers);
        }
        return r;
    }

    # Should Submit a RRG Asynchronously
    #
    # + typedId - `typedId` of the Rebate Record Group you want to return the async threshold boolean for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function shouldSubmitRrgAsynchronously(string typedId, record {} payload, map<string|string[]> headers = {}) returns CheckFileExistsEnvelope|error {
        CheckFileExistsEnvelope|error r = self.oasClient->shouldSubmitRrgAsynchronously(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->shouldSubmitRrgAsynchronously(typedId, payload, headers);
        }
        return r;
    }

    # SQL Query a Data Manager Object
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + payload - `sources` that SQL can use are query definitions. The sources become CTEs (Common Table Expression) in the final SQL. These are then used as a reference in the main query instead of referring to the actual tables directly. The request example compares the volume by month 2019 to 2020 
    # + return - OK 
    remote isolated function sqlQueryDataManagerObject(DatamartSqlqueryBody payload, map<string|string[]> headers = {}, *SqlQueryDataManagerObjectQueries queries) returns QueryDataManagerObjectResponse|error {
        QueryDataManagerObjectResponse|error r = self.oasClient->sqlQueryDataManagerObject(payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->sqlQueryDataManagerObject(payload, headers, queries = queries);
        }
        return r;
    }

    # Submit Changes
    #
    # + typedId - typedId of the import
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitChanges(string typedId, ImportmanagerSubmittypedIdBody payload, map<string|string[]> headers = {}) returns ImportManagerUploadEnvelope|error {
        ImportManagerUploadEnvelope|error r = self.oasClient->submitChanges(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitChanges(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Claim
    #
    # + typedId - `typedId` of the Claim you want to submit
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitClaim(string typedId, record {} payload, map<string|string[]> headers = {}) returns SubmitClaimResponse|error {
        SubmitClaimResponse|error r = self.oasClient->submitClaim(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitClaim(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Quote/Contract/Rebate Agreement
    #
    # + typedId - The `typedId` of the Contract, Quote, or Rebate Agreement you want to submit
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitClic(string typedId, SubmitQuoteContractRebateAgreementRequest payload, map<string|string[]> headers = {}) returns SubmitQuoteContractRebateAgreementResponse|error {
        SubmitQuoteContractRebateAgreementResponse|error r = self.oasClient->submitClic(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitClic(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Contract
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function submitContract(SubmitContractRequest payload, map<string|string[]> headers = {}) returns contractModelResponse|error {
        contractModelResponse|error r = self.oasClient->submitContract(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitContract(payload, headers);
        }
        return r;
    }

    # Submit a Data Change Request
    #
    # + id - `id` of the DCR to be submitted
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitDataChangeRequest(string id, record {} payload, map<string|string[]> headers = {}) returns SubmitDCRResponse|error {
        SubmitDCRResponse|error r = self.oasClient->submitDataChangeRequest(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitDataChangeRequest(id, payload, headers);
        }
        return r;
    }

    # Submit a Data Change Request (async)
    #
    # + id - `id` of the DCR to be submitted
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitDataChangeRequestAsync(string id, record {} payload, map<string|string[]> headers = {}) returns SubmitDCRAsyncResponse|error {
        SubmitDCRAsyncResponse|error r = self.oasClient->submitDataChangeRequestAsync(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitDataChangeRequestAsync(id, payload, headers);
        }
        return r;
    }

    # Submit a Model
    #
    # + typedId - The `typedId` of the Model Object you want to submit
    # + headers - Headers to be sent with the request 
    # + return - OK. Returns the Model Object 
    remote isolated function submitModel(string typedId, record {} payload, map<string|string[]> headers = {}) returns SaveModelResponse|error {
        SaveModelResponse|error r = self.oasClient->submitModel(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitModel(typedId, payload, headers);
        }
        return r;
    }

    # Submit a Price List
    #
    # + id - The ID of the Price List you want to submit. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function submitPriceList(string id, PricelistmanagerSubmitidBody payload, map<string|string[]> headers = {}) returns pricelistitemResponse|error {
        pricelistitemResponse|error r = self.oasClient->submitPriceList(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitPriceList(id, payload, headers);
        }
        return r;
    }

    # Submit Products
    #
    # + id - The `id` of the Live Price Grid you want to submit items for. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK - In case that more than one item is passed in the request, the body will not contain any data (`"data":null`). For a single item, the new PriceGridItem object is returned 
    remote isolated function submitProducts(string id, SubmitProductsRequest payload, map<string|string[]> headers = {}) returns SubmitProductsResponse|error {
        SubmitProductsResponse|error r = self.oasClient->submitProducts(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitProducts(id, payload, headers);
        }
        return r;
    }

    # Submit a Quote
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function submitQuote(SubmitQuoteRequest payload, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->submitQuote(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitQuote(payload, headers);
        }
        return r;
    }

    # Submit a Rebate Record Group
    #
    # + typedId - `typedId` of the Rebate Record Group you want to submit
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function submitRebateRecordGroup(string typedId, record {} payload, map<string|string[]> headers = {}) returns SubmitRebateRecordGroup|error {
        SubmitRebateRecordGroup|error r = self.oasClient->submitRebateRecordGroup(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->submitRebateRecordGroup(typedId, payload, headers);
        }
        return r;
    }

    # Syntax Check
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function syntaxCheck(SyntaxCheckRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->syntaxCheck(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->syntaxCheck(payload, headers);
        }
        return r;
    }

    # Test a Logic
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function testLogic(TestLogicRequest payload, map<string|string[]> headers = {}) returns TestLogicEnvelope|error {
        TestLogicEnvelope|error r = self.oasClient->testLogic(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->testLogic(payload, headers);
        }
        return r;
    }

    # Truncate a Table
    #
    # + tableName - The table you want to remove the keys from
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function truncateTable(string tableName, map<string|string[]> headers = {}) returns TruncateKVTableResponse|error {
        TruncateKVTableResponse|error r = self.oasClient->truncateTable(tableName, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->truncateTable(tableName, headers);
        }
        return r;
    }

    # Undo Compensation Plan Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoCompensationPlanRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoCompensationPlanRevocation(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoCompensationPlanRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Compensation Record Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoCompensationRecordRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoCompensationRecordRevocation(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoCompensationRecordRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Agreement Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoRebateAgreementRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoRebateAgreementRevocation(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoRebateAgreementRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Record Group Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoRebateRecordGroupRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoRebateRecordGroupRevocation(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoRebateRecordGroupRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Rebate Record Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoRebateRecordRevocation(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoRebateRecordRevocation(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoRebateRecordRevocation(typedId, headers);
        }
        return r;
    }

    # Undo Agreement & Promotion Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoRevokeContract(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoRevokeContract(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoRevokeContract(typedId, headers);
        }
        return r;
    }

    # Undo Quote Revocation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function undoRevokeQuote(string typedId, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->undoRevokeQuote(typedId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->undoRevokeQuote(typedId, headers);
        }
        return r;
    }

    # Unresolve a Comment
    #
    # + typedId - The typedId of the comment thread
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function unresolveComment(string typedId, record {} payload, map<string|string[]> headers = {}) returns ResolveCommentEnvelope|error {
        ResolveCommentEnvelope|error r = self.oasClient->unresolveComment(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->unresolveComment(typedId, payload, headers);
        }
        return r;
    }

    # Update an Action Item
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateActionItem(UpdateActionItemRequest payload, map<string|string[]> headers = {}) returns UpdateActionItemResponse|error {
        UpdateActionItemResponse|error r = self.oasClient->updateActionItem(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateActionItem(payload, headers);
        }
        return r;
    }

    # Update an Action Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateActionType(UpdateAITBody payload, map<string|string[]> headers = {}) returns UpdateActionTypeResponse|error {
        UpdateActionTypeResponse|error r = self.oasClient->updateActionType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateActionType(payload, headers);
        }
        return r;
    }

    # Update a Calculation Grid
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateCalculationGrid(UpdateCalculationGridRequest payload, map<string|string[]> headers = {}) returns UpdateCalculationGridResponse|error {
        UpdateCalculationGridResponse|error r = self.oasClient->updateCalculationGrid(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCalculationGrid(payload, headers);
        }
        return r;
    }

    # Update a Calculation Grid Item
    #
    # + id - `id` of the Calculation Grid Item you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateCalculationGridItem(string id, UpdateCalculationGridItemRequest payload, map<string|string[]> headers = {}) returns UpdateCalculationGridItemResponse|error {
        UpdateCalculationGridItemResponse|error r = self.oasClient->updateCalculationGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCalculationGridItem(id, payload, headers);
        }
        return r;
    }

    # Update a Claim
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateClaim(UpdateClaimRequest payload, map<string|string[]> headers = {}) returns UpdateClaimResponse|error {
        UpdateClaimResponse|error r = self.oasClient->updateClaim(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateClaim(payload, headers);
        }
        return r;
    }

    # Update a Claim Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateClaimType(UpdateClaimTypeRequest payload, map<string|string[]> headers = {}) returns UpdateClaimTypeResponse|error {
        UpdateClaimTypeResponse|error r = self.oasClient->updateClaimType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateClaimType(payload, headers);
        }
        return r;
    }

    # Update CLIC Line Items
    #
    # + typedId - `typedId` of the CLIC object (e.g., a Quote) you want to update line items for
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateClicLineItems(string typedId, UpdateCLICLineItemsRequest payload, map<string|string[]> headers = {}) returns UpdateClicLineItemsEnvelope|error {
        UpdateClicLineItemsEnvelope|error r = self.oasClient->updateClicLineItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateClicLineItems(typedId, payload, headers);
        }
        return r;
    }

    # Update a Compensation Record
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateCompensationRecord(UpdateCompensationRecordRequest payload, map<string|string[]> headers = {}) returns UpdateCompensationRecordResponse|error {
        UpdateCompensationRecordResponse|error r = self.oasClient->updateCompensationRecord(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCompensationRecord(payload, headers);
        }
        return r;
    }

    # Update a Compensation Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateCompensationType(UpdateCompensationTypeRequest payload, map<string|string[]> headers = {}) returns UpdateCompensationTypeEnvelope|error {
        UpdateCompensationTypeEnvelope|error r = self.oasClient->updateCompensationType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCompensationType(payload, headers);
        }
        return r;
    }

    # Update a Condition Record Item Attribute Meta
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateConditionRecordItemMeta(UpdateCRCIMBody payload, map<string|string[]> headers = {}) returns UpdateConditionRecordItemMetaEnvelope|error {
        UpdateConditionRecordItemMetaEnvelope|error r = self.oasClient->updateConditionRecordItemMeta(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateConditionRecordItemMeta(payload, headers);
        }
        return r;
    }

    # Update a Condition Record Set
    #
    # + id - `id` of the ConditionRecordSet object you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateConditionRecordSet(string id, ConditionrecordsetUpdateidBody payload, map<string|string[]> headers = {}) returns ConditionRecordSetOperationEnvelope|error {
        ConditionRecordSetOperationEnvelope|error r = self.oasClient->updateConditionRecordSet(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateConditionRecordSet(id, payload, headers);
        }
        return r;
    }

    # Update a Condition Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateConditionType(UpdateConditionTypeRequest payload, map<string|string[]> headers = {}) returns UpdateConditionTypeEnvelope|error {
        UpdateConditionTypeEnvelope|error r = self.oasClient->updateConditionType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateConditionType(payload, headers);
        }
        return r;
    }

    # Update a Configuration Storage
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateConfigurationStorage(UpdateJCSBody payload, map<string|string[]> headers = {}) returns ConfigurationStorageOperationEnvelope|error {
        ConfigurationStorageOperationEnvelope|error r = self.oasClient->updateConfigurationStorage(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateConfigurationStorage(payload, headers);
        }
        return r;
    }

    # Update a Custom Form
    #
    # + headers - Headers to be sent with the request 
    # + return - The Custom Form was updated successfully. The response includes the updated data 
    remote isolated function updateCustomForm(UpdateCustomFormRequest payload, map<string|string[]> headers = {}) returns UpdateCustomFormEnvelope|error {
        UpdateCustomFormEnvelope|error r = self.oasClient->updateCustomForm(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCustomForm(payload, headers);
        }
        return r;
    }

    # Update a Custom Form Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateCustomFormType(UpdateCustomFormTypeRequest payload, map<string|string[]> headers = {}) returns UpdateCustomFormTypeResponse|error {
        UpdateCustomFormTypeResponse|error r = self.oasClient->updateCustomFormType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCustomFormType(payload, headers);
        }
        return r;
    }

    # Update a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Returns customer record details 
    remote isolated function updateCustomer(UpdateCustomerRequest payload, map<string|string[]> headers = {}) returns customerResponse|error {
        customerResponse|error r = self.oasClient->updateCustomer(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateCustomer(payload, headers);
        }
        return r;
    }

    # Update a Data Change Request Item
    #
    # + id - `id` of the Data Change Request whose item you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateDataChangeRequestItem(string id, UpdateDCRIRequest payload, map<string|string[]> headers = {}) returns UpdateDCRIResponse|error {
        UpdateDCRIResponse|error r = self.oasClient->updateDataChangeRequestItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDataChangeRequestItem(id, payload, headers);
        }
        return r;
    }

    # Update Data Change Request Mass Changes
    #
    # + id - `id` of the Data Change Request
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateDataChangeRequestMassChanges(string id, DcrmanagerUpdatemassopidBody payload, map<string|string[]> headers = {}) returns DataChangeRequestMassChangeEnvelope|error {
        DataChangeRequestMassChangeEnvelope|error r = self.oasClient->updateDataChangeRequestMassChanges(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDataChangeRequestMassChanges(id, payload, headers);
        }
        return r;
    }

    # Update a Data Manager Entity
    #
    # + typeCode - The type code of the **Field Collection** you want to update
    # + headers - Headers to be sent with the request 
    # + payload - Either `uniqueName` or `typedId` must be provided in the request 
    # + return - Example response 
    remote isolated function updateDataManagerEntity("DMF"|"DM"|"DMDS" typeCode, UpdateDataManagerEntityRequest payload, map<string|string[]> headers = {}) returns dmobjectResponse|error {
        dmobjectResponse|error r = self.oasClient->updateDataManagerEntity(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateDataManagerEntity(typeCode, payload, headers);
        }
        return r;
    }

    # Update a File
    #
    # + typedId - `typedId` of the document whose attachment's metadata you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateFile(string typedId, BdmanagerUpdatetypedIdBody payload, map<string|string[]> headers = {}) returns UpdateFileEnvelope|error {
        UpdateFileEnvelope|error r = self.oasClient->updateFile(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateFile(typedId, payload, headers);
        }
        return r;
    }

    # Update Job Status Tracker Entry
    #
    # + headers - Headers to be sent with the request 
    # + return - JST updated 
    remote isolated function updateJobStatusTrackerEntry(OptimizationUpdatejstBody payload, map<string|string[]> headers = {}) returns JobStatusTrackerUpdateEnvelope|error {
        JobStatusTrackerUpdateEnvelope|error r = self.oasClient->updateJobStatusTrackerEntry(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateJobStatusTrackerEntry(payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Item
    #
    # + id - The ID of the Price Grid whose item you want to update. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - We have performed an update action on the `comments` field in our request sample >>> 
    # + return - Example response 
    remote isolated function updateLivePriceGridItem(string id, UpdateLivePriceGridItemRequest payload, map<string|string[]> headers = {}) returns pricegriditemResponse|error {
        pricegriditemResponse|error r = self.oasClient->updateLivePriceGridItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLivePriceGridItem(id, payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Item (No Recalculation)
    #
    # + id - The ID of the Price Grid whose item you want to update. `id`  is the `typedId` without **PG** suffix. For example, the `id` attribute of the item with `typedId` = **649.PG** is **649**. You can retrieve the `id` of the LPG, for example, by calling the `/fetch/PG` endpoint
    # + headers - Headers to be sent with the request 
    # + payload - We have performed an update action on the `comments` field in our request sample >>> 
    # + return - Example response 
    remote isolated function updateLivePriceGridItemNo(string id, UpdateLivePriceGridItemNoRecalcRequest payload, map<string|string[]> headers = {}) returns pricegriditemResponse|error {
        pricegriditemResponse|error r = self.oasClient->updateLivePriceGridItemNo(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLivePriceGridItemNo(id, payload, headers);
        }
        return r;
    }

    # Update a Live Price Grid Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateLivePriceGridType(UpdatePGTTBody payload, map<string|string[]> headers = {}) returns LivePriceGridTypeOperationEnvelope|error {
        LivePriceGridTypeOperationEnvelope|error r = self.oasClient->updateLivePriceGridType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLivePriceGridType(payload, headers);
        }
        return r;
    }

    # Update a Logic
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function updateLogic(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns logicResponse|error {
        logicResponse|error r = self.oasClient->updateLogic(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLogic(id, payload, headers);
        }
        return r;
    }

    # Update a Logic (No syntax check)
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function updateLogicNo(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns logicResponse|error {
        logicResponse|error r = self.oasClient->updateLogicNo(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLogicNo(id, payload, headers);
        }
        return r;
    }

    # Update a Logic (Partial)
    #
    # + id - The ID of the logic. The `id` is the `typedId` without the **F** suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.F**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function updateLogicPartial(string id, record {record {decimal version?; string typedId?; string uniqueName?; string label?; string validAfter?; string status?; anydata simulationSet?; anydata userGroupEdit?; anydata userGroupViewDetails?; anydata formulaNature?; string lastUpdateByName?; record {decimal version?; string typedId?; string elementName?; string elementLabel?; anydata elementDescription?; string[] elementGroups?; anydata conditionElementName?; boolean hideWarnings?; boolean excludeFromExport?; boolean protectedExpression?; decimal elementTimeout?; decimal displayOptions?; string? formatType?; anydata elementSuffix?; boolean allowOverride?; boolean summarize?; boolean hideOnNull?; anydata userGroup?; anydata cssProperties?; anydata resultGroup?; string combinationType?; boolean storeInAttributeExtension?; anydata criticalAlert?; anydata redAlert?; anydata yellowAlert?; anydata labelTranslations?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?; string formulaExpression?;}[] elements?; record {}[] inputDescriptors?; string formulaType?; anydata createdByName?; string createDate?; decimal createdBy?; string lastUpdateDate?; decimal lastUpdateBy?;} data?;} payload, map<string|string[]> headers = {}) returns logicResponse|error {
        logicResponse|error r = self.oasClient->updateLogicPartial(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLogicPartial(id, payload, headers);
        }
        return r;
    }

    # Update a Lookup Table
    #
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK 
    remote isolated function updateLookupTable(UpdateLookupTableRequest payload, map<string|string[]> headers = {}) returns UpdateLookupTableResponse|error {
        UpdateLookupTableResponse|error r = self.oasClient->updateLookupTable(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLookupTable(payload, headers);
        }
        return r;
    }

    # Update a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateLookupTableValue(string tableId, UpdateLookupTableValueRequest payload, map<string|string[]> headers = {}) returns UpdateLookupTableValueResponse|error {
        UpdateLookupTableValueResponse|error r = self.oasClient->updateLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Update a Manual Price List Item
    #
    # + id - The ID of the Manual Price List whose item you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateManualPriceListItem(string id, UpdateManualPriceListRequest payload, map<string|string[]> headers = {}) returns UpdateManualPriceListResponse|error {
        UpdateManualPriceListResponse|error r = self.oasClient->updateManualPriceListItem(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateManualPriceListItem(id, payload, headers);
        }
        return r;
    }

    # Update an Object
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - <!-- theme: warning --> 
    # + return - OK - contains the updated object 
    remote isolated function updateObject(string typeCode, UpdateObjectRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->updateObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateObject(typeCode, payload, headers);
        }
        return r;
    }

    # Update an Object (and return old data)
    #
    # + typeCode - The object's type code. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes)
    # + headers - Headers to be sent with the request 
    # + payload - <!-- theme: warning --> 
    # + return - OK - contains the updated object and details of the previous version 
    remote isolated function updateObjectReturningOldData(string typeCode, UpdateObjectReturnOldDataRequest payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->updateObjectReturningOldData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateObjectReturningOldData(typeCode, payload, headers);
        }
        return r;
    }

    # Update a Pricelist Detail
    #
    # + id - The ID of the Price List whose Item you want to update. The `id` is the `typedId` without the suffix. For example, the `id` attribute of the item with `typedId` = **2147484837.PL**  is **2147484837**
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updatePriceListDetail(string id, UpdatePricelistDetailRequest payload, map<string|string[]> headers = {}) returns UpdatePricelistDetailResponse|error {
        UpdatePricelistDetailResponse|error r = self.oasClient->updatePriceListDetail(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updatePriceListDetail(id, payload, headers);
        }
        return r;
    }

    # Update a Price List Type
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updatePriceListType(UpdatePLTTBody payload, map<string|string[]> headers = {}) returns PriceListTypeOperationEnvelope|error {
        PriceListTypeOperationEnvelope|error r = self.oasClient->updatePriceListType(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updatePriceListType(payload, headers);
        }
        return r;
    }

    # Update a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Updates specified fields of the record. Only one record can be updated per request (unless batched).<p> 
    # + return - Returns full record details 
    remote isolated function updateProduct(UpdateProductRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->updateProduct(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateProduct(payload, headers);
        }
        return r;
    }

    # Update a Quote/Contract/Rebate Agreement/Compensation Plan
    #
    # + typedId - The `typedId` of the Compensation Plan you want to update
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateQuoteContractRebateAgreement(string typedId, ClicmanagerUpdatetypedIdBody payload, map<string|string[]> headers = {}) returns UpdateClicEnvelope|error {
        UpdateClicEnvelope|error r = self.oasClient->updateQuoteContractRebateAgreement(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateQuoteContractRebateAgreement(typedId, payload, headers);
        }
        return r;
    }

    # Update a Review Status
    #
    # + typedId - typedId of the object to update
    # + headers - Headers to be sent with the request 
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function updateReviewStatus(string typedId, record {} payload, map<string|string[]> headers = {}) returns generalResponse|error {
        generalResponse|error r = self.oasClient->updateReviewStatus(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateReviewStatus(typedId, payload, headers);
        }
        return r;
    }

    # Update a Seller
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateSeller(UpdateSellerRequest payload, map<string|string[]> headers = {}) returns UpdateSellerEnvelope|error {
        UpdateSellerEnvelope|error r = self.oasClient->updateSeller(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateSeller(payload, headers);
        }
        return r;
    }

    # Update a Seller Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateSellerExtension(UpdateSXBody payload, map<string|string[]> headers = {}) returns UpdateSellerExtensionEnvelope|error {
        UpdateSellerExtensionEnvelope|error r = self.oasClient->updateSellerExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateSellerExtension(payload, headers);
        }
        return r;
    }

    # Update a User
    #
    # + headers - Headers to be sent with the request 
    # + payload - Specify the user by `typedId` and define the new value of the field you want to update in the `data` object 
    # + return - Example response 
    remote isolated function updateUser(UpdateUserRequest payload, map<string|string[]> headers = {}) returns userResponse|error {
        userResponse|error r = self.oasClient->updateUser(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateUser(payload, headers);
        }
        return r;
    }

    # Update a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function updateWorkflowDelegation(UpdateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns UpdateWorkflowDelegationResponse|error {
        UpdateWorkflowDelegationResponse|error r = self.oasClient->updateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->updateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Upload a Bulk Data to Data Source
    #
    # + datasourceUniqueName - The unique name of the Data Source where you want to upload the data to. You can also use `typedId` or the source name
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function uploadBulkDataToDataSource(string datasourceUniqueName, UploadBulkDataToDataSourceRequest payload, map<string|string[]> headers = {}) returns BulkDataUploadEnvelope|error {
        BulkDataUploadEnvelope|error r = self.oasClient->uploadBulkDataToDataSource(datasourceUniqueName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadBulkDataToDataSource(datasourceUniqueName, payload, headers);
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
    # + return - File uploaded successfully 
    remote isolated function uploadExcelToImportManager("P"|"PX" typeCode, string target, string slotId, TypeCodetargetBody payload, map<string|string[]> headers = {}, *UploadExcelToImportManagerQueries queries) returns ImportManagerUploadEnvelope|error {
        ImportManagerUploadEnvelope|error r = self.oasClient->uploadExcelToImportManager(typeCode, target, slotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadExcelToImportManager(typeCode, target, slotId, payload, headers, queries = queries);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + typedId - `typedId` of the document you want to attach the file to
    # + slotId - The ID of the slot you want to use for the upload. retrieve the slot ID using the `/uploadmanager.newuploadslot` (Create an Upload Slot) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function uploadFile(string typedId, string slotId, TypedIdslotIdBody payload, map<string|string[]> headers = {}) returns FileOperationEnvelope|error {
        FileOperationEnvelope|error r = self.oasClient->uploadFile(typedId, slotId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadFile(typedId, slotId, payload, headers);
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
    # + request -
    # + return - A general response that contains `data` property with a content depending on returned objects (e.g., Product master table fields when calling the `/fetch/P` endpoint). Can be `null` 
    remote isolated function uploadFileToPxCxSx("PX"|"CX"|"SX" typeCode, string target, string uploadSlotId, TargetuploadSlotIdBody payload, map<string|string[]> headers = {}, *UploadFileToPxCxSxQueries queries) returns generalResponse|error {
        generalResponse|error r = self.oasClient->uploadFileToPxCxSx(typeCode, target, uploadSlotId, payload, headers, queries = queries);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadFileToPxCxSx(typeCode, target, uploadSlotId, payload, headers, queries = queries);
        }
        return r;
    }

    # 2. Upload a File
    #
    # + slotId - Enter the ID of the slot you want to use for the upload
    # + sku - Enter the `sku` of the product you want to add the product image to
    # + headers - Headers to be sent with the request 
    # + request -
    # + return - OK 
    remote isolated function uploadProductImage(string slotId, string sku, TypedIdslotIdBody payload, map<string|string[]> headers = {}) returns error? {
        error? r = self.oasClient->uploadProductImage(slotId, sku, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->uploadProductImage(slotId, sku, payload, headers);
        }
        return r;
    }

    # Upsert a Compensation Plan
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function upsertCompensationPlan(UpsertCompensationPlanRequest payload, map<string|string[]> headers = {}) returns UpsertCompensationPlanResponse|error {
        UpsertCompensationPlanResponse|error r = self.oasClient->upsertCompensationPlan(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertCompensationPlan(payload, headers);
        }
        return r;
    }

    # Upsert a Contract
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function upsertContract(UpsertContractRequest payload, map<string|string[]> headers = {}) returns contractModelResponse|error {
        contractModelResponse|error r = self.oasClient->upsertContract(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertContract(payload, headers);
        }
        return r;
    }

    # Upsert a Customer
    #
    # + headers - Headers to be sent with the request 
    # + payload - If the customer does not exist yet, at least the `customerId` must be specified in the payload.<p> 
    # + return - Returns customer record details 
    remote isolated function upsertCustomer(UpsertCustomerRequest payload, map<string|string[]> headers = {}) returns customerResponse|error {
        customerResponse|error r = self.oasClient->upsertCustomer(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertCustomer(payload, headers);
        }
        return r;
    }

    # Upsert a Customer Extension
    #
    # + headers - Headers to be sent with the request 
    # + payload - **Please note**: The data sent in your request might be different from our sample request schema. Custom fields (`attribute1`..`attribute30`) can be retrieved using the **`/fetch/CXAM`** operation 
    # + return - OK 
    remote isolated function upsertCustomerExtension(UpsertCustomerExtensionRequest payload, map<string|string[]> headers = {}) returns UpsertCustomerExtensionResponse|error {
        UpsertCustomerExtensionResponse|error r = self.oasClient->upsertCustomerExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertCustomerExtension(payload, headers);
        }
        return r;
    }

    # Upsert a Key
    #
    # + tableName - A name of the table you want to upsert the key into
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - OK. Returns `"data" : null` when successfully inserted/updated 
    remote isolated function upsertKey(string tableName, UpsertKVKeyRequest payload, map<string|string[]> headers = {}) returns UpsertKVKeyResponse|error {
        UpsertKVKeyResponse|error r = self.oasClient->upsertKey(tableName, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertKey(tableName, payload, headers);
        }
        return r;
    }

    # Upsert a Lookup Table Value
    #
    # + tableId - Enter the ID of the table. The ID can be retrieved using the `/lookuptablemanager.fetch` method
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function upsertLookupTableValue(string tableId, UpsertLookupTableValueRequest payload, map<string|string[]> headers = {}) returns UpsertLookupTableValueResponse|error {
        UpsertLookupTableValueResponse|error r = self.oasClient->upsertLookupTableValue(tableId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertLookupTableValue(tableId, payload, headers);
        }
        return r;
    }

    # Upsert a Product in a Manual Price List
    #
    # + id - The ID of the Manual Price List whose product you want to create or update
    # + headers - Headers to be sent with the request 
    # + payload -
    # + return - Returns full record details 
    remote isolated function upsertManualPriceListProduct(string id, UpsertProductManualPriceListRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->upsertManualPriceListProduct(id, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertManualPriceListProduct(id, payload, headers);
        }
        return r;
    }

    # Upsert an Object
    #
    # + typeCode - Enter the Type code of the entity you want to insert a data to. See [the list of Type codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article
    # + headers - Headers to be sent with the request 
    # + payload - The **`/integrate/P`** endpoint (Upsert a Product) is used in our example.<p> 
    # + return - Returns full record details 
    remote isolated function upsertObject("ACTT"|"AP"|"APIK"|"BD"|"BPT"|"BR"|"C"|"CA"|"CAM"|"CDESC"|"CF"|"CFS"|"CFT"|"CH"|"CLLI"|"CN"|"CS"|"CT"|"CTAM"|"CTLI"|"CTMU"|"CTMUI"|"CTT"|"CTTAM"|"CTTREE"|"CW"|"CX"|"CXAM"|"DA"|"DB"|"DCR"|"DCRAM"|"DCRI"|"DCRL"|"DCRMC"|"DCRT"|"DE"|"DI"|"DM"|"DMDC"|"DMDL"|"DMDS"|"DMF"|"DMM"|"DMR"|"DMT"|"DREG"|"DWT"|"ET"|"EVT"|"F"|"FE"|"FN"|"IDC"|"IE"|"ISH"|"JST"|"JLTV"|"JLTVM"|"LAT"|"LT"|"LTT"|"LTV"|"M"|"MLTV"|"MLTV2"|"MLTV3"|"MLTV4"|"MLTV5"|"MLTV6"|"MLTVM"|"MPL"|"MPLAM"|"MPLI"|"MPLIT"|"MPLT"|"MR"|"MRAM"|"MT"|"P"|"PAM"|"PAPIJ"|"PBOME"|"PCOMP"|"PCW"|"PDESC"|"PG"|"PGI"|"PGIM"|"PGT"|"PH"|"PL"|"PLI"|"PLIM"|"PLT"|"PR"|"PRAM"|"PREF"|"PT"|"PWH"|"PX"|"PXAM"|"PXREF"|"PYR"|"PYRAM"|"Q"|"QAM"|"QLI"|"QMU"|"QMUI"|"QT"|"QTT"|"QTTAM"|"R"|"RAT"|"RATM"|"RBA"|"RBAAM"|"RBALI"|"RBAT"|"RBT"|"RBTAM"|"RR"|"RRAM"|"RRS"|"RRSC"|"RT"|"SAT"|"SC"|"SCN"|"SCNAM"|"SCT"|"SIAM"|"SIM"|"SIMI"|"TFA"|"TODO"|"U"|"UG"|"US"|"W"|"WD"|"WF"|"WFE"|"XPGI"|"XPLI"|"XSIMI" typeCode, UpsertObjectRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->upsertObject(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertObject(typeCode, payload, headers);
        }
        return r;
    }

    # Upsert an Object (and return old data)
    #
    # + typeCode - Specify the type code for the entity you want to work with. See [the list of Type Codes](https://pricefx.atlassian.net/wiki/spaces/KB/pages/99570616/Type+Codes) in the Pricefx Knowledge Base article.'
    # + headers - Headers to be sent with the request 
    # + payload - The **`/integrate/P/returnolddata`** endpoint (upserts a product) is used in our example.<p> 
    # + return - OK 
    remote isolated function upsertObjectReturningOldData(TypeCodeEnum typeCode, UpsertObjectReturnOldDataRequest payload, map<string|string[]> headers = {}) returns UpsertObjectReturnOldDataResponse|error {
        UpsertObjectReturnOldDataResponse|error r = self.oasClient->upsertObjectReturningOldData(typeCode, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertObjectReturningOldData(typeCode, payload, headers);
        }
        return r;
    }

    # Upsert a Product
    #
    # + headers - Headers to be sent with the request 
    # + payload - Either `sku` or `typedId` must be specified in order to *update* an existing product 
    # + return - Returns full record details 
    remote isolated function upsertProduct(UpsertProductRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->upsertProduct(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertProduct(payload, headers);
        }
        return r;
    }

    # Upsert a Product Extension
    #
    # + headers - Headers to be sent with the request 
    # + return - Returns full record details 
    remote isolated function upsertProductExtension(UpsertProductExtensionRequest payload, map<string|string[]> headers = {}) returns productResponse|error {
        productResponse|error r = self.oasClient->upsertProductExtension(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertProductExtension(payload, headers);
        }
        return r;
    }

    # Upsert a Quote
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function upsertQuote(UpsertQuoteRequest payload, map<string|string[]> headers = {}) returns quoteResponse|error {
        quoteResponse|error r = self.oasClient->upsertQuote(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertQuote(payload, headers);
        }
        return r;
    }

    # Upsert a Rebate Agreement
    #
    # + headers - Headers to be sent with the request 
    # + return - Example response 
    remote isolated function upsertRebateAgreement(UpsertRebateAgreementRequest payload, map<string|string[]> headers = {}) returns rebateagreementResponse|error {
        rebateagreementResponse|error r = self.oasClient->upsertRebateAgreement(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->upsertRebateAgreement(payload, headers);
        }
        return r;
    }

    # Validate Items
    #
    # + typedId - The `typedId` of the Claim whose items you want to validate
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function validateItems(string typedId, ValidateClaimItemsRequest payload, map<string|string[]> headers = {}) returns ValidateClaimItemsResponse|error {
        ValidateClaimItemsResponse|error r = self.oasClient->validateItems(typedId, payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->validateItems(typedId, payload, headers);
        }
        return r;
    }

    # Validate a Workflow Delegation
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function validateWorkflowDelegation(ValidateWorkflowDelegationRequest payload, map<string|string[]> headers = {}) returns ValidateWorkflowDelegationResponse|error {
        ValidateWorkflowDelegationResponse|error r = self.oasClient->validateWorkflowDelegation(payload, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->validateWorkflowDelegation(payload, headers);
        }
        return r;
    }

    # Withdraw a Document
    #
    # + currentStepId - The ID of the workflow step. It can be retrieved using the `/workflowsmanager.fetch/active` (**List Pending Approvals**) endpoint
    # + headers - Headers to be sent with the request 
    # + return - OK 
    remote isolated function withdrawDocument(string currentStepId, map<string|string[]> headers = {}) returns WithdrawDocumentResponse|error {
        WithdrawDocumentResponse|error r = self.oasClient->withdrawDocument(currentStepId, headers);
        if isAuthError(r) {
            check self.oasClient.reauthenticate();
            r = self.oasClient->withdrawDocument(currentStepId, headers);
        }
        return r;
    }

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
