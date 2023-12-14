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

/// `PodBuilder` is a StatefulWidget in Flutter designed to build a widget tree
/// responsive to changes in a `Pod<T>`. It rebuilds its child widget whenever the
/// `Pod`'s value changes, making it ideal for reactive UI updates.
///
/// Generic Type:
/// - `T`: The type of value the `Pod` holds.
class PodBuilder<P> extends StatefulWidget {
  //
  //
  //

  /// The `Pod` object that this builder is listening to.
  /// The builder will be triggered to rebuild whenever this `Pod` notifies its listeners.
  final Pod<P>? pod;

  //
  //
  //

  /// The child widget of this `PodBuilder`.
  final Widget? child;

  //
  //
  //

  /// A builder function that is called every time the `Pod`'s value changes.
  /// It takes the current `BuildContext`, the child `Widget` and the current
  /// value of the `Pod`, and returns a `Widget`.
  final Widget? Function(BuildContext, Widget?, P)? builder;

  //
  //
  //

  final Widget? Function(BuildContext, Widget?)? placeholderBuilder;

  //
  //
  //

  /// Constructs a `PodBuilder` widget.
  ///
  /// Parameters:
  /// - `key`: An identifier for this widget in the widget tree.
  /// - `pod`: The `Pod` object this widget listens to.
  /// - `builder`: A function that builds the UI based on the `Pod`'s value.
  /// - `child` (optional): A child widget to be passed to the builder function.
  const PodBuilder({
    super.key,
    this.pod,
    this.builder,
    this.placeholderBuilder,
    this.child,
  });

  //
  //
  //

  @override
  State<PodBuilder<P>> createState() => _PodBuilderState<P>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodBuilderState<P> extends State<PodBuilder<P>> {
  //
  //
  //

  late final Widget staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    // Initialize the static child widget
    staticChild = widget.child ?? const SizedBox.shrink();
    // Add a listener to the Pod. The listener calls _update to rebuild the widget.
    widget.pod?.addListener(_update);
  }

  //
  //
  //

  /// Internal method to trigger a rebuild of the widget.
  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    final p = widget.pod?.value;
    if (p is P) {
      return widget.builder?.call(
            context,
            staticChild,
            p,
          ) ??
          widget.placeholderBuilder?.call(
            context,
            staticChild,
          ) ??
          staticChild;
    } else {
      return widget.placeholderBuilder?.call(
            context,
            staticChild,
          ) ??
          staticChild;
    }
  }

  //
  //
  //

  @override
  void dispose() {
    // Remove the listener from the Pod when the widget is disposed.
    widget.pod?.removeListener(_update);
    widget.pod?.disposeIfMarkedAsTemp();
    super.dispose();
  }
}
