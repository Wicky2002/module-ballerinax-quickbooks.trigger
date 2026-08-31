# Examples

The `ballerinax/quickbooks.trigger` connector provides practical examples illustrating usage in various scenarios.

1. [Invoice lifecycle logger](invoice-lifecycle-logger) - the minimal, canonical use case: log every `Invoice` lifecycle event.
2. [Customer sync notifier](customer-sync-notifier) - notify on customer creation and merges, a starting point for CRM-sync automation.
3. [Payment void alert](payment-void-alert) - a different, financially sensitive case: alert specifically when a payment is voided.

## Prerequisites

Complete the [Setup guide](../ballerina/README.md#setup-guide) in the package README first - each
example needs a QuickBooks app with a webhook subscribed to the events it listens for.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
