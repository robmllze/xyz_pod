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

/// `PodListBuilder` is a Flutter widget designed to build and update a UI based
/// on a list of `Pod` objects. It automatically refreshes the UI when any of
/// the `Pod` objects change, making it great for managing the state of several
/// `Pod` objects together.
class PodListBuilder extends StatefulWidget {
  //
  //
  //

  /// The list of `Pod` objects that this builder listens to.
  final TPodList podList;

  //
  //
  //

  /// An optional child widget that can be used within the [builder] function.
  final Widget? child;

  //
  //
  //

  /// A function that rebuilds the widget every time the data of any of the
  /// [podList] change. It uses the current context, the child widget, and the
  /// current data of the [podList] to create a new widget.
  final Widget? Function(
    BuildContext context,
    Widget? child,
    TPodDataList data,
  ) builder;

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

  /// Constructs a `PodListBuilder` widget. This widget listenes to a list
  /// of Pods and rebuilds whenever any of their data changes.
  ///
  /// ### Parameters:
  /// - `key`: A unique identifier for this widget, used in the widget tree.
  /// - `pods`: A list of `Pod` objects that this widget will track and
  ///   react to.
  /// - `builder`: A function used to build the widget's UI based on the current
  ///   data from the provided [podList].
  /// - `placeholderBuilder`: A function to create a placeholder widget when
  ///   there's no data.
  /// - `child`: An optional widget that can be used within the [builder].
  const PodListBuilder({
    super.key,
    required this.podList,
    required this.builder,
    this.placeholderBuilder,
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

  late final Widget? _staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    _staticChild = widget.child;
    _addListenerToPods(widget.podList);
  }

  //
  //
  //

  @override
  void didUpdateWidget(PodListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _removeListenerFromPods(oldWidget.podList);
    _addListenerToPods(widget.podList);
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
    if (mounted) {
      setState(() {});
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    final values = widget.podList.map((e) => e?.value);
    if (values.nonNulls.isEmpty && widget.placeholderBuilder != null) {
      return _fallbackBuilder(context);
    } else {
      return widget.builder(
            context,
            _staticChild,
            values,
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
    for (final pod in widget.podList) {
      pod?.removeListener(_update);
      pod?.disposeIfMarkedAsTemp();
    }
    super.dispose();
  }
}
