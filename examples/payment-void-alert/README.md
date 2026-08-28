# Payment void alert

A different, financially sensitive domain from the other two examples: alert specifically when a
payment is voided, since that's the one `Payment` event worth flagging for review.

## Prerequisites

Complete the [Setup guide](../../ballerina/README.md#setup-guide) in the package README, subscribing
to the `Payment` entity's events, then update `webhookSecret` in `main.bal` (or externalize it via
`Config.toml`) with your Webhook Verifier Token.

## Run the example

```bash
bal run
```

Void a payment in your QuickBooks sandbox company to see the warning log line.
