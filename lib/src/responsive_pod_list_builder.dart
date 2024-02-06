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

import 'package:flutter/widgets.dart';

import '/xyz_pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// `ResponsivePodListBuilder` is a Flutter widget designed to build and update a UI
/// based on a dynamic list of `Pod` objects. Unlike `PodListBuilder`, this
/// widget uses a function to obtain its list of `Pod` objects, allowing for
/// more dynamic and flexible list generation. The UI is automatically refreshed
/// whenever the returned list of `Pod` objects changes, making it highly
/// effective for scenarios where the list of pods is not static.
class ResponsivePodListBuilder extends StatefulWidget {
  //
  //
  //

  /// A function that returns a `PodList`. This function is called to obtain
  /// the current list of `Pod` objects to be watched. Changes in the returned
  /// list will trigger a UI update.
  final TPodListResponder podListResponder;

  //
  //
  //

  /// An optional child widget that can be used within the [builder] function.
  final Widget? child;

  //
  //
  //

  /// A function that rebuilds the widget every time the list returned by the
  /// [podListResponder] changes. It uses the current context, the optional
  /// child widget, and the current data of the `Pod` objects to create a new
  /// widget.
  final Widget? Function(
    BuildContext context,
    Widget? child,
    TPodDataList data,
  ) builder;

  //
  //
  //

  /// Constructs a `ResponsivePodListBuilder` widget. This widget dynamically
  /// generates its list of Pods using the [podListResponder] and rebuild
  ///  whenever the returned list changes.
  ///
  /// Parameters:
  /// - `key`: A unique identifier for this widget within the widget tree.
  /// - `watchListBuilder`: A function returning a list of `Pod` objects for the
  ///   widget to track and react to.
  /// - `builder`: A function used to build the widget's UI based on the current
  ///   data from the `Pod` objects.
  /// - `child`: An optional widget to be used within the [builder].
  const ResponsivePodListBuilder({
    super.key,
    required this.podListResponder,
    required this.builder,
    this.child,
  });

  //
  //
  //

  @override
  State<ResponsivePodListBuilder> createState() =>
      _ResponsivePodListBuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _ResponsivePodListBuilderState extends State<ResponsivePodListBuilder> {
  //
  //
  //

  late final Widget? _staticChild;

  //
  //
  //

  TPodList _currentWatchList = {};

  //
  //
  //

  @override
  void initState() {
    super.initState();
    _staticChild = widget.child;
    _currentWatchList = widget.podListResponder();
    _addListenerToPods(_currentWatchList);
  }

  //
  //
  //

  @override
  void didUpdateWidget(ResponsivePodListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.podListResponder != widget.podListResponder) {
      _removeListenerFromPods(_currentWatchList);
      _currentWatchList = widget.podListResponder();
      _addListenerToPods(_currentWatchList);
    }
  }

  //
  //
  //

  void _addListenerToPods(TPodList pods) {
    for (final pod in pods) {
      pod?.addListener(_update);
    }
  }

  //
  //
  //

  void _removeListenerFromPods(TPodList pods) {
    for (final pod in pods) {
      pod?.removeListener(_update);
    }
  }

  //
  //
  //

  void _update() {
    final newPods = widget.podListResponder();
    _removeListenerFromPods(_currentWatchList);
    _currentWatchList = newPods;
    _addListenerToPods(_currentWatchList);
    if (mounted) {
      setState(() {});
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return widget.builder(
          context,
          _staticChild,
          _currentWatchList.map((pod) => pod?.value),
        ) ??
        _fallbackBuilder(context);
  }

  //
  //
  //

  Widget _fallbackBuilder(BuildContext context) {
    return _staticChild ?? const SizedBox.shrink();
  }

  //
  //
  //

  @override
  void dispose() {
    for (final pod in _currentWatchList) {
      pod?.removeListener(_update);
      pod?.disposeIfMarkedAsTemp();
    }
    super.dispose();
  }
}
