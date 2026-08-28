import ballerina/log;
import ballerinax/trigger.quickbooks;

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
