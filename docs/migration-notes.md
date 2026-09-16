# Migration notes: moved from the asyncapi-triggers monorepo, rewritten for CloudEvents

This is the first release of `quickbooks.trigger` as its own repository, migrated out of
`ballerina-platform/asyncapi-triggers`. Unlike some other triggers migrated the same way, this
wasn't a straight move — the spec (`docs/spec/asyncapi.yaml`) was rewritten from scratch to target
QuickBooks' new CloudEvents-based webhook format instead of the legacy `eventNotifications`
envelope. See `docs/spec/sanitations.md` for the full list of spec changes and
`ballerina-platform/ballerina-library#9079` for the investigation that drove them.

## Why the rewrite, not just a move

Intuit is retiring the legacy webhook envelope entirely in favor of CloudEvents (a CNCF standard).
The stated migration deadline has already passed as of this release, and per Intuit's own migration
guide, apps that can't parse the new format now have events dropped or misrouted, silently. The old
monorepo spec also had a pre-existing bug (its payload schema didn't actually match the envelope its
own event-identifier configuration expected), so a straight move would have shipped a trigger that
neither matched reality nor even compiled cleanly.

## What changed from the old monorepo spec

- Payload schema rewritten as a real CloudEvents envelope (`specversion`, `id`, `source`, `type`,
  `datacontenttype`, `time`, `intuitentityid`, `intuitaccountid`, `data`).
- Every one of the 108 generated events' identifying string is the real, confirmed wire-format value
  (e.g. `qbo.customer.created.v1`), not inferred from a naming pattern.
- Two entities added that weren't in the old spec at all: `ChangeOrder` and `CompanyCurrency`.
- A sixth operation category, `emailed`, added — not modeled in the old spec (`created`, `updated`,
  `deleted`, `merged`, `void` were the only ones before).
- Webhook signature verification and batched-delivery support added (`x-ballerina-auth`, and
  wrapping the payload as `type: array` so the generator detects batching structurally) — the old
  spec had neither, so any POST claiming to be from QuickBooks was previously dispatched unchecked,
  and only the first event of a batched delivery was ever processed.

## Known gap

Only 2 of the 6 operation categories (`created`, `merged`) have a real-data-confirmed `data` field
shape on the CloudEvents payload. The rest use a documented placeholder in the test fixtures pending
more real captures — see `ballerina/tests/resources/trigger_payloads/PROVENANCE.md`.
