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

/// `PodListBuilder` is a Flutter widget designed to build and update a UI based
/// on a collection of `Pod` objects. It automatically refreshes the UI when
/// any of the `Pod` objects change, making it great for managing the state of
/// several `Pod` objects together.
class PodListBuilder extends StatefulWidget {
  //
  //
  //

  /// The collection of `Pod` objects that this builder listens to.
  final PodList pods;

  //
  //
  //

  /// An optional child widget that can be used within the [builder] function.
  final Widget? child;

  //
  //
  //

  /// A function that rebuilds the widget every time the data of any of the
  /// [pods] change. It uses the current context, the child widget, and the
  /// current data of the [pods] to create a new widget.
  final Widget? Function(BuildContext, Widget?, Iterable) builder;

  //
  //
  //

  /// Constructs a `PodListBuilder` widget. This widget listenes to a collection
  /// of Pods and rebuilds whenever any of their data changes.
  ///
  /// Parameters:
  /// - `key`: A unique identifier for this widget, used in the widget tree.
  /// - `pods`: A collection of `Pod` objects that this widget will track and
  ///   react to.
  /// - `builder`: A function used to build the widget's UI based on the current
  ///   data from the provided [pods].
  /// - `child`: An optional widget that can be used within the builder
  ///   function.
  const PodListBuilder({
    super.key,
    this.pods = const [],
    required this.builder,
    this.child,
  });

  //
  //
  //

  @override
  State<PodListBuilder> createState() => _PodListBuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodListBuilderState extends State<PodListBuilder> {
  //
  //
  //

  late final Widget? staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    // Initialize the static child widget.
    staticChild = widget.child;

    // Add listeners to each Pod in the list.
    for (final pod in widget.pods) {
      pod?.addListener(_update);
    }
  }

  //
  //
  //

  @override
  void didUpdateWidget(PodListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Remove the update listeners from all the Pods in the old widget. This is
    // necessary because we don't want to listen to changes from Pods that are
    // no longer part of this widget.
    for (final oldPod in oldWidget.pods) {
      oldPod?.removeListener(_update);
    }

    // Add the update listener to all the Pods in the new widget. This ensures
    // that our widget listens to changes in the current set of Pods and updates
    // accordingly.
    for (final newPod in widget.pods) {
      newPod?.addListener(_update);
    }
  }

  //
  //
  //

  /// Internal method to trigger a rebuild of the widget.
  void _update() {
    // Checks if the widget is still in the widget tree before setting state to
    // prevent runtime errors.
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
          staticChild,
          // Get the values of the Pods in the list.
          widget.pods.map((e) => e?.value),
        ) ??
        _fallbackBuilder(context);
  }

  //
  //
  //

  /// Internal method to build a fallback widget when the Pod's value is null.
  Widget _fallbackBuilder(BuildContext context) {
    return staticChild ?? const SizedBox.shrink();
  }

  //
  //
  //

  @override
  void dispose() {
    // Remove listeners from all Pods when the widget is disposed.
    for (final pod in widget.pods) {
      pod?.removeListener(_update);
      pod?.disposeIfMarkedAsTemp();
    }
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef PodList<T extends Object?> = Iterable<Pod<T>?>;

abstract class PodListHelper<T extends Object?> {
  //
  //
  //

  const PodListHelper();
  //
  //
  //

  PodList<T> get pods;

  //
  //
  //

  void dispose() {
    for (final pod in pods) {
      pod?.dispose();
    }
  }

  //
  //
  //

  void disposeIfMarkedAsTemp() {
    for (final pod in pods) {
      pod?.disposeIfMarkedAsTemp();
    }
  }
}
