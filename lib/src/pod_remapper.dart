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

class PodRemapper<T> extends StatefulWidget {
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

  const PodRemapper._({
    super.key,
    this.pods = const [],
    this.remappers = const [],
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodRemapper({
    Key? key,
    Iterable<Pod> pods = const [],
    Iterable<PodRemapperFunctions> remappers = const [],
    Widget? Function(BuildContext, Widget?, Iterable<T> values)? builder,
    Widget? Function(BuildContext, Widget?)? emptyBuilder,
    Widget? child,
  }) {
    return PodRemapper<T>._(
      key: key,
      pods: pods.nonNulls,
      remappers: remappers.nonNulls,
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

  factory PodRemapper.first({
    Key? key,
    Iterable<Pod> pods = const [],
    Iterable<PodRemapperFunctions> remappers = const [],
    Widget? Function(BuildContext, Widget?, T value)? builder,
    Widget? Function(BuildContext, Widget?)? nullBuilder,
    Widget? child,
  }) {
    return PodRemapper<T>(
      key: key,
      pods: pods,
      remappers: remappers,
      builder: builder != null
          ? (context, child, values) => builder(context, child, values.first)
          : null,
      emptyBuilder: nullBuilder,
      child: child,
    );
  }

  //
  //
  //

  @override
  State<PodRemapper> createState() => _PodRemapperState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodRemapperState extends State<PodRemapper> {
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
    if (widget.remappers.isNotEmpty && values.isNotEmpty) {
      final remappersCopy = List.of(widget.remappers);
      final pods = <Pod<dynamic>>[];
      for (final value in values) {
        if (value == null) return staticChild;
        final temp = remappersCopy.first.call(value);
        pods.addAll(temp);
        remappersCopy.removeAt(0);
        if (remappersCopy.isEmpty) break;
      }
      return PodRemapper._(
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

typedef PodRemapperFunctions = Iterable<Pod> Function(dynamic);
