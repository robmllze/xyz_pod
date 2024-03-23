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

/// A widget that rebuilds whenever the [Pod] passed to its builder changes.
///
/// ### Parameters:
///
/// - `key`: An optional key to use for the widget.
/// - `child`: An optional child widget that is passed to the `builder` function.
/// - `initialValue`: The initial value for the Pod.
/// - `builder`: A function that is invoked initially and triggers a widget
///   rebuild whenever the provided Pod changes.
class PodWidget<T> extends StatefulWidget {
  //
  //
  //

  /// An optional static child widget that is passed to the [builder].
  final Widget? child;

  //
  //
  //

  /// The initial value for the Pod.
  final T initialValue;

  //
  //
  //

  /// A function that is invoked initially and triggers a widget rebuild
  /// whenever the provided Pod changes.
  final Widget Function(
    BuildContext context,
    Widget? child,
    Pod<T> pod,
  ) builder;

  //
  //
  //

  /// Constructs a `PodWidget` widget.
  ///
  /// ### Parameters:
  ///
  /// - `key`: An optional key to use for the widget.
  /// - `child`: An optional child widget that is passed to the `builder` function.
  /// - `initialValue`: The initial value for the Pod.
  /// - `builder`: A function that is invoked initially and triggers a widget
  ///   rebuild whenever the provided [Pod] changes.
  const PodWidget({
    super.key,
    this.child,
    required this.initialValue,
    required this.builder,
  });

  //
  //
  //

  @override
  _State<T> createState() => _State<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State<T> extends State<PodWidget<T>> {
  //
  //
  //

  late final _pod = Pod<T>.temp(this.widget.initialValue);
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
    return PodBuilder(
      pod: _pod,
      child: _staticChild,
      builder: (context, child, _) => widget.builder(
        context,
        child,
        _pod,
      ),
    );
  }
}
