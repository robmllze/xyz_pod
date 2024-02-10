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

  /// The `Pod` that this builder listens to.
  final Pod<T>? pod;

  //
  //
  //

  /// An optional child widget that can be used within the [builder] function.
  final Widget? child;

  //
  //
  //

  /// A function that rebuilds the widget every time the data of the [pod]
  /// changes. It uses the current context, the child widget, and the current
  /// [pod] data to create a new widget.å
  final Widget? Function(
    BuildContext context,
    Widget? child,
    T data,
  )? builder;

  //
  //
  //

  /// A function to build a placeholder widget. It's used when there's no data
  /// to show.
  final Widget? Function(
    BuildContext context,
    Widget? child,
  )? placeholderBuilder;

  //
  //
  //

  /// Creates a `PodBuilder` widget. This widget listens to a `Pod` and
  /// rebuilds whenever the `Pod`'s data changes.
  ///
  /// Parameters:
  /// - `key`: A unique identifier for this widget, used in the widget tree.
  /// - `pod`: The `Pod` that this widget will listen to for changes.
  /// - `builder`: A function used to build the widget's UI based on the current
  ///   data from the provided [pod].
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

  late final Widget? _staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    _staticChild = widget.child;
    widget.pod?.addListener(_update);
  }

  //
  //
  //

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
    final value = widget.pod?.value;
    if (value == null) {
      return _fallbackBuilder(context);
    } else {
      return widget.builder?.call(
            context,
            _staticChild,
            value,
          ) ??
          _fallbackBuilder(context);
    }
  }

  //
  //
  //

  Widget _fallbackBuilder(BuildContext context) {
    return widget.placeholderBuilder?.call(
          context,
          _staticChild,
        ) ??
        _staticChild ??
        const SizedBox.shrink();
  }

  //
  //
  //

  @override
  void dispose() {
    widget.pod?.removeListener(_update);
    widget.pod?.disposeIfMarkedAsTemp();
    super.dispose();
  }
}
