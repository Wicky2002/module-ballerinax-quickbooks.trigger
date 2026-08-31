# Ballerina Quickbooks.trigger connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-quickbooks.trigger.svg)](https://github.com/ballerina-platform/module-ballerinax-quickbooks.trigger/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/quickbooks.trigger.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%quickbooks.trigger)

## Overview

The [Ballerina](https://ballerina.io/) listener for QuickBooks allows you to listen to entity change events in a QuickBooks Online company, grouped by the accounting object they relate to.

* **Account** (`AccountService`): `onAccountCreated`, `onAccountUpdated`, `onAccountDeleted`, `onAccountMerged`
* **Bill** (`BillService`): `onBillCreated`, `onBillUpdated`, `onBillDeleted`
* **BillPayment** (`BillPaymentService`): `onBillPaymentCreated`, `onBillPaymentUpdated`, `onBillPaymentDeleted`, `onBillPaymentVoided`
* **Budget** (`BudgetService`): `onBudgetCreated`, `onBudgetUpdated`
* **ChangeOrder** (`ChangeOrderService`): `onChangeOrderCreated`, `onChangeOrderUpdated`, `onChangeOrderDeleted`
* **Class** (`ClassService`): `onClassCreated`, `onClassUpdated`, `onClassDeleted`, `onClassMerged`
* **CompanyCurrency** (`CompanyCurrencyService`): `onCompanyCurrencyCreated`, `onCompanyCurrencyUpdated`, `onCompanyCurrencyDeleted`
* **CreditMemo** (`CreditMemoService`): `onCreditMemoCreated`, `onCreditMemoUpdated`, `onCreditMemoDeleted`, `onCreditMemoVoided`, `onCreditMemoEmailed`
* **Currency** (`CurrencyService`): `onCurrencyCreated`, `onCurrencyUpdated`, `onCurrencyDeleted`
* **Customer** (`CustomerService`): `onCustomerCreated`, `onCustomerUpdated`, `onCustomerDeleted`, `onCustomerMerged`
* **Department** (`DepartmentService`): `onDepartmentCreated`, `onDepartmentUpdated`, `onDepartmentMerged`
* **Deposit** (`DepositService`): `onDepositCreated`, `onDepositUpdated`, `onDepositDeleted`
* **Employee** (`EmployeeService`): `onEmployeeCreated`, `onEmployeeUpdated`, `onEmployeeDeleted`, `onEmployeeMerged`
* **Estimate** (`EstimateService`): `onEstimateCreated`, `onEstimateUpdated`, `onEstimateDeleted`, `onEstimateEmailed`
* **Invoice** (`InvoiceService`): `onInvoiceCreated`, `onInvoiceUpdated`, `onInvoiceDeleted`, `onInvoiceVoided`, `onInvoiceEmailed`
* **Item** (`ItemService`): `onItemCreated`, `onItemUpdated`, `onItemDeleted`, `onItemMerged`
* **JournalCode** (`JournalCodeService`): `onJournalCodeCreated`, `onJournalCodeUpdated`
* **JournalEntry** (`JournalEntryService`): `onJournalEntryCreated`, `onJournalEntryUpdated`, `onJournalEntryDeleted`
* **Payment** (`PaymentService`): `onPaymentCreated`, `onPaymentUpdated`, `onPaymentDeleted`, `onPaymentVoided`, `onPaymentEmailed`
* **PaymentMethod** (`PaymentMethodService`): `onPaymentMethodCreated`, `onPaymentMethodUpdated`, `onPaymentMethodMerged`
* **Preferences** (`PreferencesService`): `onPreferencesUpdated`
* **Purchase** (`PurchaseService`): `onPurchaseCreated`, `onPurchaseUpdated`, `onPurchaseDeleted`, `onPurchaseVoided`
* **PurchaseOrder** (`PurchaseOrderService`): `onPurchaseOrderCreated`, `onPurchaseOrderUpdated`, `onPurchaseOrderDeleted`, `onPurchaseOrderEmailed`
* **RefundReceipt** (`RefundReceiptService`): `onRefundReceiptCreated`, `onRefundReceiptUpdated`, `onRefundReceiptDeleted`, `onRefundReceiptVoided`, `onRefundReceiptEmailed`
* **SalesReceipt** (`SalesReceiptService`): `onSalesReceiptCreated`, `onSalesReceiptUpdated`, `onSalesReceiptDeleted`, `onSalesReceiptVoided`, `onSalesReceiptEmailed`
* **TaxAgency** (`TaxAgencyService`): `onTaxAgencyCreated`, `onTaxAgencyUpdated`
* **Term** (`TermService`): `onTermCreated`, `onTermUpdated`
* **TimeActivity** (`TimeActivityService`): `onTimeActivityCreated`, `onTimeActivityUpdated`, `onTimeActivityDeleted`
* **Transfer** (`TransferService`): `onTransferCreated`, `onTransferUpdated`, `onTransferDeleted`, `onTransferVoided`
* **Vendor** (`VendorService`): `onVendorCreated`, `onVendorUpdated`, `onVendorDeleted`, `onVendorMerged`
* **VendorCredit** (`VendorCreditService`): `onVendorCreditCreated`, `onVendorCreditUpdated`, `onVendorCreditDeleted`

This module receives QuickBooks' CloudEvents-formatted webhook notifications directly, batched into
a single delivery when multiple events occur close together - it does not call QuickBooks' own
Accounting API on your behalf, and the notification itself carries only the changed entity's ID, not
its full data (QuickBooks webhooks are notification-only by design; fetch the entity separately via
the Accounting API if you need its contents).

## Setup guide

Before using this connector in your Ballerina application, you need an Intuit developer account and
app, a QuickBooks sandbox company to generate real events against, and a Ballerina service that
QuickBooks can reach over the internet to deliver webhook payloads to. The two sections below cover
both a quick local test setup and a production deployment.

### Try it out locally

Use this flow to test your webhook handling logic on your own machine before deploying anywhere,
using [ngrok](https://ngrok.com/) to expose your local listener to the internet.

#### Step 1: Create an Intuit Developer Account and App

1. [Sign up for an Intuit Developer account](https://developer.intuit.com/) if you don't already have one.
2. Create a new app from the developer dashboard, selecting the QuickBooks Online Accounting API.
3. Under **Sandbox**, note the sandbox company QuickBooks creates automatically for your app - this
   is where you'll trigger real test events (creating/updating/deleting invoices, customers, etc.).

#### Step 2: Set Up ngrok

The Ballerina listener runs locally and needs a publicly accessible URL so QuickBooks can deliver
webhook events to it. [ngrok](https://ngrok.com/) creates a secure tunnel from a public URL to your
local service.

Install ngrok and start a tunnel on port `8090` (the default port for the Ballerina listener):

```sh
ngrok http 8090
```

Copy the HTTPS forwarding URL from the ngrok terminal output. It looks like:

```text
https://xxxx-xxx-xxx-xxx.ngrok-free.app
```

> **Save this value** - you will need the ngrok URL when configuring the webhook endpoint below and
> in the Quickstart section.

#### Step 3: Configure the Webhook Endpoint and Subscribe to Entities

1. On your app's page in the developer dashboard, go to the **Webhooks** tab.
2. Set the **Endpoint URL** to your ngrok URL from Step 2.
3. Make sure the payload format is set to **CloudEvents** rather than the legacy format - QuickBooks
   is retiring the legacy envelope, and this connector only supports CloudEvents (see
   `docs/spec/sanitations.md` for why).
4. Select the entities you want to receive events for (Invoice, Customer, Bill, etc.) - each entity
   expands to show the specific operations available for it (created, updated, deleted, and so on
   depending on the entity).
5. Save the configuration.

#### Step 4: Retrieve the Webhook Verifier Token

QuickBooks signs webhook deliveries using a **Webhook Verifier Token**, which is a separate
credential from your app's OAuth **Client Secret** - don't confuse the two, they aren't
interchangeable.

1. On the same **Webhooks** tab, click **Show verifier token** (or equivalent) next to your
   configured endpoint.
2. Copy the verifier token.

> **Save this value** - you will need it in the Quickstart section when initialising the Ballerina
> listener. This is the value the listener calls `webhookSecret`.

### Production / business integration

The steps above use ngrok's temporary URL, which is fine for local testing but not for a real
deployment. For production use:

1. Deploy your Ballerina service somewhere with a stable, internet-reachable HTTPS URL. Ballerina
   doesn't require any specific hosting platform - containers, a VM, a managed PaaS, or anything
   else that gives you a stable HTTPS endpoint all work equally well.

2. In the app's **Webhooks** tab (Step 3), set the **Endpoint URL** to your production URL instead
   of the ngrok URL.

3. Rather than hardcoding `webhookSecret` as shown in the Quickstart, inject it via `Config.toml`
   (or your platform's equivalent configuration/secret mechanism), since it's a `configurable`
   value.

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

