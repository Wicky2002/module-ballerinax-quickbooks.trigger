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
import ballerina/data.jsondata;
import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/test;

const TRIGGER_TEST_SECRET = "trigger-test-secret";
const TRIGGER_TEST_PORT = 9091;
const TRIGGER_PAYLOAD_DIR = "tests/resources/trigger_payloads";

isolated map<boolean> triggerFired = {};
isolated map<json> boundPayloads = {};
isolated map<json> boundJson = {};

listener Listener triggerTestListener = check new ({webhookSecret: TRIGGER_TEST_SECRET}, TRIGGER_TEST_PORT);

final http:Client triggerClient = check new (string `http://localhost:${TRIGGER_TEST_PORT}`);

service AccountService on triggerTestListener {
    isolated remote function onAccountCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["AccountService.onAccountCreated"] = received;
        }
        lock {
            triggerFired["AccountService.onAccountCreated"] = true;
        }
    }

    isolated remote function onAccountUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["AccountService.onAccountUpdated"] = received;
        }
        lock {
            triggerFired["AccountService.onAccountUpdated"] = true;
        }
    }

    isolated remote function onAccountDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["AccountService.onAccountDeleted"] = received;
        }
        lock {
            triggerFired["AccountService.onAccountDeleted"] = true;
        }
    }

    isolated remote function onAccountMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["AccountService.onAccountMerged"] = received;
        }
        lock {
            triggerFired["AccountService.onAccountMerged"] = true;
        }
    }
}

service BillService on triggerTestListener {
    isolated remote function onBillCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillService.onBillCreated"] = received;
        }
        lock {
            triggerFired["BillService.onBillCreated"] = true;
        }
    }

    isolated remote function onBillUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillService.onBillUpdated"] = received;
        }
        lock {
            triggerFired["BillService.onBillUpdated"] = true;
        }
    }

    isolated remote function onBillDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillService.onBillDeleted"] = received;
        }
        lock {
            triggerFired["BillService.onBillDeleted"] = true;
        }
    }
}

service BillPaymentService on triggerTestListener {
    isolated remote function onBillPaymentCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillPaymentService.onBillPaymentCreated"] = received;
        }
        lock {
            triggerFired["BillPaymentService.onBillPaymentCreated"] = true;
        }
    }

    isolated remote function onBillPaymentUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillPaymentService.onBillPaymentUpdated"] = received;
        }
        lock {
            triggerFired["BillPaymentService.onBillPaymentUpdated"] = true;
        }
    }

    isolated remote function onBillPaymentDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillPaymentService.onBillPaymentDeleted"] = received;
        }
        lock {
            triggerFired["BillPaymentService.onBillPaymentDeleted"] = true;
        }
    }

    isolated remote function onBillPaymentVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BillPaymentService.onBillPaymentVoided"] = received;
        }
        lock {
            triggerFired["BillPaymentService.onBillPaymentVoided"] = true;
        }
    }
}

service BudgetService on triggerTestListener {
    isolated remote function onBudgetCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BudgetService.onBudgetCreated"] = received;
        }
        lock {
            triggerFired["BudgetService.onBudgetCreated"] = true;
        }
    }

    isolated remote function onBudgetUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["BudgetService.onBudgetUpdated"] = received;
        }
        lock {
            triggerFired["BudgetService.onBudgetUpdated"] = true;
        }
    }
}

service ChangeOrderService on triggerTestListener {
    isolated remote function onChangeOrderCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ChangeOrderService.onChangeOrderCreated"] = received;
        }
        lock {
            triggerFired["ChangeOrderService.onChangeOrderCreated"] = true;
        }
    }

    isolated remote function onChangeOrderUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ChangeOrderService.onChangeOrderUpdated"] = received;
        }
        lock {
            triggerFired["ChangeOrderService.onChangeOrderUpdated"] = true;
        }
    }

    isolated remote function onChangeOrderDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ChangeOrderService.onChangeOrderDeleted"] = received;
        }
        lock {
            triggerFired["ChangeOrderService.onChangeOrderDeleted"] = true;
        }
    }
}

service ClassService on triggerTestListener {
    isolated remote function onClassCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ClassService.onClassCreated"] = received;
        }
        lock {
            triggerFired["ClassService.onClassCreated"] = true;
        }
    }

    isolated remote function onClassUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ClassService.onClassUpdated"] = received;
        }
        lock {
            triggerFired["ClassService.onClassUpdated"] = true;
        }
    }

    isolated remote function onClassDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ClassService.onClassDeleted"] = received;
        }
        lock {
            triggerFired["ClassService.onClassDeleted"] = true;
        }
    }

    isolated remote function onClassMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ClassService.onClassMerged"] = received;
        }
        lock {
            triggerFired["ClassService.onClassMerged"] = true;
        }
    }
}

service CreditMemoService on triggerTestListener {
    isolated remote function onCreditMemoCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CreditMemoService.onCreditMemoCreated"] = received;
        }
        lock {
            triggerFired["CreditMemoService.onCreditMemoCreated"] = true;
        }
    }

    isolated remote function onCreditMemoUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CreditMemoService.onCreditMemoUpdated"] = received;
        }
        lock {
            triggerFired["CreditMemoService.onCreditMemoUpdated"] = true;
        }
    }

    isolated remote function onCreditMemoDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CreditMemoService.onCreditMemoDeleted"] = received;
        }
        lock {
            triggerFired["CreditMemoService.onCreditMemoDeleted"] = true;
        }
    }

    isolated remote function onCreditMemoVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CreditMemoService.onCreditMemoVoided"] = received;
        }
        lock {
            triggerFired["CreditMemoService.onCreditMemoVoided"] = true;
        }
    }

    isolated remote function onCreditMemoEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CreditMemoService.onCreditMemoEmailed"] = received;
        }
        lock {
            triggerFired["CreditMemoService.onCreditMemoEmailed"] = true;
        }
    }
}

service CurrencyService on triggerTestListener {
    isolated remote function onCurrencyCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CurrencyService.onCurrencyCreated"] = received;
        }
        lock {
            triggerFired["CurrencyService.onCurrencyCreated"] = true;
        }
    }

    isolated remote function onCurrencyUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CurrencyService.onCurrencyUpdated"] = received;
        }
        lock {
            triggerFired["CurrencyService.onCurrencyUpdated"] = true;
        }
    }

    isolated remote function onCurrencyDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CurrencyService.onCurrencyDeleted"] = received;
        }
        lock {
            triggerFired["CurrencyService.onCurrencyDeleted"] = true;
        }
    }
}

