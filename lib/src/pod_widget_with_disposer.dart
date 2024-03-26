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

@visibleForTesting
class PodWidgetWithDisposer<T> extends StatefulWidget {
  //
  //
  //

  final Widget? child;

  //
  //
  //

  final T initialValue;

  //
  //
  //

  final PodWidgetResult Function(
    BuildContext context,
    Widget? child,
    Pod<T> pod,
  ) builder;

  //
  //
  //

  const PodWidgetWithDisposer({
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

class _State<T> extends State<PodWidgetWithDisposer<T>> {
  //
  //
  //

  late final _pod = Pod<T>.temp(this.widget.initialValue);
  late final Widget? _staticChild;
  void Function()? resultDispose;

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
    this.resultDispose?.call();
    this.resultDispose = null;
    return PodBuilder(
      pod: _pod,
      child: _staticChild,
      builder: (context, child, _) {
        final result = widget.builder(
          context,
          child,
          _pod,
        );
        this.resultDispose = result.dispose;
        final builder = result.builder;
        return builder?.call(context, child, _pod);
      },
    );
  }

  //
  //
  //

  @override
  void dispose() {
    this.resultDispose?.call();
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class PodWidgetResult<T> {
  //
  //
  //

  final void Function()? dispose;
  final Widget Function(
    BuildContext context,
    Widget? child,
    Pod<T> pod,
  )? builder;

  //
  //
  //

  PodWidgetResult({
    required this.builder,
    this.dispose,
  });
}
