# Changelog
This file contains all the notable changes done to the Ballerina QuickBooks trigger through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-09-28
### Added
- [Services on the trigger listener are listed by `bal build --export-endpoints`](https://github.com/ballerina-platform/ballerina-library/issues/9312), through a compiler plugin packaged with the trigger. Endpoint export needs Ballerina 2201.13.6 or later; on earlier versions the plugin only warns and the build continues.

### Changed
- [Webhook payloads now bind to the concrete event type instead of the `GenericDataType` union](https://github.com/ballerina-platform/ballerina-library/issues/9218). Binding into a union resolved to the first structurally matching member, so the value handed to a handler was typed by declaration order rather than by which event arrived. The type is read from the handler's own parameter at dispatch time, so no event-to-type table is generated. Binding now happens after the delivery is acknowledged, so a payload that does not fit its handler is logged as `DISPATCH_FAILED` instead of failing the request. An event identifier the spec doesn't declare is acknowledged and logged as a `NO_HANDLER_FOR_EVENT` warning instead of returning an error. A declared event whose service type isn't attached is acknowledged and logged as `SERVICE_NOT_ATTACHED` at debug level. Requires `asyncapi.native.handler` 0.6.0.
- [Generated doc comments are wrapped to the 120-character line budget](https://github.com/ballerina-platform/ballerina-library/issues/9217) instead of being emitted as a single long line.

### Fixed
- The package now includes its `metadata/` folder (trigger metadata and icons). The `Ballerina.toml` template the build writes from was missing `include = ["metadata/**"]`, so builds dropped it; 0.1.0 was published without it.

## [0.1.0] - 2026-09-01
### Added
- Initial release of the QuickBooks trigger as its own package, migrated out of the `asyncapi-triggers` monorepo and rewritten for QuickBooks' CloudEvents webhook format (108 events across 31 entity service types).