service CustomerService on triggerTestListener {
    isolated remote function onCustomerCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CustomerService.onCustomerCreated"] = received;
        }
        lock {
            triggerFired["CustomerService.onCustomerCreated"] = true;
        }
    }

    isolated remote function onCustomerUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CustomerService.onCustomerUpdated"] = received;
        }
        lock {
            triggerFired["CustomerService.onCustomerUpdated"] = true;
        }
    }

    isolated remote function onCustomerDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CustomerService.onCustomerDeleted"] = received;
        }
        lock {
            triggerFired["CustomerService.onCustomerDeleted"] = true;
        }
    }

    isolated remote function onCustomerMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CustomerService.onCustomerMerged"] = received;
        }
        lock {
            triggerFired["CustomerService.onCustomerMerged"] = true;
        }
    }
}

service DepartmentService on triggerTestListener {
    isolated remote function onDepartmentCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepartmentService.onDepartmentCreated"] = received;
        }
        lock {
            triggerFired["DepartmentService.onDepartmentCreated"] = true;
        }
    }

    isolated remote function onDepartmentUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepartmentService.onDepartmentUpdated"] = received;
        }
        lock {
            triggerFired["DepartmentService.onDepartmentUpdated"] = true;
        }
    }

    isolated remote function onDepartmentMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepartmentService.onDepartmentMerged"] = received;
        }
        lock {
            triggerFired["DepartmentService.onDepartmentMerged"] = true;
        }
    }
}

service DepositService on triggerTestListener {
    isolated remote function onDepositCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepositService.onDepositCreated"] = received;
        }
        lock {
            triggerFired["DepositService.onDepositCreated"] = true;
        }
    }

    isolated remote function onDepositUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepositService.onDepositUpdated"] = received;
        }
        lock {
            triggerFired["DepositService.onDepositUpdated"] = true;
        }
    }

    isolated remote function onDepositDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DepositService.onDepositDeleted"] = received;
        }
        lock {
            triggerFired["DepositService.onDepositDeleted"] = true;
        }
    }
}

service EmployeeService on triggerTestListener {
    isolated remote function onEmployeeCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EmployeeService.onEmployeeCreated"] = received;
        }
        lock {
            triggerFired["EmployeeService.onEmployeeCreated"] = true;
        }
    }

    isolated remote function onEmployeeUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EmployeeService.onEmployeeUpdated"] = received;
        }
        lock {
            triggerFired["EmployeeService.onEmployeeUpdated"] = true;
        }
    }

    isolated remote function onEmployeeDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EmployeeService.onEmployeeDeleted"] = received;
        }
        lock {
            triggerFired["EmployeeService.onEmployeeDeleted"] = true;
        }
    }

    isolated remote function onEmployeeMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EmployeeService.onEmployeeMerged"] = received;
        }
        lock {
            triggerFired["EmployeeService.onEmployeeMerged"] = true;
        }
    }
}

service EstimateService on triggerTestListener {
    isolated remote function onEstimateCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EstimateService.onEstimateCreated"] = received;
        }
        lock {
            triggerFired["EstimateService.onEstimateCreated"] = true;
        }
    }

    isolated remote function onEstimateUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EstimateService.onEstimateUpdated"] = received;
        }
        lock {
            triggerFired["EstimateService.onEstimateUpdated"] = true;
        }
    }

    isolated remote function onEstimateDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EstimateService.onEstimateDeleted"] = received;
        }
        lock {
            triggerFired["EstimateService.onEstimateDeleted"] = true;
        }
    }

    isolated remote function onEstimateEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["EstimateService.onEstimateEmailed"] = received;
        }
        lock {
            triggerFired["EstimateService.onEstimateEmailed"] = true;
        }
    }
}

service InvoiceService on triggerTestListener {
    isolated remote function onInvoiceCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["InvoiceService.onInvoiceCreated"] = received;
        }
        lock {
            triggerFired["InvoiceService.onInvoiceCreated"] = true;
        }
    }

    isolated remote function onInvoiceUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["InvoiceService.onInvoiceUpdated"] = received;
        }
        lock {
            triggerFired["InvoiceService.onInvoiceUpdated"] = true;
        }
    }

    isolated remote function onInvoiceDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["InvoiceService.onInvoiceDeleted"] = received;
        }
        lock {
            triggerFired["InvoiceService.onInvoiceDeleted"] = true;
        }
    }

    isolated remote function onInvoiceVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["InvoiceService.onInvoiceVoided"] = received;
        }
        lock {
            triggerFired["InvoiceService.onInvoiceVoided"] = true;
        }
    }

    isolated remote function onInvoiceEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["InvoiceService.onInvoiceEmailed"] = received;
        }
        lock {
            triggerFired["InvoiceService.onInvoiceEmailed"] = true;
        }
    }
}

service ItemService on triggerTestListener {
    isolated remote function onItemCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ItemService.onItemCreated"] = received;
        }
        lock {
            triggerFired["ItemService.onItemCreated"] = true;
        }
    }

    isolated remote function onItemUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ItemService.onItemUpdated"] = received;
        }
        lock {
            triggerFired["ItemService.onItemUpdated"] = true;
        }
    }

    isolated remote function onItemDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ItemService.onItemDeleted"] = received;
        }
        lock {
            triggerFired["ItemService.onItemDeleted"] = true;
        }
    }

    isolated remote function onItemMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ItemService.onItemMerged"] = received;
        }
        lock {
            triggerFired["ItemService.onItemMerged"] = true;
        }
    }
}

service JournalCodeService on triggerTestListener {
    isolated remote function onJournalCodeCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["JournalCodeService.onJournalCodeCreated"] = received;
        }
        lock {
            triggerFired["JournalCodeService.onJournalCodeCreated"] = true;
        }
    }

    isolated remote function onJournalCodeUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["JournalCodeService.onJournalCodeUpdated"] = received;
        }
        lock {
            triggerFired["JournalCodeService.onJournalCodeUpdated"] = true;
        }
    }
}

