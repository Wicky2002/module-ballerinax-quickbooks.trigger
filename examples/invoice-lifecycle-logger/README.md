# Invoice lifecycle logger

Logs every `Invoice` lifecycle event (created, updated, deleted, voided, emailed) as it arrives -
the minimal, canonical use case for the `quickbooks.trigger` listener.

## Prerequisites

Complete the [Setup guide](../../ballerina/README.md#setup-guide) in the package README, subscribing
to the `Invoice` entity's events, then update `webhookSecret` in `main.bal` (or externalize it via
`Config.toml`) with your Webhook Verifier Token.

## Run the example

```bash
bal run
```

Create, update, delete, void, or email an invoice in your QuickBooks sandbox company to see the
corresponding log line.
