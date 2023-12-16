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

/// `PodBuilder` is a special widget for Flutter that automatically calls its
/// [builder] whenever the data in a `Pod<T>` changes.
///
/// Generic Type:
/// - `T`: The type of data the `Pod` has.
class PodBuilder<T> extends StatefulWidget {
  //
  //
  //

  /// The `Pod` that this builder listens to. When the `Pod`'s data changes,
  /// this builder updates its widget.
  final Pod<T>? pod;

  //
  //
  //

  /// An optional child widget that can be passed to this [builder].
  final Widget? child;

  //
  //
  //

  /// A function that rebuilds the widget every time the `Pod`'s data changes.
  /// It uses the current context, the child widget, and the `Pod`'s current
  /// data to create a new widget.
  final Widget? Function(BuildContext, Widget?, T)? builder;

  //
  //
  //

  /// A function to build a placeholder widget. It's used when there's no data
  /// to show.
  final Widget? Function(BuildContext, Widget?)? placeholderBuilder;

  //
  //
  //

  /// Constructs a `PodBuilder` widget. This widget listens to a `Pod` and
  /// rebuilds whenever the `Pod`'s data changes.
  ///
  /// Parameters:
  /// - `key`: A unique identifier for this widget, used in the widget tree.
  /// - `pod`: The `Pod` that this widget will listen to for changes.
  /// - `builder`: A function used to build the widget's UI based on the `Pod`'s
  ///    current data.
  /// - `placeholderBuilder`: A function to create a placeholder widget when
  ///   there's no data.
  /// - `child`: An optional widget that can be used within the builder
  ///   function.
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
  State<PodBuilder<T>> createState() => _PodBuilderState<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodBuilderState<T> extends State<PodBuilder<T>> {
  //
  //
  //

  // This widget is a constant part of the UI and doesn't change with the Pod's
  // data.
  late final Widget staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    // Sets the static child widget. If 'child' is not provided, a default
    // empty space is used.
    staticChild = widget.child ?? const SizedBox.shrink();
    // Registers a listener to the Pod. When the Pod's data changes, '_update'
    // is called to rebuild this widget.
    widget.pod?.addListener(_update);
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
    // Retrieves the current value from the Pod.
    final value = widget.pod?.value;
    if (value is T) {
      // Builds the widget based on the Pod's value. If the value is present,
      // it uses the 'builder' function; otherwise, it falls back to the
      // '_fallbackBuilder'.
      return widget.builder?.call(
            context,
            staticChild,
            value,
          ) ??
          _fallbackBuilder(context);
    } else {
      return _fallbackBuilder(context);
    }
  }

  //
  //
  //

  /// Internal method to build a fallback widget when the Pod's value is null.
  Widget _fallbackBuilder(BuildContext context) =>
      widget.placeholderBuilder?.call(
        context,
        staticChild,
      ) ??
      staticChild;

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