service JournalEntryService on triggerTestListener {
    isolated remote function onJournalEntryCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["JournalEntryService.onJournalEntryCreated"] = received;
        }
        lock {
            triggerFired["JournalEntryService.onJournalEntryCreated"] = true;
        }
    }

    isolated remote function onJournalEntryUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["JournalEntryService.onJournalEntryUpdated"] = received;
        }
        lock {
            triggerFired["JournalEntryService.onJournalEntryUpdated"] = true;
        }
    }

    isolated remote function onJournalEntryDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["JournalEntryService.onJournalEntryDeleted"] = received;
        }
        lock {
            triggerFired["JournalEntryService.onJournalEntryDeleted"] = true;
        }
    }
}

service PaymentService on triggerTestListener {
    isolated remote function onPaymentCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentService.onPaymentCreated"] = received;
        }
        lock {
            triggerFired["PaymentService.onPaymentCreated"] = true;
        }
    }

    isolated remote function onPaymentUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentService.onPaymentUpdated"] = received;
        }
        lock {
            triggerFired["PaymentService.onPaymentUpdated"] = true;
        }
    }

    isolated remote function onPaymentDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentService.onPaymentDeleted"] = received;
        }
        lock {
            triggerFired["PaymentService.onPaymentDeleted"] = true;
        }
    }

    isolated remote function onPaymentVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentService.onPaymentVoided"] = received;
        }
        lock {
            triggerFired["PaymentService.onPaymentVoided"] = true;
        }
    }

    isolated remote function onPaymentEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentService.onPaymentEmailed"] = received;
        }
        lock {
            triggerFired["PaymentService.onPaymentEmailed"] = true;
        }
    }
}

service PaymentMethodService on triggerTestListener {
    isolated remote function onPaymentMethodCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentMethodService.onPaymentMethodCreated"] = received;
        }
        lock {
            triggerFired["PaymentMethodService.onPaymentMethodCreated"] = true;
        }
    }

    isolated remote function onPaymentMethodUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentMethodService.onPaymentMethodUpdated"] = received;
        }
        lock {
            triggerFired["PaymentMethodService.onPaymentMethodUpdated"] = true;
        }
    }

    isolated remote function onPaymentMethodMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PaymentMethodService.onPaymentMethodMerged"] = received;
        }
        lock {
            triggerFired["PaymentMethodService.onPaymentMethodMerged"] = true;
        }
    }
}

service PreferencesService on triggerTestListener {
    isolated remote function onPreferencesUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PreferencesService.onPreferencesUpdated"] = received;
        }
        lock {
            triggerFired["PreferencesService.onPreferencesUpdated"] = true;
        }
    }
}

service PurchaseService on triggerTestListener {
    isolated remote function onPurchaseCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseService.onPurchaseCreated"] = received;
        }
        lock {
            triggerFired["PurchaseService.onPurchaseCreated"] = true;
        }
    }

    isolated remote function onPurchaseUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseService.onPurchaseUpdated"] = received;
        }
        lock {
            triggerFired["PurchaseService.onPurchaseUpdated"] = true;
        }
    }

    isolated remote function onPurchaseDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseService.onPurchaseDeleted"] = received;
        }
        lock {
            triggerFired["PurchaseService.onPurchaseDeleted"] = true;
        }
    }

    isolated remote function onPurchaseVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseService.onPurchaseVoided"] = received;
        }
        lock {
            triggerFired["PurchaseService.onPurchaseVoided"] = true;
        }
    }
}

service PurchaseOrderService on triggerTestListener {
    isolated remote function onPurchaseOrderCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseOrderService.onPurchaseOrderCreated"] = received;
        }
        lock {
            triggerFired["PurchaseOrderService.onPurchaseOrderCreated"] = true;
        }
    }

    isolated remote function onPurchaseOrderUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseOrderService.onPurchaseOrderUpdated"] = received;
        }
        lock {
            triggerFired["PurchaseOrderService.onPurchaseOrderUpdated"] = true;
        }
    }

    isolated remote function onPurchaseOrderDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseOrderService.onPurchaseOrderDeleted"] = received;
        }
        lock {
            triggerFired["PurchaseOrderService.onPurchaseOrderDeleted"] = true;
        }
    }

    isolated remote function onPurchaseOrderEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["PurchaseOrderService.onPurchaseOrderEmailed"] = received;
        }
        lock {
            triggerFired["PurchaseOrderService.onPurchaseOrderEmailed"] = true;
        }
    }
}

service RefundReceiptService on triggerTestListener {
    isolated remote function onRefundReceiptCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["RefundReceiptService.onRefundReceiptCreated"] = received;
        }
        lock {
            triggerFired["RefundReceiptService.onRefundReceiptCreated"] = true;
        }
    }

    isolated remote function onRefundReceiptUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["RefundReceiptService.onRefundReceiptUpdated"] = received;
        }
        lock {
            triggerFired["RefundReceiptService.onRefundReceiptUpdated"] = true;
        }
    }

    isolated remote function onRefundReceiptDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["RefundReceiptService.onRefundReceiptDeleted"] = received;
        }
        lock {
            triggerFired["RefundReceiptService.onRefundReceiptDeleted"] = true;
        }
    }

    isolated remote function onRefundReceiptVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["RefundReceiptService.onRefundReceiptVoided"] = received;
        }
        lock {
            triggerFired["RefundReceiptService.onRefundReceiptVoided"] = true;
        }
    }

    isolated remote function onRefundReceiptEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["RefundReceiptService.onRefundReceiptEmailed"] = received;
        }
        lock {
            triggerFired["RefundReceiptService.onRefundReceiptEmailed"] = true;
        }
    }
}

service SalesReceiptService on triggerTestListener {
    isolated remote function onSalesReceiptCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["SalesReceiptService.onSalesReceiptCreated"] = received;
        }
        lock {
            triggerFired["SalesReceiptService.onSalesReceiptCreated"] = true;
        }
    }

    isolated remote function onSalesReceiptUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["SalesReceiptService.onSalesReceiptUpdated"] = received;
        }
        lock {
            triggerFired["SalesReceiptService.onSalesReceiptUpdated"] = true;
        }
    }

    isolated remote function onSalesReceiptDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["SalesReceiptService.onSalesReceiptDeleted"] = received;
        }
        lock {
            triggerFired["SalesReceiptService.onSalesReceiptDeleted"] = true;
        }
    }

    isolated remote function onSalesReceiptVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["SalesReceiptService.onSalesReceiptVoided"] = received;
        }
        lock {
            triggerFired["SalesReceiptService.onSalesReceiptVoided"] = true;
        }
    }

    isolated remote function onSalesReceiptEmailed(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["SalesReceiptService.onSalesReceiptEmailed"] = received;
        }
        lock {
            triggerFired["SalesReceiptService.onSalesReceiptEmailed"] = true;
        }
    }
}

