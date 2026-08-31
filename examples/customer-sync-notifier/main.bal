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
