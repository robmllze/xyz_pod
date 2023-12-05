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
///   - `T`: The type of value the `Pod` holds.
class PodBuilder<T> extends StatefulWidget {
  //
  //
  //

  /// The `Pod` object that this builder is listening to.
  /// The builder will be triggered to rebuild whenever this `Pod` notifies its listeners.
  final Pod<T>? pod;

  //
  //
  //

  /// A builder function that is called every time the `Pod`'s value changes.
  /// It takes the current `BuildContext` and the current value of the `Pod`, and returns a `Widget`.
  final Widget Function(BuildContext, T?) builder;

  //
  //
  //

  /// Constructs a `PodBuilder` widget.
  ///
  /// Parameters:
  ///   - `key`: An identifier for this widget in the widget tree.
  ///   - `pod`: The `Pod` object this widget listens to.
  ///   - `builder`: A function that builds the UI based on the `Pod`'s value.
  const PodBuilder({
    Key? key,
    this.pod,
    required this.builder,
  }) : super(key: key);

  //
  //
  //

  @override
  PodBuilderState<T> createState() => PodBuilderState<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class PodBuilderState<T> extends State<PodBuilder<T>> {
  //
  //
  //

  @override
  void initState() {
    super.initState();
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
    // Use the provided builder function to build the widget
    // using the current value of the Pod.
    return widget.builder(context, widget.pod?.value);
  }

  //
  //
  //

  @override
  void dispose() {
    // Remove the listener from the Pod when the widget is disposed.
    widget.pod?.removeListener(_update);
    widget.pod?.disposeIfTemp();
    super.dispose();
  }
}
