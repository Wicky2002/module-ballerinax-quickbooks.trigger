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

// Auto-notify on customer creation and merges - a starting point for CRM-sync automation.
// CustomerService declares more remote functions than these two - every one of them must
// still be implemented, even as a no-op, since Ballerina requires a complete implementation
// of the service type.
service quickbooks:CustomerService on webhookListener {

    remote function onCustomerCreated(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("New customer created, notify the sync pipeline", id = payload.intuitentityid,
                realm = payload.intuitaccountid);
    }

    remote function onCustomerMerged(quickbooks:QuickBookEvent payload) returns error? {
        log:printInfo("Customers merged, reconcile downstream records", id = payload.intuitentityid,
                realm = payload.intuitaccountid);
    }

    remote function onCustomerUpdated(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }

    remote function onCustomerDeleted(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }
}
