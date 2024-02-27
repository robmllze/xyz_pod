//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Pod
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A widget that periodically polls a `Pod<T>` for changes and rebuilds its
/// child widget based on the latest data.
///
/// This widget uses Flutter's frame rendering callbacks to efficiently check
/// for updates to a specified `Pod<T>` instance. It rebuilds its child widget
/// whenever the polled data changes, ensuring the UI remains up-to-date with
/// the latest state of the `Pod<T>`. This approach aligns the polling mechanism
/// with the device's screen refresh rate, providing a responsive and
/// resource-efficient way to reflect changes in the UI.
///
/// The polling process starts when the widget is inserted into the tree and
/// stops when it is removed, automatically managing its lifecycle to avoid
/// unnecessary processing when not visible. This makes `PollingPodBuilder<T>`
/// an ideal solution for applications that require real-time data updates
/// without compromising performance.
///
/// Generic Type:
/// - `T`: The type of data the `Pod` holds, determining the type of data this
///   widget listens for and rebuilds upon changes.
///
/// Example Usage:
/// ```dart
/// PollingPodBuilder<MyDataType>(
///   podPoller: () => myPodInstance,
///   builder: (context, child, data) {
///     return Text(data?.toString() ?? 'Waiting for data...');
///   },
/// )
/// ```
///
/// ### Parameters:
/// - `key`: An optional key to use for the widget.
/// - `podPoller`: A function that returns the `Pod<T>` instance to be polled.
///   This function is called periodically to check for updates.
/// - `builder`: A required function that describes how to build the widget
///   based on the current state of the polled `Pod<T>`.
/// - `placeholderBuilder`: An optional function for creating a placeholder
///   widget when the `Pod<T>` has no data.
/// - `child`: An optional child widget that is passed to the `builder` and
///   `placeholderBuilder` functions, useful for optimization if the child is
///   part of a larger widget that does not need to rebuild.
class PollingPodBuilder<T> extends StatefulWidget {
  //
  //
  //

  /// A function that returns the `Pod<T>?` to be polled.
  final Pod<T>? Function() podPoller;

  //
  //
  //

  /// A function to rebuild the widget based on the data received from
  /// [podPoller].
  final Widget Function(
    BuildContext context,
    Widget? child,
    T? value,
  ) builder;

  //
  //
  //

  /// An optional function to create a placeholder widget when there's no data.
  final Widget? Function(
    BuildContext context,
    Widget? child,
  )? placeholderBuilder;

  //
  //
  //

  /// An optional static child widget that is passed to the [builder] and
  /// [placeholderBuilder].
  final Widget? child;

  //
  //
  //

  /// Creates a `PollingPodBuilder` widget.
  ///
  /// ### Parameters:
  /// - `key`: An optional key to use for the widget.
  /// - `podPoller`: A function that returns the `Pod<T>` instance to be polled.
  ///   This function is called periodically to check for updates.
  /// - `builder`: A required function that describes how to build the widget
  ///   based on the current state of the polled `Pod<T>`.
  /// - `placeholderBuilder`: An optional function for creating a placeholder
  ///   widget when the `Pod<T>` has no data.
  /// - `child`: An optional child widget that is passed to the `builder` and
  ///   `placeholderBuilder` functions, useful for optimization if the child is
  ///   part of a larger widget that does not need to rebuild.
  const PollingPodBuilder({
    super.key,
    required this.podPoller,
    required this.builder,
    this.placeholderBuilder,
    this.child,
  });

  //
  //
  //

  @override
  State<PollingPodBuilder<T>> createState() => _PollingPodBuilderState<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PollingPodBuilderState<T> extends State<PollingPodBuilder<T>> with WidgetsBindingObserver {
  //
  //
  //

  late final Widget? _staticChild = widget.child;

  //
  //
  //

  Pod<T>? _currentPod;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndUpdate());
  }

  //
  //
  //

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //
  //
  //

  void _checkAndUpdate() {
    final tempPod = widget.podPoller();
    if ((_currentPod?.value == null) != (tempPod?.value == null)) {
      setState(() {
        _currentPod = tempPod;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndUpdate());
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodBuilder(
      key: UniqueKey(),
      pod: _currentPod,
      builder: widget.builder,
      placeholderBuilder: widget.placeholderBuilder,
      child: _staticChild,
    );
  }
}
