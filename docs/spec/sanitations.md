_Author_:  Dinuka Wickramasinghe \
_Created_: 2026-08-28 \
_Updated_: 2026-08-28 \
_Edition_: Swan Lake

# Sanitation for AsyncAPI specification

This document records the sanitation done on top of the AsyncAPI specification for the QuickBooks trigger (`asyncapi.yaml`, this directory). Unlike a client connector, this package is a webhook *trigger* (an inbound listener) generated from an AsyncAPI spec, not an OpenAPI client spec — the spec describes the webhook events QuickBooks delivers, not a REST API this package calls out to.

1. Rewrote the payload schema and every message's `x-ballerina-event-type` value to target CloudEvents (a CNCF standard) instead of QuickBooks' legacy `eventNotifications` envelope. Intuit is retiring the legacy envelope entirely, and per Intuit's own migration guide, apps that can't parse CloudEvents now have events dropped or misrouted silently — the migration deadline has already passed as of when this spec was written. See `ballerina-platform/ballerina-library#9079` for the full investigation, including a pre-existing schema bug in the legacy-envelope version of this spec that made the point moot regardless.
2. Every message's `x-ballerina-event-type` value is the exact, real wire-format string (e.g. `qbo.customer.created.v1`), pulled directly from the QuickBooks developer portal's webhook subscription page rather than inferred from a pattern — this also surfaced two entities not previously in the spec (`ChangeOrder`, `CompanyCurrency`) and a sixth operation category, `emailed`, not modeled before.
3. Added an `x-ballerina-auth` block. QuickBooks signs webhook deliveries with `Intuit-Signature`: HMAC-SHA256 over the raw request body, base64-encoded — confirmed empirically against a captured live webhook delivery and unchanged between the legacy and CloudEvents formats.
4. Wrapped every message's `payload` as `type: array` with an `items` schema, instead of a bare `$ref`. CloudEvents delivers a top-level JSON array (potentially containing events for more than one QuickBooks company in a single request) rather than one event per request; the generator detects this batched delivery shape directly from the array-typed payload schema (`ballerina-platform/ballerina-library#9058`) and dispatches each array element independently.
5. Added `x-ballerina-event-label` to every message. Deriving the generated function name directly from the real wire-format `x-ballerina-event-type` value produced awkward names, since CloudEvents type strings carry a required `qbo.`/`.v1` prefix/suffix that has no naming value (e.g. `onQboAccountMergedV1`). This field lets the generator build a clean name (`onAccountMerged`) independently of the value actually used to match incoming payloads — see the companion `asyncapi-tools` change that added support for this field.
6. Only 2 of the 6 operation categories (`created`, `merged`) have a real-data-confirmed `data` field shape on the CloudEvents payload; the rest use a placeholder pending more real captures — see `ballerina/tests/resources/trigger_payloads/PROVENANCE.md` for exactly what's confirmed versus synthetic in the test fixtures.

## Ballerina trigger generation

The Ballerina trigger source (`listener.bal`, `dispatcher_service.bal`, `service_types.bal`, `types.bal`) is generated from `asyncapi.yaml` using the `asyncapi-tools` generator (`ballerina-platform/asyncapi-tools`). The command should be executed from the repository root directory.

```bash
bal asyncapi http -i docs/spec/asyncapi.yaml -o ballerina/
```

This overwrites `listener.bal`, `dispatcher_service.bal`, `service_types.bal`, and the data-types file in `ballerina/` with fresh output. Diff the result before committing - anything currently correct only because of a hand patch to these files (rather than to the spec or the generator itself) will be silently reverted by this command.
