import ballerina/log;
import ballerinax/trigger.quickbooks;

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
