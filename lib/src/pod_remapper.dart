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
  final PodRemappers remappers;
  final Widget? Function(BuildContext, Widget?, Iterable)? builder;

  //
  //
  //

  const PodRemapper._({
    super.key,
    this.pods = const [],
    this.remappers = const {},
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodRemapper({
    Key? key,
    Iterable<Pod?> pods = const [],
    PodRemappers remappers = const {},
    Widget? Function(BuildContext, Widget?, Iterable<T> values)? builder,
    Widget? Function(BuildContext, Widget?)? emptyBuilder,
    Widget? child,
  }) {
    return PodRemapper<T>._(
      key: key,
      pods: pods.nonNulls,
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

  factory PodRemapper.first({
    Key? key,
    Iterable<Pod?> pods = const [],
    PodRemappers remappers = const {},
    Widget? Function(BuildContext, Widget?, T value)? builder,
    Widget? Function(BuildContext, Widget?)? nullBuilder,
    Widget? child,
  }) {
    return PodRemapper<T>(
      key: key,
      pods: pods.nonNulls,
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
    final oldMappers = Map.fromEntries(widget.remappers);
    final newMappers = Map.of(oldMappers);
    List<Pod<dynamic>> pods = [];
    if (oldMappers.isNotEmpty) {
      for (final value in values) {
        final type = value.runtimeType;
        final temp = oldMappers[type]?.call(value);
        if (temp != null) {
          newMappers.remove(type);
          pods.addAll(temp);
        }
      }
      return PodRemapper._(
        pods: pods,
        remappers: newMappers.entries,
        builder: widget.builder,
        child: staticChild,
      );
    } else {
      return widget.builder?.call(context, child, values) ?? staticChild;
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef PodChainFunctions = Iterable<Pod<dynamic>> Function(dynamic);

typedef PodRemappers = Iterable<MapEntry<Type, PodChainFunctions>>;

MapEntry<Type, PodChainFunctions> remap<T, A>(Iterable<Pod<A>> Function(T) f) {
  return MapEntry(T, (dynamic a) => f(a as T));
}

MapEntry<Type, PodChainFunctions> remapSingle<T, A>(Pod<A> Function(T) f) {
  return remap<T, A>((a) => [f(a)]);
}

MapEntry<Type, PodChainFunctions> remapMultiple<T, A>(Iterable<Pod<A>> Function(T) f) {
  return remap<T, A>(f);
}
