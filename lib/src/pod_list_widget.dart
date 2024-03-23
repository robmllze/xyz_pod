//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A widget that rebuilds whenever any of the [Pod]s passed to its builder
/// changes.
///
/// ### Parameters:
///
/// - `key`: An optional key to use for the widget.
/// - `child`: An optional child widget that is passed to the `builder` function.
/// - `initialValues`: The initial values for the Pods.
/// - `builder`: A function that is invoked initially and triggers a widget
///   rebuild whenever any of the provided Pods change.
class PodListWidget extends StatefulWidget {
  //
  //
  //

  /// An optional static child widget that is passed to the [builder].
  final Widget? child;

  //
  //
  //

  /// The initial value for the Pod.
  final Iterable initialValues;

  //
  //
  //

  /// A function that is invoked initially and triggers a widget rebuild
  /// whenever any of the provided Pods change.
  final Widget Function(
    BuildContext context,
    Widget? child,
    Iterable<Pod> podList,
  ) builder;

  //
  //
  //

  /// Constructs a `PodListWidget` widget.
  ///
  /// ### Parameters:
  ///
  /// - `key`: An optional key to use for the widget.
  /// - `child`: An optional child widget that is passed to the `builder` function.
  /// - `initialValues`: The initial values for the Pods.
  /// - `builder`: A function that is invoked initially and triggers a widget
  ///   rebuild whenever any of the provided Pods change.
  const PodListWidget({
    super.key,
    this.child,
    required this.initialValues,
    required this.builder,
  });

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<PodListWidget> {
  //
  //
  //

  late final _podList = this.widget.initialValues.map((e) => Pod.temp(e));
  late final Widget? _staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    _staticChild = this.widget.child;
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodListBuilder(
      podList: _podList,
      child: _staticChild,
      builder: (context, child, _) => widget.builder(
        context,
        child,
        _podList,
      ),
    );
  }
}
