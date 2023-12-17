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

## [0.1.3]

### Added

- Added a child parameter to the Pods.

### Fixed

- Fixed typos in documentation.
- Addressed package description issues.

## [0.3.2]

### Added

- `PodBuilder.value` constructor and `Pod.build` method.
- `NOTES.md` to the project.

### Changed

- Updated `README.md` and Flutter minimum version to `3.0.0`.
- Updated and renamed `temp_example.dart` to `example_temp.dart`.

### Fixed

- Addressed Flutter PATH issue.
- Fixed example issues in `README.md`.

## [0.4.2]

### Added

- `PodListBuilder.values` and `MultiPodBuilder.values` constructors.

### Fixed

- Minor bug fixes.

## [0.6.1]

### Added

- `PodChainBuilder` for building UIs with a chain of `Pod` objects.
- Improvements to `PodChainBuilder`.

### Changed

- Minor changes.

## [0.7.2]

### Changed

- Default constructors to named constructors (`.def`).
- `.value`/`.values` constructors to default constructors.
- Updated `README.md` and `PodChainBuilder` to `StatefulWidget`.
- All builders can now return `null` for a `SizedBox.shrink()`.

### Removed

- `Pods` and `MultiPodBuilder` classes.
- Commented out `ChainPod` class.

### Fixed

- Typos in `README.md` and type bug with `PodListBuilder`.

## [0.8.0]

### Added

- `singleExecutionListener` method to `Pod`.

## [0.10.4]

### Added

- `PodRemapper` widget and `PodRemapper.first` constructor.

### Removed

- `PodChainBuilder` and replaced with `PodRemapper`.

### Updated

- Default constructors for Pods with context and child parameters.
- `README.md`.
- Simplified the `remap` functions.

## [0.10.5]

### Changed

- Simplified the remappers.

### Removed

- `remap` functions.

## [0.11.1]

### Added

- `PodListHelper` class for managing a list of `Pod` objects.
- `PodWatchListBuilder` widget for building UIs in response to changing pod lists.
- Better examples.

### Updated

- `PodRemapper` was replaced with `PodWatchListBuilder`.
- `README.md`.

## [0.12.1]

### Updated

- Renamed `PodWatchListBuilder` to `PodListRebuilder`.
- Renamed `pods` property to `podList` in `PodBuilder`.
- Renamed `watchListBuilder` property to `podList` in `PodListRebuilder` (previously `PodWatchListBuilder`).
- `README.md`.