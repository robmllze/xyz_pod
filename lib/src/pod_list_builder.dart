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

/// `PodListBuilder` is a StatefulWidget in Flutter that helps in building a widget tree
/// based on a list of `Pod` objects. It listens to changes in these `Pod` objects
/// and rebuilds the widget tree accordingly.
///
/// This widget is useful for managing and responding to the state changes of multiple
/// `Pod` objects within the Flutter UI.
class PodListBuilder extends StatefulWidget {
  //
  //
  //

  /// A list of `Pod` objects. The widget listens to changes in these objects.
  final List<Pod?> pods;

  //
  //
  //

  /// The child widget of this `PodBuilder`.
  final Widget? child;

  //
  //
  //

  /// A builder function that takes the current `BuildContext`, the child `Widget`
  /// and a list of current values of the `pods`. It returns a `Widget` that is
  /// rebuilt every time one of the `Pod` objects notifies its listeners.
  final Widget Function(BuildContext, Widget?, List) builder;

  //
  //
  //

  /// Constructs a `PodListBuilder` widget.
  ///
  /// Parameters:
  ///   - `key`: An identifier for this widget in the widget tree.
  ///   - `pods`: A list of `Pod` objects to listen to.
  ///   - `builder`: A function that builds the UI based on the `pods`.
  const PodListBuilder({
    super.key,
    this.pods = const [],
    this.child,
    required this.builder,
  });

  //
  //
  //

  @override
  PodListBuilderState createState() => PodListBuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class PodListBuilderState extends State<PodListBuilder> {
  //
  //
  //

  @override
  void initState() {
    super.initState();
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
    // Remove listeners from old Pods and add listeners to new Pods.
    for (final oldPod in oldWidget.pods) {
      oldPod?.removeListener(_update);
    }
    for (final newPod in widget.pods) {
      newPod?.addListener(_update);
    }
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
    // Build the widget using the provided builder function.
    return widget.builder(context, widget.child, widget.pods.map((e) => e?.value).toList());
  }

  //
  //
  //

  @override
  void dispose() {
    // Remove listeners from all Pods when the widget is disposed.
    for (final pod in widget.pods) {
      pod?.removeListener(_update);
      pod?.disposeIfTemp();
    }
    super.dispose();
  }
}
