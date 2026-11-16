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

@display {label: "QuickBooks Webhooks", iconPath: "icon.png"}
public class Listener {
    private http:Listener httpListener;
    private ListenerConfig listenerConfig;
    private map<DispatcherService> dispatchers = {};
    private [string, GenericServiceType][] attachments = [];

    public function init(ListenerConfig listenerConfig = {}, int|http:Listener listenOn = 8090) returns error? {
        if listenOn is http:Listener {
            self.httpListener = listenOn;
        } else {
            self.httpListener = check new (listenOn, requestLimits = {maxEntityBodySize: 26214400});
        }
        self.listenerConfig = listenerConfig;
    }

    public isolated function attach(GenericServiceType serviceRef, string[]|string? attachPoint) returns error? {
        string serviceTypeStr = check self.getServiceTypeStr(serviceRef);
        string path = self.pathKey(attachPoint);
        DispatcherService dispatcher;
        DispatcherService? existing = self.dispatchers[path];
        if existing is DispatcherService {
            dispatcher = existing;
            check dispatcher.addServiceRef(serviceTypeStr, serviceRef);
        } else {
            dispatcher = new (self.listenerConfig.webhookSecret);
            check dispatcher.addServiceRef(serviceTypeStr, serviceRef);
            check self.httpListener.attach(dispatcher, path == "" ? () : path);
            self.dispatchers[path] = dispatcher;
        }
        self.attachments.push([path, serviceRef]);
    }

    public isolated function detach(GenericServiceType serviceRef) returns error? {
        string serviceTypeStr = check self.getServiceTypeStr(serviceRef);
        boolean detached = false;
        int i = 0;
        while i < self.attachments.length() {
            if self.attachments[i][1] !== serviceRef {
                i += 1;
                continue;
            }
            string path = self.attachments[i][0];
            DispatcherService dispatcher = self.dispatchers.get(path);
            boolean pathInUse = false;
            foreach int j in 0 ..< self.attachments.length() {
                if j != i && self.attachments[j][0] == path {
                    pathInUse = true;
                }
            }
            if !pathInUse {
                check self.httpListener.detach(dispatcher);
                _ = self.dispatchers.remove(path);
            }
            check dispatcher.removeServiceRef(serviceTypeStr);
            _ = self.attachments.remove(i);
            detached = true;
        }
        if !detached {
            return error(string `Cannot detach the service of type ${serviceTypeStr}. Service has not been attached to the listener before`);
        }
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
        string[] matched = [];
        if serviceRef is AccountService {
            matched.push("AccountService");
        }
        if serviceRef is BillService {
            matched.push("BillService");
        }
        if serviceRef is BillPaymentService {
            matched.push("BillPaymentService");
        }
        if serviceRef is BudgetService {
            matched.push("BudgetService");
        }
        if serviceRef is ChangeOrderService {
            matched.push("ChangeOrderService");
        }
        if serviceRef is ClassService {
            matched.push("ClassService");
        }
        if serviceRef is CreditMemoService {
            matched.push("CreditMemoService");
        }
        if serviceRef is CurrencyService {
            matched.push("CurrencyService");
        }
        if serviceRef is CustomerService {
            matched.push("CustomerService");
        }
        if serviceRef is DepartmentService {
            matched.push("DepartmentService");
        }
        if serviceRef is DepositService {
            matched.push("DepositService");
        }
        if serviceRef is EmployeeService {
            matched.push("EmployeeService");
        }
        if serviceRef is EstimateService {
            matched.push("EstimateService");
        }
        if serviceRef is InvoiceService {
            matched.push("InvoiceService");
        }
        if serviceRef is ItemService {
            matched.push("ItemService");
        }
        if serviceRef is JournalCodeService {
            matched.push("JournalCodeService");
        }
        if serviceRef is JournalEntryService {
            matched.push("JournalEntryService");
        }
        if serviceRef is PaymentService {
            matched.push("PaymentService");
        }
        if serviceRef is PaymentMethodService {
            matched.push("PaymentMethodService");
        }
        if serviceRef is PreferencesService {
            matched.push("PreferencesService");
        }
        if serviceRef is PurchaseService {
            matched.push("PurchaseService");
        }
        if serviceRef is PurchaseOrderService {
            matched.push("PurchaseOrderService");
        }
        if serviceRef is RefundReceiptService {
            matched.push("RefundReceiptService");
        }
        if serviceRef is SalesReceiptService {
            matched.push("SalesReceiptService");
        }
        if serviceRef is TaxAgencyService {
            matched.push("TaxAgencyService");
        }
        if serviceRef is TermService {
            matched.push("TermService");
        }
        if serviceRef is TimeActivityService {
            matched.push("TimeActivityService");
        }
        if serviceRef is TransferService {
            matched.push("TransferService");
        }
        if serviceRef is CompanyCurrencyService {
            matched.push("CompanyCurrencyService");
        }
        if serviceRef is VendorService {
            matched.push("VendorService");
        }
        if serviceRef is VendorCreditService {
            matched.push("VendorCreditService");
        }
        if matched.length() == 1 {
            return matched[0];
        }
        if matched.length() == 0 {
            return error("Unrecognized service type attached to the listener");
        }
        return error(string `The service matches more than one service type (${string:'join(", ", ...matched)}). Implement one service type per service`);
    }

    private isolated function pathKey(string[]|string? attachPoint) returns string {
        if attachPoint is () {
            return "";
        }
        string path = attachPoint is string ? attachPoint : string:'join("/", ...attachPoint);
        while path.startsWith("/") {
            path = path.substring(1);
        }
        while path.endsWith("/") {
            path = path.substring(0, path.length() - 1);
        }
        return path;
    }
}