service TaxAgencyService on triggerTestListener {
    isolated remote function onTaxAgencyCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TaxAgencyService.onTaxAgencyCreated"] = received;
        }
        lock {
            triggerFired["TaxAgencyService.onTaxAgencyCreated"] = true;
        }
    }

    isolated remote function onTaxAgencyUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TaxAgencyService.onTaxAgencyUpdated"] = received;
        }
        lock {
            triggerFired["TaxAgencyService.onTaxAgencyUpdated"] = true;
        }
    }
}

service TermService on triggerTestListener {
    isolated remote function onTermCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TermService.onTermCreated"] = received;
        }
        lock {
            triggerFired["TermService.onTermCreated"] = true;
        }
    }

    isolated remote function onTermUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TermService.onTermUpdated"] = received;
        }
        lock {
            triggerFired["TermService.onTermUpdated"] = true;
        }
    }
}

service TimeActivityService on triggerTestListener {
    isolated remote function onTimeActivityCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TimeActivityService.onTimeActivityCreated"] = received;
        }
        lock {
            triggerFired["TimeActivityService.onTimeActivityCreated"] = true;
        }
    }

    isolated remote function onTimeActivityUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TimeActivityService.onTimeActivityUpdated"] = received;
        }
        lock {
            triggerFired["TimeActivityService.onTimeActivityUpdated"] = true;
        }
    }

    isolated remote function onTimeActivityDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TimeActivityService.onTimeActivityDeleted"] = received;
        }
        lock {
            triggerFired["TimeActivityService.onTimeActivityDeleted"] = true;
        }
    }
}

service TransferService on triggerTestListener {
    isolated remote function onTransferCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TransferService.onTransferCreated"] = received;
        }
        lock {
            triggerFired["TransferService.onTransferCreated"] = true;
        }
    }

    isolated remote function onTransferUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TransferService.onTransferUpdated"] = received;
        }
        lock {
            triggerFired["TransferService.onTransferUpdated"] = true;
        }
    }

    isolated remote function onTransferDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TransferService.onTransferDeleted"] = received;
        }
        lock {
            triggerFired["TransferService.onTransferDeleted"] = true;
        }
    }

    isolated remote function onTransferVoided(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TransferService.onTransferVoided"] = received;
        }
        lock {
            triggerFired["TransferService.onTransferVoided"] = true;
        }
    }
}

service CompanyCurrencyService on triggerTestListener {
    isolated remote function onCompanyCurrencyCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyCurrencyService.onCompanyCurrencyCreated"] = received;
        }
        lock {
            triggerFired["CompanyCurrencyService.onCompanyCurrencyCreated"] = true;
        }
    }

    isolated remote function onCompanyCurrencyUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyCurrencyService.onCompanyCurrencyUpdated"] = received;
        }
        lock {
            triggerFired["CompanyCurrencyService.onCompanyCurrencyUpdated"] = true;
        }
    }

    isolated remote function onCompanyCurrencyDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyCurrencyService.onCompanyCurrencyDeleted"] = received;
        }
        lock {
            triggerFired["CompanyCurrencyService.onCompanyCurrencyDeleted"] = true;
        }
    }
}

service VendorService on triggerTestListener {
    isolated remote function onVendorCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorService.onVendorCreated"] = received;
        }
        lock {
            triggerFired["VendorService.onVendorCreated"] = true;
        }
    }

    isolated remote function onVendorUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorService.onVendorUpdated"] = received;
        }
        lock {
            triggerFired["VendorService.onVendorUpdated"] = true;
        }
    }

    isolated remote function onVendorDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorService.onVendorDeleted"] = received;
        }
        lock {
            triggerFired["VendorService.onVendorDeleted"] = true;
        }
    }

    isolated remote function onVendorMerged(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorService.onVendorMerged"] = received;
        }
        lock {
            triggerFired["VendorService.onVendorMerged"] = true;
        }
    }
}

service VendorCreditService on triggerTestListener {
    isolated remote function onVendorCreditCreated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorCreditService.onVendorCreditCreated"] = received;
        }
        lock {
            triggerFired["VendorCreditService.onVendorCreditCreated"] = true;
        }
    }

    isolated remote function onVendorCreditUpdated(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorCreditService.onVendorCreditUpdated"] = received;
        }
        lock {
            triggerFired["VendorCreditService.onVendorCreditUpdated"] = true;
        }
    }

    isolated remote function onVendorCreditDeleted(QuickBookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["VendorCreditService.onVendorCreditDeleted"] = received;
        }
        lock {
            triggerFired["VendorCreditService.onVendorCreditDeleted"] = true;
        }
    }
}

isolated function sendSignedTriggerWebhook(string eventIdentifier) returns http:Response|error {
    byte[] body = check io:fileReadBytes(string `${TRIGGER_PAYLOAD_DIR}/${eventIdentifier}.json`);
    string bodyText = check string:fromBytes(body);
    string payloadToHash = string `${bodyText}`;
    byte[] computedDigest = check crypto:hmacSha256(payloadToHash.toBytes(), TRIGGER_TEST_SECRET.toBytes());
    string computedSignature = computedDigest.toBase64();
    map<string> headers = {
        "Intuit-Signature": string `${computedSignature}`
    };
    return triggerClient->post("/", body, headers, "application/json");
}

function waitForDispatch(string trackerKey) returns boolean {
    foreach int i in 0 ..< 20 {
        lock {
            if triggerFired[trackerKey] ?: false {
                return true;
            }
        }
        runtime:sleep(0.05);
    }
    return false;
}

function boundJsonOf(string trackerKey) returns json {
    lock {
        return boundJson[trackerKey].clone();
    }
}

function deliveredEvent(json bound, json fixture) returns json {
    return fixture is json[] && fixture.length() == 1 && bound is map<json>
        ? fixture[0] : fixture;
}

