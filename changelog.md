# Changelog
This file contains all the notable changes done to the Ballerina QuickBooks trigger through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-09-28
### Added
- [Services on the trigger listener are listed by `bal build --export-endpoints`](https://github.com/ballerina-platform/ballerina-library/issues/9312), through a compiler plugin packaged with the trigger. Endpoint export needs Ballerina 2201.13.6 or later; on earlier versions the plugin only warns and the build continues.

### Changed
- [Webhook payloads now bind to the type of the handler's own parameter](https://github.com/ballerina-platform/ballerina-library/issues/9218) instead of going through `GenericDataType`, which in 0.1.0 was an alias for `QuickBookEvent`. The type is read from the handler at dispatch time, so no event-to-type table is generated. As before, the delivery is acknowledged before binding; a payload that does not fit its handler is logged as `DISPATCH_FAILED`. An event identifier the spec doesn't declare is acknowledged and logged as a `NO_HANDLER_FOR_EVENT` warning instead of returning an error. A declared event whose service type isn't attached is acknowledged and logged as `SERVICE_NOT_ATTACHED` at debug level. Requires `asyncapi.native.handler` 0.6.0.

### Removed
- The public `GenericDataType` type. Code that referred to it should use `QuickBookEvent`, the type it was an alias for.
- [Generated doc comments are wrapped to the 120-character line budget](https://github.com/ballerina-platform/ballerina-library/issues/9217) instead of being emitted as a single long line.

### Fixed
- The package now includes its `metadata/` folder (trigger metadata and icons). The `Ballerina.toml` template the build writes from was missing `include = ["metadata/**"]`, so builds dropped it; 0.1.0 was published without it.

## [0.1.0] - 2026-09-01
### Added
- Initial release of the QuickBooks trigger as its own package, migrated out of the `asyncapi-triggers` monorepo and rewritten for QuickBooks' CloudEvents webhook format (108 events across 31 entity service types).
