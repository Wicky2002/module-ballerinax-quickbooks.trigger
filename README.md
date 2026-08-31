# Ballerina Quickbooks.trigger connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-quickbooks.trigger.svg)](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/quickbooks.trigger.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%quickbooks.trigger)

## Overview

The [Ballerina](https://ballerina.io/) listener for QuickBooks allows you to listen to entity change
events in a QuickBooks Online company, grouped by the accounting object they relate to - 31 entities
in total (Account, Bill, Invoice, Customer, Payment, and more), each exposing the operations that
apply to it (created, updated, deleted, merged, voided, or emailed, depending on the entity). See
[`ballerina/README.md`](ballerina/README.md) for the full list of service types and remote
functions.

This module receives QuickBooks' CloudEvents-formatted webhook notifications directly, batched into
a single delivery when multiple events occur close together - it does not call QuickBooks' own
Accounting API on your behalf, and the notification itself carries only the changed entity's ID, not
its full data.

## Setup guide

Before using this connector in your Ballerina application, you need an Intuit developer account and
app, a QuickBooks sandbox company to generate real events against, and a Ballerina service that
QuickBooks can reach over the internet to deliver webhook payloads to.

1. [Sign up for an Intuit Developer account](https://developer.intuit.com/) and create a new app for
   the QuickBooks Online Accounting API. A sandbox company is created automatically for testing.
2. Set up [ngrok](https://ngrok.com/) (`ngrok http 8090`) to expose your local Ballerina listener.
3. On the app's **Webhooks** tab, set the endpoint URL to your ngrok URL, make sure the payload
   format is **CloudEvents** (not the legacy format), and select the entities you want events for.
4. Retrieve the **Webhook Verifier Token** from the same tab - this is a separate credential from
   your app's OAuth Client Secret, and is the value this connector calls `webhookSecret`.

See [`ballerina/README.md`](ballerina/README.md) for the full step-by-step guide, including
production deployment notes.

### Compatibility

|                               | Version                       |
|-------------------------------|-------------------------------|
| Ballerina Language            | Ballerina Swan Lake 2201.13.0 |

## Quickstart

```ballerina
import ballerinax/quickbooks.trigger as quickbooks;
import ballerina/io;

configurable string webhookSecret = ?;

listener quickbooks:Listener quickbooksWebhook = new ({webhookSecret}, 8090);

service quickbooks:InvoiceService on quickbooksWebhook {
    remote function onInvoiceCreated(quickbooks:QuickBookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onInvoiceUpdated(quickbooks:QuickBookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onInvoiceDeleted(quickbooks:QuickBookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onInvoiceVoided(quickbooks:QuickBookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onInvoiceEmailed(quickbooks:QuickBookEvent payload) returns error? {
        io:println(payload);
    }
}
```

A service attached to a listener's service type must implement **all** of that type's remote
functions - see [`ballerina/README.md`](ballerina/README.md) for the full Quickstart walkthrough.

## Examples

The `quickbooks.trigger` module provides practical examples illustrating usage in various scenarios.
Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/tree/main/examples/),
covering common webhook event handling use cases.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`quickbooks.trigger` package](https://central.ballerina.io/ballerinax/quickbooks.trigger/latest).
* See the [migration notes](docs/migration-notes.md) for context on this package's move from the asyncapi-triggers monorepo and its rewrite for QuickBooks' CloudEvents webhook format.
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.

