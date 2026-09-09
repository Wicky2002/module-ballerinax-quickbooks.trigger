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

import ballerina/log;
import ballerinax/quickbooks.trigger as quickbooks;

configurable quickbooks:ListenerConfig config = {
    webhookSecret: "xxxxxx"
};

listener quickbooks:Listener webhookListener = new (config, 8090);

// The minimal, canonical use case: log every Invoice lifecycle event.
service quickbooks:InvoiceService on webhookListener {

    remote function onInvoiceCreated(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Invoice created", id = payload.intuitentityid, realm = payload.intuitaccountid);
    }

    remote function onInvoiceUpdated(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Invoice updated", id = payload.intuitentityid, realm = payload.intuitaccountid);
    }

    remote function onInvoiceDeleted(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Invoice deleted", id = payload.intuitentityid, realm = payload.intuitaccountid);
    }

    remote function onInvoiceVoided(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Invoice voided", id = payload.intuitentityid, realm = payload.intuitaccountid);
    }

    remote function onInvoiceEmailed(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Invoice emailed", id = payload.intuitentityid, realm = payload.intuitaccountid);
    }
}
