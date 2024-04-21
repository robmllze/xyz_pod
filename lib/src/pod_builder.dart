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

/// A widget that listens to a [Pod] and rebuilds whenever the Pod's value/state
/// changes.
///
/// ### Parameters:
///
/// - `key`: An optional key to use for the widget.
/// - `pod`: The Pod that this builder listens to.
/// - `builder`: A function that rebuilds the widget based on the current
///   state of the observed Pod. It receives the build context, the optional
///   `child` widget, and the value from the observed `pod`.
/// - `fallbackBuilder`: An optional function to create a fallback widget
///   when there's no data.
/// - `child`: An optional child widget that is passed to the `builder` and
///   `fallbackBuilder` functions, useful for optimization if the child is
///   part of a larger widget that does not need to rebuild.
/// - `onDispose`: An optional function to call when the widget is disposed.
class PodBuilder<T> extends StatefulWidget {
  //
  //
  //

  /// The Pod that this builder listens to.
  final Pod<T>? pod;

  //
  //
  //

  /// A function to rebuild the widget based on the data received from
  /// [pod].
  final Widget? Function(
    BuildContext context,
    Widget? child,
    T? data,
  )? builder;

  //
  //
  //

  /// An optional function to create a fallback widget when there's no data.
  final Widget? Function(
    BuildContext context,
    Widget? child,
  )? fallbackBuilder;

  //
  //
  //

  /// An optional static child widget that is passed to the [builder] and
  /// [fallbackBuilder].
  final Widget? child;

  //
  //
  //

  /// An optional function to call when the widget is disposed.
  final void Function()? onDispose;

  //
  //
  //

  /// Constructs a `PodBuilder` widget.
  ///
  /// ### Parameters:
  ///
  /// - `key`: An optional key to use for the widget.
  /// - `pod`: The Pod that this builder listens to.
  /// - `builder`: A function that rebuilds the widget based on the current
  ///   state of the observed Pod. It receives the build context, the optional
  ///   `child` widget, and the value from the observed `pod`.
  /// - `fallbackBuilder`: An optional function to create a fallback widget
  ///   when there's no data.
  /// - `child`: An optional child widget that is passed to the `builder` and
  ///   `fallbackBuilder` functions, useful for optimization if the child is
  ///   part of a larger widget that does not need to rebuild.
  /// - `onDispose`: An optional function to call when the widget is disposed.
  const PodBuilder({
    super.key,
    this.pod,
    this.builder,
    this.fallbackBuilder,
    this.child,
    this.onDispose,
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

      return widget.builder?.call(
            context,
            _staticChild,
            value,
          ) ??
          _fallbackBuilder(context);
    
  }

  //
  //
  //

  Widget _fallbackBuilder(BuildContext context) {
    return widget.fallbackBuilder?.call(
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
    widget.onDispose?.call();
    super.dispose();
  }
}
