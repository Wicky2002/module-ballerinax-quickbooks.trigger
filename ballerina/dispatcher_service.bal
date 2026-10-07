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

import ballerina/crypto;
import ballerina/http;
import ballerina/log;
import ballerinax/asyncapi.native.handler;

service class DispatcherService {
    *http:Service;
    private map<GenericServiceType> services = {};
    private handler:NativeHandler nativeHandler = new ();
    private string? webhookSecret;

    function init(string? webhookSecret) {
        self.webhookSecret = webhookSecret;
    }

    isolated function addServiceRef(string serviceType, GenericServiceType genericService) returns error? {
        if (self.services.hasKey(serviceType)) {
            return error(string `Service of type ${serviceType} has already been attached`);
        }
        self.services[serviceType] = genericService;
    }

    isolated function removeServiceRef(string serviceType) returns error? {
        if (!self.services.hasKey(serviceType)) {
            return error(string `Cannot detach the service of type ${serviceType}. Service has not been attached to the listener before`);
        }
        _ = self.services.remove(serviceType);
    }

    resource function post .(http:Caller caller, http:Request request) returns error? {
        error? verifyResult = self.verifyWebhookSignature(request, self.webhookSecret);
        if verifyResult is error {
            http:Response r = new;
            r.statusCode = http:STATUS_UNAUTHORIZED;
            check caller->respond(r);
            return;
        }
        json payload = check request.getJsonPayload();
        json[] eventsArray = check payload.ensureType();
        http:Response ackResponse = new;
        ackResponse.statusCode = http:STATUS_OK;
        check caller->respond(ackResponse);
        _ = start self.dispatchBatchedEvents(eventsArray, "");
    }

    isolated function dispatchBatchedEvents(json[] eventsArray, string eventType) returns error? {
        foreach json event in eventsArray {
            json|error eventTypeField = event.'type;
            if eventTypeField is error {
                log:printError("DISPATCH_FAILED", eventTypeField);
                continue;
            }
            string elementEventType = eventTypeField.toString();
            boolean|error dispatchResult = self.matchRemoteFunc(event, elementEventType);
            if dispatchResult is error {
                log:printError("DISPATCH_FAILED", dispatchResult);
            } else if !dispatchResult {
                log:printWarn("NO_HANDLER_FOR_EVENT", eventIdentifier = elementEventType);
            }
        }
    }

    private isolated function verifyWebhookSignature(http:Request request, string? webhookSecret) returns error? {
        if webhookSecret is () {
            return error("Unauthorized: Webhook Secret Not Configured");
        }
        if !request.hasHeader("Intuit-Signature") {
            return error("Unauthorized: Missing Signature Header");
        }
        string receivedHeader = check request.getHeader("Intuit-Signature");
        map<string> extractedHeaderValues = {};
        int headerCursor = 0;
        extractedHeaderValues["signature"] = receivedHeader.substring(headerCursor);
        headerCursor = receivedHeader.length();
        if !extractedHeaderValues.hasKey("signature") {
            return error("Unauthorized: Missing Header Component: signature");
        }
        string payloadToHash = string `${check request.getTextPayload()}`;
        byte[] computedDigest = check crypto:hmacSha256(payloadToHash.toBytes(), webhookSecret.toBytes());
        string computedSignature = computedDigest.toBase64();
        string expectedHeader = string `${computedSignature}`;
        if !crypto:equalConstantTime(receivedHeader.toBytes(), expectedHeader.toBytes()) {
            return error("Unauthorized: Signature Mismatch");
        }
    }

    private isolated function matchRemoteFunc(json payload, string eventType) returns boolean|error {
        if check self.matchRemoteFuncForCompanyCurrency(payload) {
            return true;
        }
        if check self.matchRemoteFuncForAccount(payload) {
            return true;
        }
        if check self.matchRemoteFuncForEstimate(payload) {
            return true;
        }
        if check self.matchRemoteFuncForInvoice(payload) {
            return true;
        }
        if check self.matchRemoteFuncForCustomer(payload) {
            return true;
        }
        if check self.matchRemoteFuncForTaxAgency(payload) {
            return true;
        }
        if check self.matchRemoteFuncForJournalEntry(payload) {
            return true;
        }
        if check self.matchRemoteFuncForItem(payload) {
            return true;
        }
        if check self.matchRemoteFuncForDepartment(payload) {
            return true;
        }
        if check self.matchRemoteFuncForRefundReceipt(payload) {
            return true;
        }
        if check self.matchRemoteFuncForCurrency(payload) {
            return true;
        }
        if check self.matchRemoteFuncForBillPayment(payload) {
            return true;
        }
        if check self.matchRemoteFuncForCreditMemo(payload) {
            return true;
        }
        if check self.matchRemoteFuncForBudget(payload) {
            return true;
        }
        if check self.matchRemoteFuncForPreferences(payload) {
            return true;
        }
        if check self.matchRemoteFuncForTimeActivity(payload) {
            return true;
        }
        if check self.matchRemoteFuncForDeposit(payload) {
            return true;
        }
        if check self.matchRemoteFuncForJournalCode(payload) {
            return true;
        }
        if check self.matchRemoteFuncForPurchase(payload) {
            return true;
        }
        if check self.matchRemoteFuncForVendorCredit(payload) {
            return true;
        }
        if check self.matchRemoteFuncForTerm(payload) {
            return true;
        }
        if check self.matchRemoteFuncForVendor(payload) {
            return true;
        }
        if check self.matchRemoteFuncForPayment(payload) {
            return true;
        }
        if check self.matchRemoteFuncForSalesReceipt(payload) {
            return true;
        }
        if check self.matchRemoteFuncForEmployee(payload) {
            return true;
        }
        if check self.matchRemoteFuncForChangeOrder(payload) {
            return true;
        }
        if check self.matchRemoteFuncForTransfer(payload) {
            return true;
        }
        if check self.matchRemoteFuncForBill(payload) {
            return true;
        }
        if check self.matchRemoteFuncForPurchaseOrder(payload) {
            return true;
        }
        if check self.matchRemoteFuncForPaymentMethod(payload) {
            return true;
        }
        if check self.matchRemoteFuncForClass(payload) {
            return true;
        }
        return false;
    }

    private isolated function matchRemoteFuncForCompanyCurrency(json payload) returns boolean|error {
        match payload.'type {
            "qbo.companycurrency.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.companycurrency.updated.v1", "CompanyCurrencyService", "onCompanyCurrencyUpdated");
                return true;
            }
            "qbo.companycurrency.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.companycurrency.deleted.v1", "CompanyCurrencyService", "onCompanyCurrencyDeleted");
                return true;
            }
            "qbo.companycurrency.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.companycurrency.created.v1", "CompanyCurrencyService", "onCompanyCurrencyCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForAccount(json payload) returns boolean|error {
        match payload.'type {
            "qbo.account.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.account.merged.v1", "AccountService", "onAccountMerged");
                return true;
            }
            "qbo.account.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.account.updated.v1", "AccountService", "onAccountUpdated");
                return true;
            }
            "qbo.account.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.account.created.v1", "AccountService", "onAccountCreated");
                return true;
            }
            "qbo.account.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.account.deleted.v1", "AccountService", "onAccountDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForEstimate(json payload) returns boolean|error {
        match payload.'type {
            "qbo.estimate.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.estimate.created.v1", "EstimateService", "onEstimateCreated");
                return true;
            }
            "qbo.estimate.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.estimate.emailed.v1", "EstimateService", "onEstimateEmailed");
                return true;
            }
            "qbo.estimate.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.estimate.deleted.v1", "EstimateService", "onEstimateDeleted");
                return true;
            }
            "qbo.estimate.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.estimate.updated.v1", "EstimateService", "onEstimateUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForInvoice(json payload) returns boolean|error {
        match payload.'type {
            "qbo.invoice.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.invoice.created.v1", "InvoiceService", "onInvoiceCreated");
                return true;
            }
            "qbo.invoice.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.invoice.updated.v1", "InvoiceService", "onInvoiceUpdated");
                return true;
            }
            "qbo.invoice.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.invoice.deleted.v1", "InvoiceService", "onInvoiceDeleted");
                return true;
            }
            "qbo.invoice.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.invoice.emailed.v1", "InvoiceService", "onInvoiceEmailed");
                return true;
            }
            "qbo.invoice.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.invoice.void.v1", "InvoiceService", "onInvoiceVoided");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForCustomer(json payload) returns boolean|error {
        match payload.'type {
            "qbo.customer.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.customer.deleted.v1", "CustomerService", "onCustomerDeleted");
                return true;
            }
            "qbo.customer.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.customer.created.v1", "CustomerService", "onCustomerCreated");
                return true;
            }
            "qbo.customer.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.customer.updated.v1", "CustomerService", "onCustomerUpdated");
                return true;
            }
            "qbo.customer.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.customer.merged.v1", "CustomerService", "onCustomerMerged");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForTaxAgency(json payload) returns boolean|error {
        match payload.'type {
            "qbo.taxagency.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.taxagency.updated.v1", "TaxAgencyService", "onTaxAgencyUpdated");
                return true;
            }
            "qbo.taxagency.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.taxagency.created.v1", "TaxAgencyService", "onTaxAgencyCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForJournalEntry(json payload) returns boolean|error {
        match payload.'type {
            "qbo.journalentry.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.journalentry.updated.v1", "JournalEntryService", "onJournalEntryUpdated");
                return true;
            }
            "qbo.journalentry.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.journalentry.deleted.v1", "JournalEntryService", "onJournalEntryDeleted");
                return true;
            }
            "qbo.journalentry.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.journalentry.created.v1", "JournalEntryService", "onJournalEntryCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForItem(json payload) returns boolean|error {
        match payload.'type {
            "qbo.item.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.item.created.v1", "ItemService", "onItemCreated");
                return true;
            }
            "qbo.item.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.item.deleted.v1", "ItemService", "onItemDeleted");
                return true;
            }
            "qbo.item.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.item.updated.v1", "ItemService", "onItemUpdated");
                return true;
            }
            "qbo.item.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.item.merged.v1", "ItemService", "onItemMerged");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForDepartment(json payload) returns boolean|error {
        match payload.'type {
            "qbo.department.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.department.created.v1", "DepartmentService", "onDepartmentCreated");
                return true;
            }
            "qbo.department.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.department.merged.v1", "DepartmentService", "onDepartmentMerged");
                return true;
            }
            "qbo.department.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.department.updated.v1", "DepartmentService", "onDepartmentUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForRefundReceipt(json payload) returns boolean|error {
        match payload.'type {
            "qbo.refundreceipt.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.refundreceipt.created.v1", "RefundReceiptService", "onRefundReceiptCreated");
                return true;
            }
            "qbo.refundreceipt.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.refundreceipt.deleted.v1", "RefundReceiptService", "onRefundReceiptDeleted");
                return true;
            }
            "qbo.refundreceipt.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.refundreceipt.emailed.v1", "RefundReceiptService", "onRefundReceiptEmailed");
                return true;
            }
            "qbo.refundreceipt.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.refundreceipt.void.v1", "RefundReceiptService", "onRefundReceiptVoided");
                return true;
            }
            "qbo.refundreceipt.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.refundreceipt.updated.v1", "RefundReceiptService", "onRefundReceiptUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForCurrency(json payload) returns boolean|error {
        match payload.'type {
            "qbo.currency.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.currency.created.v1", "CurrencyService", "onCurrencyCreated");
                return true;
            }
            "qbo.currency.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.currency.deleted.v1", "CurrencyService", "onCurrencyDeleted");
                return true;
            }
            "qbo.currency.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.currency.updated.v1", "CurrencyService", "onCurrencyUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForBillPayment(json payload) returns boolean|error {
        match payload.'type {
            "qbo.billpayment.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.billpayment.created.v1", "BillPaymentService", "onBillPaymentCreated");
                return true;
            }
            "qbo.billpayment.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.billpayment.deleted.v1", "BillPaymentService", "onBillPaymentDeleted");
                return true;
            }
            "qbo.billpayment.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.billpayment.void.v1", "BillPaymentService", "onBillPaymentVoided");
                return true;
            }
            "qbo.billpayment.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.billpayment.updated.v1", "BillPaymentService", "onBillPaymentUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForCreditMemo(json payload) returns boolean|error {
        match payload.'type {
            "qbo.creditmemo.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.creditmemo.updated.v1", "CreditMemoService", "onCreditMemoUpdated");
                return true;
            }
            "qbo.creditmemo.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.creditmemo.void.v1", "CreditMemoService", "onCreditMemoVoided");
                return true;
            }
            "qbo.creditmemo.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.creditmemo.emailed.v1", "CreditMemoService", "onCreditMemoEmailed");
                return true;
            }
            "qbo.creditmemo.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.creditmemo.created.v1", "CreditMemoService", "onCreditMemoCreated");
                return true;
            }
            "qbo.creditmemo.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.creditmemo.deleted.v1", "CreditMemoService", "onCreditMemoDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForBudget(json payload) returns boolean|error {
        match payload.'type {
            "qbo.budget.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.budget.updated.v1", "BudgetService", "onBudgetUpdated");
                return true;
            }
            "qbo.budget.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.budget.created.v1", "BudgetService", "onBudgetCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForPreferences(json payload) returns boolean|error {
        match payload.'type {
            "qbo.preferences.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.preferences.updated.v1", "PreferencesService", "onPreferencesUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForTimeActivity(json payload) returns boolean|error {
        match payload.'type {
            "qbo.timeactivity.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.timeactivity.created.v1", "TimeActivityService", "onTimeActivityCreated");
                return true;
            }
            "qbo.timeactivity.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.timeactivity.updated.v1", "TimeActivityService", "onTimeActivityUpdated");
                return true;
            }
            "qbo.timeactivity.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.timeactivity.deleted.v1", "TimeActivityService", "onTimeActivityDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForDeposit(json payload) returns boolean|error {
        match payload.'type {
            "qbo.deposit.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.deposit.created.v1", "DepositService", "onDepositCreated");
                return true;
            }
            "qbo.deposit.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.deposit.updated.v1", "DepositService", "onDepositUpdated");
                return true;
            }
            "qbo.deposit.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.deposit.deleted.v1", "DepositService", "onDepositDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForJournalCode(json payload) returns boolean|error {
        match payload.'type {
            "qbo.journalcode.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.journalcode.updated.v1", "JournalCodeService", "onJournalCodeUpdated");
                return true;
            }
            "qbo.journalcode.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.journalcode.created.v1", "JournalCodeService", "onJournalCodeCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForPurchase(json payload) returns boolean|error {
        match payload.'type {
            "qbo.purchase.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchase.void.v1", "PurchaseService", "onPurchaseVoided");
                return true;
            }
            "qbo.purchase.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchase.updated.v1", "PurchaseService", "onPurchaseUpdated");
                return true;
            }
            "qbo.purchase.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchase.deleted.v1", "PurchaseService", "onPurchaseDeleted");
                return true;
            }
            "qbo.purchase.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchase.created.v1", "PurchaseService", "onPurchaseCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForVendorCredit(json payload) returns boolean|error {
        match payload.'type {
            "qbo.vendorcredit.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendorcredit.created.v1", "VendorCreditService", "onVendorCreditCreated");
                return true;
            }
            "qbo.vendorcredit.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendorcredit.deleted.v1", "VendorCreditService", "onVendorCreditDeleted");
                return true;
            }
            "qbo.vendorcredit.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendorcredit.updated.v1", "VendorCreditService", "onVendorCreditUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForTerm(json payload) returns boolean|error {
        match payload.'type {
            "qbo.term.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.term.created.v1", "TermService", "onTermCreated");
                return true;
            }
            "qbo.term.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.term.updated.v1", "TermService", "onTermUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForVendor(json payload) returns boolean|error {
        match payload.'type {
            "qbo.vendor.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendor.updated.v1", "VendorService", "onVendorUpdated");
                return true;
            }
            "qbo.vendor.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendor.deleted.v1", "VendorService", "onVendorDeleted");
                return true;
            }
            "qbo.vendor.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendor.merged.v1", "VendorService", "onVendorMerged");
                return true;
            }
            "qbo.vendor.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.vendor.created.v1", "VendorService", "onVendorCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForPayment(json payload) returns boolean|error {
        match payload.'type {
            "qbo.payment.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.payment.updated.v1", "PaymentService", "onPaymentUpdated");
                return true;
            }
            "qbo.payment.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.payment.emailed.v1", "PaymentService", "onPaymentEmailed");
                return true;
            }
            "qbo.payment.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.payment.void.v1", "PaymentService", "onPaymentVoided");
                return true;
            }
            "qbo.payment.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.payment.created.v1", "PaymentService", "onPaymentCreated");
                return true;
            }
            "qbo.payment.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.payment.deleted.v1", "PaymentService", "onPaymentDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForSalesReceipt(json payload) returns boolean|error {
        match payload.'type {
            "qbo.salesreceipt.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.salesreceipt.created.v1", "SalesReceiptService", "onSalesReceiptCreated");
                return true;
            }
            "qbo.salesreceipt.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.salesreceipt.deleted.v1", "SalesReceiptService", "onSalesReceiptDeleted");
                return true;
            }
            "qbo.salesreceipt.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.salesreceipt.void.v1", "SalesReceiptService", "onSalesReceiptVoided");
                return true;
            }
            "qbo.salesreceipt.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.salesreceipt.updated.v1", "SalesReceiptService", "onSalesReceiptUpdated");
                return true;
            }
            "qbo.salesreceipt.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.salesreceipt.emailed.v1", "SalesReceiptService", "onSalesReceiptEmailed");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForEmployee(json payload) returns boolean|error {
        match payload.'type {
            "qbo.employee.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.employee.updated.v1", "EmployeeService", "onEmployeeUpdated");
                return true;
            }
            "qbo.employee.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.employee.merged.v1", "EmployeeService", "onEmployeeMerged");
                return true;
            }
            "qbo.employee.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.employee.created.v1", "EmployeeService", "onEmployeeCreated");
                return true;
            }
            "qbo.employee.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.employee.deleted.v1", "EmployeeService", "onEmployeeDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForChangeOrder(json payload) returns boolean|error {
        match payload.'type {
            "qbo.changeorder.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.changeorder.created.v1", "ChangeOrderService", "onChangeOrderCreated");
                return true;
            }
            "qbo.changeorder.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.changeorder.updated.v1", "ChangeOrderService", "onChangeOrderUpdated");
                return true;
            }
            "qbo.changeorder.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.changeorder.deleted.v1", "ChangeOrderService", "onChangeOrderDeleted");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForTransfer(json payload) returns boolean|error {
        match payload.'type {
            "qbo.transfer.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.transfer.created.v1", "TransferService", "onTransferCreated");
                return true;
            }
            "qbo.transfer.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.transfer.deleted.v1", "TransferService", "onTransferDeleted");
                return true;
            }
            "qbo.transfer.void.v1" => {
                check self.executeRemoteFunc(payload, "qbo.transfer.void.v1", "TransferService", "onTransferVoided");
                return true;
            }
            "qbo.transfer.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.transfer.updated.v1", "TransferService", "onTransferUpdated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForBill(json payload) returns boolean|error {
        match payload.'type {
            "qbo.bill.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.bill.updated.v1", "BillService", "onBillUpdated");
                return true;
            }
            "qbo.bill.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.bill.deleted.v1", "BillService", "onBillDeleted");
                return true;
            }
            "qbo.bill.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.bill.created.v1", "BillService", "onBillCreated");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForPurchaseOrder(json payload) returns boolean|error {
        match payload.'type {
            "qbo.purchaseorder.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchaseorder.deleted.v1", "PurchaseOrderService", "onPurchaseOrderDeleted");
                return true;
            }
            "qbo.purchaseorder.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchaseorder.created.v1", "PurchaseOrderService", "onPurchaseOrderCreated");
                return true;
            }
            "qbo.purchaseorder.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchaseorder.updated.v1", "PurchaseOrderService", "onPurchaseOrderUpdated");
                return true;
            }
            "qbo.purchaseorder.emailed.v1" => {
                check self.executeRemoteFunc(payload, "qbo.purchaseorder.emailed.v1", "PurchaseOrderService", "onPurchaseOrderEmailed");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForPaymentMethod(json payload) returns boolean|error {
        match payload.'type {
            "qbo.paymentmethod.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.paymentmethod.updated.v1", "PaymentMethodService", "onPaymentMethodUpdated");
                return true;
            }
            "qbo.paymentmethod.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.paymentmethod.created.v1", "PaymentMethodService", "onPaymentMethodCreated");
                return true;
            }
            "qbo.paymentmethod.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.paymentmethod.merged.v1", "PaymentMethodService", "onPaymentMethodMerged");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForClass(json payload) returns boolean|error {
        match payload.'type {
            "qbo.class.updated.v1" => {
                check self.executeRemoteFunc(payload, "qbo.class.updated.v1", "ClassService", "onClassUpdated");
                return true;
            }
            "qbo.class.deleted.v1" => {
                check self.executeRemoteFunc(payload, "qbo.class.deleted.v1", "ClassService", "onClassDeleted");
                return true;
            }
            "qbo.class.created.v1" => {
                check self.executeRemoteFunc(payload, "qbo.class.created.v1", "ClassService", "onClassCreated");
                return true;
            }
            "qbo.class.merged.v1" => {
                check self.executeRemoteFunc(payload, "qbo.class.merged.v1", "ClassService", "onClassMerged");
                return true;
            }
        }
        return false;
    }

    private isolated function executeRemoteFunc(json payload, string eventName, string serviceTypeStr, string eventFunction) returns error? {
        GenericServiceType? genericService = self.services[serviceTypeStr];
        if genericService is GenericServiceType {
            any boundEvent = check self.nativeHandler.bindEventPayload(genericService, eventFunction, payload);
            check self.nativeHandler.invokeRemoteFunction(boundEvent, eventName, eventFunction, genericService);
        } else {
            log:printDebug("SERVICE_NOT_ATTACHED", serviceType = serviceTypeStr, eventName = eventName);
        }
    }
}
