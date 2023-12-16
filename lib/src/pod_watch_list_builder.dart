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

class PodWatchListBuilder extends StatefulWidget {
  //
  //
  //

  final PodWatchList Function() watchListBuilder;

  final Widget? Function(
    BuildContext context,
    Widget? child,
    PodWatchListData data,
  ) builder;

  final Widget? child;

  //
  //
  //

  const PodWatchListBuilder({
    super.key,
    required this.watchListBuilder,
    required this.builder,
    this.child,
  });

  //
  //
  //

  @override
  _PodWatchListBuilderState createState() => _PodWatchListBuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodWatchListBuilderState extends State<PodWatchListBuilder> {
  //
  //
  //

  late final Widget? _staticChild;
  PodWatchList _currentWatchList = {};

  //
  //
  //

  @override
  void initState() {
    super.initState();
    // Initialize the static child widget.
    _staticChild = widget.child;
    _currentWatchList = widget.watchListBuilder();
    _addListenerToPods(_currentWatchList);
  }

  //
  //
  //

  void _addListenerToPods(Map<dynamic, Pod?> pods) {
    for (final pod in pods.values) {
      pod?.addListener(_update);
    }
  }

  //
  //
  //

  void _removeListenerFromPods(Map<dynamic, Pod?> pods) {
    for (final pod in pods.values) {
      pod?.removeListener(_update);
    }
  }

  //
  //
  //

  void _update() {
    final newPods = widget.watchListBuilder();
    _removeListenerFromPods(_currentWatchList);
    _currentWatchList = newPods;
    _addListenerToPods(_currentWatchList);
    if (mounted) {
      setState(() {});
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return widget.builder(
          context,
          _staticChild,
          _currentWatchList.map((key, value) => MapEntry(key, value?.value)),
        ) ??
        _fallbackBuilder(context);
  }

  //
  //
  //

  /// Internal method to build a fallback widget when the Pod's value is null.
  Widget _fallbackBuilder(BuildContext context) {
    return _staticChild ?? const SizedBox.shrink();
  }

  //
  //
  //

  @override
  void dispose() {
    _removeListenerFromPods(_currentWatchList);
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef PodWatchList = Map<dynamic, Pod<dynamic>?>;

typedef PodWatchListData = Map<dynamic, dynamic>;