function assertBindsFixture(json bound, json fixture, string at) {
    if fixture is map<json> {
        test:assertTrue(bound is map<json>, string `${at} should have bound to an object`);
        if bound is map<json> {
            foreach [string, json] [key, value] in fixture.entries() {
                assertBindsFixture(bound[key], value, string `${at}.${key}`);
            }
        }
    } else if fixture is json[] {
        test:assertTrue(bound is json[] && bound.length() == fixture.length(),
                string `${at} should have bound to an array of ${fixture.length()}`);
        if bound is json[] && bound.length() == fixture.length() {
            foreach int i in 0 ..< fixture.length() {
                assertBindsFixture(bound[i], fixture[i], string `${at}[${i}]`);
            }
        }
    } else if fixture is int|float|decimal && bound is int|float|decimal {
        test:assertEquals(<decimal>bound, <decimal>fixture,
                string `${at} should have bound unchanged`);
    } else {
        test:assertEquals(bound, fixture,
                string `${at} should have bound unchanged`);
    }
}

@test:Config {}
function testAccountCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.account.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("AccountService.onAccountCreated"), "AccountService.onAccountCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.account.created.v1.json`);
    json received = boundJsonOf("AccountService.onAccountCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testAccountUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.account.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("AccountService.onAccountUpdated"), "AccountService.onAccountUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.account.updated.v1.json`);
    json received = boundJsonOf("AccountService.onAccountUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testAccountDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.account.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("AccountService.onAccountDeleted"), "AccountService.onAccountDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.account.deleted.v1.json`);
    json received = boundJsonOf("AccountService.onAccountDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testAccountMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.account.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("AccountService.onAccountMerged"), "AccountService.onAccountMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.account.merged.v1.json`);
    json received = boundJsonOf("AccountService.onAccountMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.bill.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillService.onBillCreated"), "BillService.onBillCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.bill.created.v1.json`);
    json received = boundJsonOf("BillService.onBillCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.bill.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillService.onBillUpdated"), "BillService.onBillUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.bill.updated.v1.json`);
    json received = boundJsonOf("BillService.onBillUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.bill.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillService.onBillDeleted"), "BillService.onBillDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.bill.deleted.v1.json`);
    json received = boundJsonOf("BillService.onBillDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillPaymentCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.billpayment.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillPaymentService.onBillPaymentCreated"), "BillPaymentService.onBillPaymentCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.billpayment.created.v1.json`);
    json received = boundJsonOf("BillPaymentService.onBillPaymentCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillPaymentUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.billpayment.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillPaymentService.onBillPaymentUpdated"), "BillPaymentService.onBillPaymentUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.billpayment.updated.v1.json`);
    json received = boundJsonOf("BillPaymentService.onBillPaymentUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillPaymentDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.billpayment.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillPaymentService.onBillPaymentDeleted"), "BillPaymentService.onBillPaymentDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.billpayment.deleted.v1.json`);
    json received = boundJsonOf("BillPaymentService.onBillPaymentDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBillPaymentVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.billpayment.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BillPaymentService.onBillPaymentVoided"), "BillPaymentService.onBillPaymentVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.billpayment.void.v1.json`);
    json received = boundJsonOf("BillPaymentService.onBillPaymentVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBudgetCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.budget.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BudgetService.onBudgetCreated"), "BudgetService.onBudgetCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.budget.created.v1.json`);
    json received = boundJsonOf("BudgetService.onBudgetCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testBudgetUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.budget.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("BudgetService.onBudgetUpdated"), "BudgetService.onBudgetUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.budget.updated.v1.json`);
    json received = boundJsonOf("BudgetService.onBudgetUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testChangeOrderCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.changeorder.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ChangeOrderService.onChangeOrderCreated"), "ChangeOrderService.onChangeOrderCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.changeorder.created.v1.json`);
    json received = boundJsonOf("ChangeOrderService.onChangeOrderCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testChangeOrderUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.changeorder.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ChangeOrderService.onChangeOrderUpdated"), "ChangeOrderService.onChangeOrderUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.changeorder.updated.v1.json`);
    json received = boundJsonOf("ChangeOrderService.onChangeOrderUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testChangeOrderDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.changeorder.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ChangeOrderService.onChangeOrderDeleted"), "ChangeOrderService.onChangeOrderDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.changeorder.deleted.v1.json`);
    json received = boundJsonOf("ChangeOrderService.onChangeOrderDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testClassCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.class.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ClassService.onClassCreated"), "ClassService.onClassCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.class.created.v1.json`);
    json received = boundJsonOf("ClassService.onClassCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testClassUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.class.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ClassService.onClassUpdated"), "ClassService.onClassUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.class.updated.v1.json`);
    json received = boundJsonOf("ClassService.onClassUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testClassDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.class.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ClassService.onClassDeleted"), "ClassService.onClassDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.class.deleted.v1.json`);
    json received = boundJsonOf("ClassService.onClassDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testClassMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.class.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ClassService.onClassMerged"), "ClassService.onClassMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.class.merged.v1.json`);
    json received = boundJsonOf("ClassService.onClassMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCreditMemoCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.creditmemo.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CreditMemoService.onCreditMemoCreated"), "CreditMemoService.onCreditMemoCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.creditmemo.created.v1.json`);
    json received = boundJsonOf("CreditMemoService.onCreditMemoCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCreditMemoUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.creditmemo.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CreditMemoService.onCreditMemoUpdated"), "CreditMemoService.onCreditMemoUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.creditmemo.updated.v1.json`);
    json received = boundJsonOf("CreditMemoService.onCreditMemoUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCreditMemoDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.creditmemo.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CreditMemoService.onCreditMemoDeleted"), "CreditMemoService.onCreditMemoDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.creditmemo.deleted.v1.json`);
    json received = boundJsonOf("CreditMemoService.onCreditMemoDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCreditMemoVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.creditmemo.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CreditMemoService.onCreditMemoVoided"), "CreditMemoService.onCreditMemoVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.creditmemo.void.v1.json`);
    json received = boundJsonOf("CreditMemoService.onCreditMemoVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCreditMemoEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.creditmemo.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CreditMemoService.onCreditMemoEmailed"), "CreditMemoService.onCreditMemoEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.creditmemo.emailed.v1.json`);
    json received = boundJsonOf("CreditMemoService.onCreditMemoEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCurrencyCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.currency.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CurrencyService.onCurrencyCreated"), "CurrencyService.onCurrencyCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.currency.created.v1.json`);
    json received = boundJsonOf("CurrencyService.onCurrencyCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCurrencyUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.currency.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CurrencyService.onCurrencyUpdated"), "CurrencyService.onCurrencyUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.currency.updated.v1.json`);
    json received = boundJsonOf("CurrencyService.onCurrencyUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCurrencyDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.currency.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CurrencyService.onCurrencyDeleted"), "CurrencyService.onCurrencyDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.currency.deleted.v1.json`);
    json received = boundJsonOf("CurrencyService.onCurrencyDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCustomerCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.customer.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CustomerService.onCustomerCreated"), "CustomerService.onCustomerCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.customer.created.v1.json`);
    json received = boundJsonOf("CustomerService.onCustomerCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCustomerUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.customer.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CustomerService.onCustomerUpdated"), "CustomerService.onCustomerUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.customer.updated.v1.json`);
    json received = boundJsonOf("CustomerService.onCustomerUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCustomerDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.customer.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CustomerService.onCustomerDeleted"), "CustomerService.onCustomerDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.customer.deleted.v1.json`);
    json received = boundJsonOf("CustomerService.onCustomerDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCustomerMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.customer.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CustomerService.onCustomerMerged"), "CustomerService.onCustomerMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.customer.merged.v1.json`);
    json received = boundJsonOf("CustomerService.onCustomerMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepartmentCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.department.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepartmentService.onDepartmentCreated"), "DepartmentService.onDepartmentCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.department.created.v1.json`);
    json received = boundJsonOf("DepartmentService.onDepartmentCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepartmentUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.department.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepartmentService.onDepartmentUpdated"), "DepartmentService.onDepartmentUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.department.updated.v1.json`);
    json received = boundJsonOf("DepartmentService.onDepartmentUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepartmentMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.department.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepartmentService.onDepartmentMerged"), "DepartmentService.onDepartmentMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.department.merged.v1.json`);
    json received = boundJsonOf("DepartmentService.onDepartmentMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepositCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.deposit.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepositService.onDepositCreated"), "DepositService.onDepositCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.deposit.created.v1.json`);
    json received = boundJsonOf("DepositService.onDepositCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepositUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.deposit.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepositService.onDepositUpdated"), "DepositService.onDepositUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.deposit.updated.v1.json`);
    json received = boundJsonOf("DepositService.onDepositUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testDepositDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.deposit.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DepositService.onDepositDeleted"), "DepositService.onDepositDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.deposit.deleted.v1.json`);
    json received = boundJsonOf("DepositService.onDepositDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEmployeeCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.employee.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EmployeeService.onEmployeeCreated"), "EmployeeService.onEmployeeCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.employee.created.v1.json`);
    json received = boundJsonOf("EmployeeService.onEmployeeCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEmployeeUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.employee.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EmployeeService.onEmployeeUpdated"), "EmployeeService.onEmployeeUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.employee.updated.v1.json`);
    json received = boundJsonOf("EmployeeService.onEmployeeUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEmployeeDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.employee.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EmployeeService.onEmployeeDeleted"), "EmployeeService.onEmployeeDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.employee.deleted.v1.json`);
    json received = boundJsonOf("EmployeeService.onEmployeeDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEmployeeMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.employee.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EmployeeService.onEmployeeMerged"), "EmployeeService.onEmployeeMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.employee.merged.v1.json`);
    json received = boundJsonOf("EmployeeService.onEmployeeMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEstimateCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.estimate.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EstimateService.onEstimateCreated"), "EstimateService.onEstimateCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.estimate.created.v1.json`);
    json received = boundJsonOf("EstimateService.onEstimateCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEstimateUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.estimate.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EstimateService.onEstimateUpdated"), "EstimateService.onEstimateUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.estimate.updated.v1.json`);
    json received = boundJsonOf("EstimateService.onEstimateUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEstimateDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.estimate.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EstimateService.onEstimateDeleted"), "EstimateService.onEstimateDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.estimate.deleted.v1.json`);
    json received = boundJsonOf("EstimateService.onEstimateDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testEstimateEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.estimate.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("EstimateService.onEstimateEmailed"), "EstimateService.onEstimateEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.estimate.emailed.v1.json`);
    json received = boundJsonOf("EstimateService.onEstimateEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testInvoiceCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.invoice.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("InvoiceService.onInvoiceCreated"), "InvoiceService.onInvoiceCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.invoice.created.v1.json`);
    json received = boundJsonOf("InvoiceService.onInvoiceCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testInvoiceUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.invoice.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("InvoiceService.onInvoiceUpdated"), "InvoiceService.onInvoiceUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.invoice.updated.v1.json`);
    json received = boundJsonOf("InvoiceService.onInvoiceUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testInvoiceDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.invoice.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("InvoiceService.onInvoiceDeleted"), "InvoiceService.onInvoiceDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.invoice.deleted.v1.json`);
    json received = boundJsonOf("InvoiceService.onInvoiceDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testInvoiceVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.invoice.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("InvoiceService.onInvoiceVoided"), "InvoiceService.onInvoiceVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.invoice.void.v1.json`);
    json received = boundJsonOf("InvoiceService.onInvoiceVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testInvoiceEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.invoice.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("InvoiceService.onInvoiceEmailed"), "InvoiceService.onInvoiceEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.invoice.emailed.v1.json`);
    json received = boundJsonOf("InvoiceService.onInvoiceEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testItemCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.item.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ItemService.onItemCreated"), "ItemService.onItemCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.item.created.v1.json`);
    json received = boundJsonOf("ItemService.onItemCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testItemUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.item.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ItemService.onItemUpdated"), "ItemService.onItemUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.item.updated.v1.json`);
    json received = boundJsonOf("ItemService.onItemUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testItemDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.item.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ItemService.onItemDeleted"), "ItemService.onItemDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.item.deleted.v1.json`);
    json received = boundJsonOf("ItemService.onItemDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testItemMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.item.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ItemService.onItemMerged"), "ItemService.onItemMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.item.merged.v1.json`);
    json received = boundJsonOf("ItemService.onItemMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testJournalCodeCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.journalcode.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("JournalCodeService.onJournalCodeCreated"), "JournalCodeService.onJournalCodeCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.journalcode.created.v1.json`);
    json received = boundJsonOf("JournalCodeService.onJournalCodeCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testJournalCodeUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.journalcode.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("JournalCodeService.onJournalCodeUpdated"), "JournalCodeService.onJournalCodeUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.journalcode.updated.v1.json`);
    json received = boundJsonOf("JournalCodeService.onJournalCodeUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testJournalEntryCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.journalentry.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("JournalEntryService.onJournalEntryCreated"), "JournalEntryService.onJournalEntryCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.journalentry.created.v1.json`);
    json received = boundJsonOf("JournalEntryService.onJournalEntryCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testJournalEntryUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.journalentry.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("JournalEntryService.onJournalEntryUpdated"), "JournalEntryService.onJournalEntryUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.journalentry.updated.v1.json`);
    json received = boundJsonOf("JournalEntryService.onJournalEntryUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testJournalEntryDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.journalentry.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("JournalEntryService.onJournalEntryDeleted"), "JournalEntryService.onJournalEntryDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.journalentry.deleted.v1.json`);
    json received = boundJsonOf("JournalEntryService.onJournalEntryDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.payment.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentService.onPaymentCreated"), "PaymentService.onPaymentCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.payment.created.v1.json`);
    json received = boundJsonOf("PaymentService.onPaymentCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.payment.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentService.onPaymentUpdated"), "PaymentService.onPaymentUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.payment.updated.v1.json`);
    json received = boundJsonOf("PaymentService.onPaymentUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.payment.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentService.onPaymentDeleted"), "PaymentService.onPaymentDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.payment.deleted.v1.json`);
    json received = boundJsonOf("PaymentService.onPaymentDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.payment.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentService.onPaymentVoided"), "PaymentService.onPaymentVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.payment.void.v1.json`);
    json received = boundJsonOf("PaymentService.onPaymentVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.payment.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentService.onPaymentEmailed"), "PaymentService.onPaymentEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.payment.emailed.v1.json`);
    json received = boundJsonOf("PaymentService.onPaymentEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentMethodCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.paymentmethod.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentMethodService.onPaymentMethodCreated"), "PaymentMethodService.onPaymentMethodCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.paymentmethod.created.v1.json`);
    json received = boundJsonOf("PaymentMethodService.onPaymentMethodCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentMethodUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.paymentmethod.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentMethodService.onPaymentMethodUpdated"), "PaymentMethodService.onPaymentMethodUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.paymentmethod.updated.v1.json`);
    json received = boundJsonOf("PaymentMethodService.onPaymentMethodUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPaymentMethodMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.paymentmethod.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PaymentMethodService.onPaymentMethodMerged"), "PaymentMethodService.onPaymentMethodMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.paymentmethod.merged.v1.json`);
    json received = boundJsonOf("PaymentMethodService.onPaymentMethodMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPreferencesUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.preferences.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PreferencesService.onPreferencesUpdated"), "PreferencesService.onPreferencesUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.preferences.updated.v1.json`);
    json received = boundJsonOf("PreferencesService.onPreferencesUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchase.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseService.onPurchaseCreated"), "PurchaseService.onPurchaseCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchase.created.v1.json`);
    json received = boundJsonOf("PurchaseService.onPurchaseCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchase.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseService.onPurchaseUpdated"), "PurchaseService.onPurchaseUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchase.updated.v1.json`);
    json received = boundJsonOf("PurchaseService.onPurchaseUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchase.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseService.onPurchaseDeleted"), "PurchaseService.onPurchaseDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchase.deleted.v1.json`);
    json received = boundJsonOf("PurchaseService.onPurchaseDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchase.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseService.onPurchaseVoided"), "PurchaseService.onPurchaseVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchase.void.v1.json`);
    json received = boundJsonOf("PurchaseService.onPurchaseVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseOrderCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchaseorder.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseOrderService.onPurchaseOrderCreated"), "PurchaseOrderService.onPurchaseOrderCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchaseorder.created.v1.json`);
    json received = boundJsonOf("PurchaseOrderService.onPurchaseOrderCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseOrderUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchaseorder.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseOrderService.onPurchaseOrderUpdated"), "PurchaseOrderService.onPurchaseOrderUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchaseorder.updated.v1.json`);
    json received = boundJsonOf("PurchaseOrderService.onPurchaseOrderUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseOrderDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchaseorder.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseOrderService.onPurchaseOrderDeleted"), "PurchaseOrderService.onPurchaseOrderDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchaseorder.deleted.v1.json`);
    json received = boundJsonOf("PurchaseOrderService.onPurchaseOrderDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testPurchaseOrderEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.purchaseorder.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("PurchaseOrderService.onPurchaseOrderEmailed"), "PurchaseOrderService.onPurchaseOrderEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.purchaseorder.emailed.v1.json`);
    json received = boundJsonOf("PurchaseOrderService.onPurchaseOrderEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testRefundReceiptCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.refundreceipt.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("RefundReceiptService.onRefundReceiptCreated"), "RefundReceiptService.onRefundReceiptCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.refundreceipt.created.v1.json`);
    json received = boundJsonOf("RefundReceiptService.onRefundReceiptCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testRefundReceiptUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.refundreceipt.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("RefundReceiptService.onRefundReceiptUpdated"), "RefundReceiptService.onRefundReceiptUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.refundreceipt.updated.v1.json`);
    json received = boundJsonOf("RefundReceiptService.onRefundReceiptUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testRefundReceiptDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.refundreceipt.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("RefundReceiptService.onRefundReceiptDeleted"), "RefundReceiptService.onRefundReceiptDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.refundreceipt.deleted.v1.json`);
    json received = boundJsonOf("RefundReceiptService.onRefundReceiptDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testRefundReceiptVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.refundreceipt.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("RefundReceiptService.onRefundReceiptVoided"), "RefundReceiptService.onRefundReceiptVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.refundreceipt.void.v1.json`);
    json received = boundJsonOf("RefundReceiptService.onRefundReceiptVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testRefundReceiptEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.refundreceipt.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("RefundReceiptService.onRefundReceiptEmailed"), "RefundReceiptService.onRefundReceiptEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.refundreceipt.emailed.v1.json`);
    json received = boundJsonOf("RefundReceiptService.onRefundReceiptEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testSalesReceiptCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.salesreceipt.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("SalesReceiptService.onSalesReceiptCreated"), "SalesReceiptService.onSalesReceiptCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.salesreceipt.created.v1.json`);
    json received = boundJsonOf("SalesReceiptService.onSalesReceiptCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testSalesReceiptUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.salesreceipt.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("SalesReceiptService.onSalesReceiptUpdated"), "SalesReceiptService.onSalesReceiptUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.salesreceipt.updated.v1.json`);
    json received = boundJsonOf("SalesReceiptService.onSalesReceiptUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testSalesReceiptDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.salesreceipt.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("SalesReceiptService.onSalesReceiptDeleted"), "SalesReceiptService.onSalesReceiptDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.salesreceipt.deleted.v1.json`);
    json received = boundJsonOf("SalesReceiptService.onSalesReceiptDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testSalesReceiptVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.salesreceipt.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("SalesReceiptService.onSalesReceiptVoided"), "SalesReceiptService.onSalesReceiptVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.salesreceipt.void.v1.json`);
    json received = boundJsonOf("SalesReceiptService.onSalesReceiptVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testSalesReceiptEmailedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.salesreceipt.emailed.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("SalesReceiptService.onSalesReceiptEmailed"), "SalesReceiptService.onSalesReceiptEmailed should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.salesreceipt.emailed.v1.json`);
    json received = boundJsonOf("SalesReceiptService.onSalesReceiptEmailed");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTaxAgencyCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.taxagency.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TaxAgencyService.onTaxAgencyCreated"), "TaxAgencyService.onTaxAgencyCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.taxagency.created.v1.json`);
    json received = boundJsonOf("TaxAgencyService.onTaxAgencyCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTaxAgencyUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.taxagency.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TaxAgencyService.onTaxAgencyUpdated"), "TaxAgencyService.onTaxAgencyUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.taxagency.updated.v1.json`);
    json received = boundJsonOf("TaxAgencyService.onTaxAgencyUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTermCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.term.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TermService.onTermCreated"), "TermService.onTermCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.term.created.v1.json`);
    json received = boundJsonOf("TermService.onTermCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTermUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.term.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TermService.onTermUpdated"), "TermService.onTermUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.term.updated.v1.json`);
    json received = boundJsonOf("TermService.onTermUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTimeActivityCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.timeactivity.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TimeActivityService.onTimeActivityCreated"), "TimeActivityService.onTimeActivityCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.timeactivity.created.v1.json`);
    json received = boundJsonOf("TimeActivityService.onTimeActivityCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTimeActivityUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.timeactivity.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TimeActivityService.onTimeActivityUpdated"), "TimeActivityService.onTimeActivityUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.timeactivity.updated.v1.json`);
    json received = boundJsonOf("TimeActivityService.onTimeActivityUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTimeActivityDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.timeactivity.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TimeActivityService.onTimeActivityDeleted"), "TimeActivityService.onTimeActivityDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.timeactivity.deleted.v1.json`);
    json received = boundJsonOf("TimeActivityService.onTimeActivityDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTransferCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.transfer.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TransferService.onTransferCreated"), "TransferService.onTransferCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.transfer.created.v1.json`);
    json received = boundJsonOf("TransferService.onTransferCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTransferUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.transfer.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TransferService.onTransferUpdated"), "TransferService.onTransferUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.transfer.updated.v1.json`);
    json received = boundJsonOf("TransferService.onTransferUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTransferDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.transfer.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TransferService.onTransferDeleted"), "TransferService.onTransferDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.transfer.deleted.v1.json`);
    json received = boundJsonOf("TransferService.onTransferDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testTransferVoidedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.transfer.void.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TransferService.onTransferVoided"), "TransferService.onTransferVoided should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.transfer.void.v1.json`);
    json received = boundJsonOf("TransferService.onTransferVoided");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCompanyCurrencyCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.companycurrency.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyCurrencyService.onCompanyCurrencyCreated"), "CompanyCurrencyService.onCompanyCurrencyCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.companycurrency.created.v1.json`);
    json received = boundJsonOf("CompanyCurrencyService.onCompanyCurrencyCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCompanyCurrencyUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.companycurrency.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyCurrencyService.onCompanyCurrencyUpdated"), "CompanyCurrencyService.onCompanyCurrencyUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.companycurrency.updated.v1.json`);
    json received = boundJsonOf("CompanyCurrencyService.onCompanyCurrencyUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testCompanyCurrencyDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.companycurrency.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyCurrencyService.onCompanyCurrencyDeleted"), "CompanyCurrencyService.onCompanyCurrencyDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.companycurrency.deleted.v1.json`);
    json received = boundJsonOf("CompanyCurrencyService.onCompanyCurrencyDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendor.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorService.onVendorCreated"), "VendorService.onVendorCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendor.created.v1.json`);
    json received = boundJsonOf("VendorService.onVendorCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendor.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorService.onVendorUpdated"), "VendorService.onVendorUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendor.updated.v1.json`);
    json received = boundJsonOf("VendorService.onVendorUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendor.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorService.onVendorDeleted"), "VendorService.onVendorDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendor.deleted.v1.json`);
    json received = boundJsonOf("VendorService.onVendorDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorMergedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendor.merged.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorService.onVendorMerged"), "VendorService.onVendorMerged should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendor.merged.v1.json`);
    json received = boundJsonOf("VendorService.onVendorMerged");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorCreditCreatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendorcredit.created.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorCreditService.onVendorCreditCreated"), "VendorCreditService.onVendorCreditCreated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendorcredit.created.v1.json`);
    json received = boundJsonOf("VendorCreditService.onVendorCreditCreated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorCreditUpdatedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendorcredit.updated.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorCreditService.onVendorCreditUpdated"), "VendorCreditService.onVendorCreditUpdated should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendorcredit.updated.v1.json`);
    json received = boundJsonOf("VendorCreditService.onVendorCreditUpdated");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

@test:Config {}
function testVendorCreditDeletedDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("qbo.vendorcredit.deleted.v1");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("VendorCreditService.onVendorCreditDeleted"), "VendorCreditService.onVendorCreditDeleted should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/qbo.vendorcredit.deleted.v1.json`);
    json received = boundJsonOf("VendorCreditService.onVendorCreditDeleted");
    assertBindsFixture(received, deliveredEvent(received, fixture), "QuickBookEvent");
}

