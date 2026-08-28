# Customer sync notifier

Notifies on `Customer` creation and merges - a starting point for keeping a downstream CRM or
data warehouse in sync with QuickBooks customer records.

## Prerequisites

Complete the [Setup guide](../../ballerina/README.md#setup-guide) in the package README, subscribing
to the `Customer` entity's events, then update `webhookSecret` in `main.bal` (or externalize it via
`Config.toml`) with your Webhook Verifier Token.

## Run the example

```bash
bal run
```

Create or merge a customer in your QuickBooks sandbox company to see the corresponding log line.
