//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A widget that listens to a list of [Pod] instances and rebuilds whenever
/// any of their values/states change.
///
/// ### Parameters:
///
/// - `key`: An optional key to use for the widget.
/// - `podList`: The list of `Pod` objects that this builder listens to.
/// - `builder`: A function that rebuilds the widget based on the current
///   states of the observed Pods. It receives the build context, the optional
///   `child` widget, and the valued from the observed `podList`.
/// - `placeholderBuilder`: An optional function to create a placeholder widget
///   when there's no data.
/// - `child`: An optional child widget that is passed to the `builder` and
///   `placeholderBuilder` functions, useful for optimization if the child is
///   part of a larger widget that does not need to rebuild.
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

  /// A function to rebuild the widget based on the data received from
  /// [podList].
  final Widget? Function(
    BuildContext context,
    Widget? child,
    TPodDataList data,
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

  /// Creates a `PodListBuilder` widget.
  ///
  /// ### Parameters:
  ///
  /// - `key`: An optional key to use for the widget.
  /// - `podList`: The list of `Pod` objects that this builder listens to.
  /// - `builder`: A function that rebuilds the widget based on the current
  ///   states of the observed Pods. It receives the build context, the optional
  ///   `child` widget, and the valued from the observed `podList`.
  /// - `placeholderBuilder`: An optional function to create a placeholder widget
  ///   when there's no data.
  /// - `child`: An optional child widget that is passed to the `builder` and
  ///   `placeholderBuilder` functions, useful for optimization if the child is
  ///   part of a larger widget that does not need to rebuild.
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
