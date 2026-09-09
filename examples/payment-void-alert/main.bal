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

// A different, financially sensitive domain from the other two examples: alert specifically
// when a payment is voided, since that's the one Payment event worth paging someone over.
service quickbooks:PaymentService on webhookListener {

    remote function onPaymentVoided(quickbooks:QuickBookEvent payload) returns error? {
        log:printWarn("Payment voided, needs a review", id = payload.intuitentityid,
                realm = payload.intuitaccountid);
    }

    remote function onPaymentCreated(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }

    remote function onPaymentUpdated(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }

    remote function onPaymentDeleted(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }

    remote function onPaymentEmailed(quickbooks:QuickBookEvent payload) returns error? {
        return;
    }
}
