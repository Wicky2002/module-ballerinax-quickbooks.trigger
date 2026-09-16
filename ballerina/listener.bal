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

import ballerina/cloud;
import ballerina/http;

@display {label: "QuickBooks Webhooks", iconPath: "icon.png"}
public class Listener {
    private http:Listener httpListener;
    private DispatcherService dispatcherService;

    public function init(ListenerConfig listenerConfig = {}, @cloud:Expose int|http:Listener listenOn = 8090) returns error? {
        if listenOn is http:Listener {
            self.httpListener = listenOn;
        } else {
            self.httpListener = check new (listenOn);
        }
        self.dispatcherService = new DispatcherService(listenerConfig.webhookSecret);
        check self.httpListener.attach(self.dispatcherService, ());
    }

    public isolated function attach(GenericServiceType serviceRef, () attachPoint) returns error? {
        string serviceTypeStr = check self.getServiceTypeStr(serviceRef);
        check self.dispatcherService.addServiceRef(serviceTypeStr, serviceRef);
    }

    public isolated function detach(GenericServiceType serviceRef) returns error? {
        string serviceTypeStr = check self.getServiceTypeStr(serviceRef);
        check self.dispatcherService.removeServiceRef(serviceTypeStr);
    }

    public isolated function 'start() returns error? {
        return self.httpListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return self.httpListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.httpListener.immediateStop();
    }

    private isolated function getServiceTypeStr(GenericServiceType serviceRef) returns string|error {
        match serviceRef {
            var v if v is CompanyCurrencyService => {
                return "CompanyCurrencyService";
            }
            var v if v is AccountService => {
                return "AccountService";
            }
            var v if v is EstimateService => {
                return "EstimateService";
            }
            var v if v is InvoiceService => {
                return "InvoiceService";
            }
            var v if v is CustomerService => {
                return "CustomerService";
            }
            var v if v is TaxAgencyService => {
                return "TaxAgencyService";
            }
            var v if v is JournalEntryService => {
                return "JournalEntryService";
            }
            var v if v is ItemService => {
                return "ItemService";
            }
            var v if v is DepartmentService => {
                return "DepartmentService";
            }
            var v if v is RefundReceiptService => {
                return "RefundReceiptService";
            }
            var v if v is CurrencyService => {
                return "CurrencyService";
            }
            var v if v is BillPaymentService => {
                return "BillPaymentService";
            }
            var v if v is CreditMemoService => {
                return "CreditMemoService";
            }
            var v if v is BudgetService => {
                return "BudgetService";
            }
            var v if v is PreferencesService => {
                return "PreferencesService";
            }
            var v if v is TimeActivityService => {
                return "TimeActivityService";
            }
            var v if v is DepositService => {
                return "DepositService";
            }
            var v if v is JournalCodeService => {
                return "JournalCodeService";
            }
            var v if v is PurchaseService => {
                return "PurchaseService";
            }
            var v if v is VendorCreditService => {
                return "VendorCreditService";
            }
            var v if v is TermService => {
                return "TermService";
            }
            var v if v is VendorService => {
                return "VendorService";
            }
            var v if v is PaymentService => {
                return "PaymentService";
            }
            var v if v is SalesReceiptService => {
                return "SalesReceiptService";
            }
            var v if v is EmployeeService => {
                return "EmployeeService";
            }
            var v if v is ChangeOrderService => {
                return "ChangeOrderService";
            }
            var v if v is TransferService => {
                return "TransferService";
            }
            var v if v is BillService => {
                return "BillService";
            }
            var v if v is PurchaseOrderService => {
                return "PurchaseOrderService";
            }
            var v if v is PaymentMethodService => {
                return "PaymentMethodService";
            }
            var v if v is ClassService => {
                return "ClassService";
            }
            var _ => {
                return error("Unrecognized service type attached to the listener");
            }
        }
    }
}
