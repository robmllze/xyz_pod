# Changelog

## [Unreleased]

- Initial planning and design of the project.

## [0.1.0]

### Added

- `Pod` class for flexible state management with notification capabilities.
- `PodBuilder` widget for building UIs in response to `Pod` changes.
- `PodListBuilder` for managing and responding to changes in a list of `Pod` objects.
- `MultiPodBuilder` for handling complex state scenarios with multiple `Pod` objects.
- `Pods` class to encapsulate up to 26 `Pod` objects of different types.
- Comprehensive documentation and examples for each component.
- Unit tests for key functionalities.

## [0.1.1]

### Fixed

- Fixed typos in documentation.

## [0.1.2]

### Fixed

- Addressed "The package description is too short."
- Addressed "lib/src/multi_pod_builder.dart doesn't match the Dart formatter." (no luck!)
- Addressed "llib/src/pods.dart doesn't match the Dart formatter." (no luck!)

## [0.1.3]

### Fixed

- Addressed "The package description is too long."

## [0.2.0]

### Added

- Added a child parameter to the Pods.

## [0.3.0]

### Added

- Added a `PodBuilder.value` constructor.
- Added a `Pod.build` method

## [0.3.1]

### Added

- Added `NOTES.md` to the project.

### Changed

- Changed the `README.md` file.
- Changed Flutter minimum version to `3.0.0`.

### Fixed

- Addressed "Found no Flutter in your PATH. Could not determine the current Flutter version."

## [0.3.2]

### Changed

- Updated `temp_example.dart`.
- Renamed `temp_example.dart` to `example_temp.dart`.

### Fixed

- Fixed issue with example in `README.md`.

## [0.4.0]

### Added

- Added a `PodListBuilder.values` constructor.
- Added a `MultiPodBuilder.values` constructor.

## [0.4.1]

### Fixed

- Minor bug fix.

## [0.4.2]

### Fixed

- Minor bug fix.

## [0.5.0]

### Added

- Added the `PodChainBuilder` for building UIs in response to changes in a chain of `Pod` objects.

## [0.6.0]

### Added

- Improved the `PodChainBuilder`.

## [0.6.1]

### Changed

- Minor changes

## [0.7.0]

### Changed

- Changed all current default constructors to named constructors (`.def`)
- Changed all `.value` or `.values` constructors to default constructors.
- Changed README.md to reflect the changes.
- Changed the `PodChainBuilder` from a `StatelessWidget` to a `StatefulWidget` so that it can auto-dispose its `Pod` objects if they are marked as temp;
- All builders can now return `null` to return a `SizedBox.shrink()` widget.

### Removed

- Removed `Pods` class
- Removed `MultiPodBuilder` class
- Commented out `ChainPod` class since it is not yet ready for release.

## [0.7.1]

### Fixed

- Fixed typos in `README.md`.

## [0.7.2]

### Fixed

- Fixed type bug with `PodListBuilder`.

## [0.8.0]

### Added

- Added a `singleExecutionListener` method to `Pod` which allows for a listener to be executed only once, and then removed.