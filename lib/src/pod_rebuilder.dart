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

class PodRebuilder<T> extends StatefulWidget {
  //
  //
  //

  final Widget? child;
  final Iterable<Pod> pods;
  final Iterable<PodRemapperFunctions> remappers;
  final Widget? Function(BuildContext, Widget?, Iterable)? builder;

  //
  //
  //

  const PodRebuilder._({
    super.key,
    this.pods = const [],
    this.remappers = const [],
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodRebuilder({
    Key? key,
    Iterable<Pod> pods = const [],
    Iterable<PodRemapperFunctions> remappers = const [],
    Widget? Function(BuildContext, Widget?, Iterable<T> values)? builder,
    Widget? Function(BuildContext, Widget?)? emptyBuilder,
    Widget? child,
  }) {
    return PodRebuilder<T>._(
      key: key,
      pods: pods,
      remappers: remappers,
      builder: builder != null
          ? (context, child, values) {
              final valuesOfType = values.whereType<T>();
              if (valuesOfType.isNotEmpty) {
                return builder(context, child, valuesOfType);
              } else {
                return emptyBuilder?.call(context, child);
              }
            }
          : null,
      child: child,
    );
  }

  //
  //
  //

  factory PodRebuilder.first({
    Key? key,
    Iterable<Pod> pods = const [],
    Iterable<PodRemapperFunctions> remappers = const [],
    Widget? Function(BuildContext, Widget?, T? value)? builder,
    Widget? Function(BuildContext, Widget?)? nullBuilder,
    Widget? child,
  }) {
    return PodRebuilder<T>(
      key: key,
      pods: pods,
      remappers: remappers,
      builder: builder != null
          ? (context, child, values) => builder(context, child, values.firstOrNull)
          : null,
      emptyBuilder: nullBuilder,
      child: child,
    );
  }

  //
  //
  //

  @override
  State<PodRebuilder> createState() => _PodRebuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodRebuilderState extends State<PodRebuilder> {
  //
  //
  //

  late final Widget staticChild;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    staticChild = widget.child ?? const SizedBox.shrink();
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    final pods = widget.pods;
    if (pods.isNotEmpty) {
      return PodListBuilder(
        pods: pods,
        builder: _buildChain,
        child: staticChild,
      );
    } else {
      return staticChild;
    }
  }

  //
  //
  //
  //

  Widget _buildChain(
    BuildContext context,
    Widget? child,
    Iterable values,
  ) {
    final nonNullValues = values.nonNulls;
    if (widget.remappers.isNotEmpty && nonNullValues.isNotEmpty) {
      final remappersCopy = List.of(widget.remappers);
      final pods = <Pod>[];
      final temp = remappersCopy.firstOrNull?.call(nonNullValues).nonNulls ?? [];
      pods.addAll(temp);
      remappersCopy.removeAt(0);
      return PodRebuilder._(
        pods: pods,
        remappers: remappersCopy,
        builder: widget.builder,
        child: staticChild,
      );
    }
    return widget.builder?.call(context, child, values) ?? staticChild;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef PodRemapperFunctions = Iterable<Pod?> Function(Iterable<dynamic>);

extension SecondToFourth<T> on Iterable<T> {
  T get second => elementAt(1);
  T? get secondOrNull => elementAtOrNull(1);
  T get third => elementAt(2);
  T? get thirdOrNull => elementAtOrNull(2);
  T get fourth => elementAt(3);
  T? get fourthOrNull => elementAtOrNull(3);
}
