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

import 'dart:async';

import 'package:flutter/widgets.dart';

import '/xyz_pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// The `PollingPodBuilder` widget periodically polls a `Pod<T>` instance until it
/// receives a non-null pod and rebuilds its UI based on the polled data.
///
/// Generic Type:
/// - `T`: The type of data the `Pod` holds.
class PollingPodBuilder<T> extends StatefulWidget {
  //
  //
  //

  /// A function that returns the `Pod` instance to be polled.
  final Pod<T>? Function() podPoller;

  //
  //
  //

  /// A function that rebuilds the widget based on the polled data.
  final Widget Function(
    BuildContext context,
    Widget? child,
    T? value,
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

  /// An optional child widget that can be used within the [builder] function.
  final Widget? child;

  //
  //
  //

  /// The interval between each poll operation.
  final Duration pollingInterval;

  /// Creates a `PollingPodBuilder` widget.
  ///
  /// Parameters:
  /// - `key`: A unique identifier for this widget in the widget tree.
  /// - `poll`: A function to poll the `Pod` for data.
  /// - `builder`: A function to rebuild the widget based on the polled data.
  /// - `placeholderBuilder`: A function to create a placeholder widget when
  ///   there's no data.
  /// - `pollingInterval`: The interval between each poll operation. Defaults to zero.
  /// - `child`: An optional widget used within the [builder] function.
  const PollingPodBuilder({
    super.key,
    required this.podPoller,
    required this.builder,
    this.placeholderBuilder,
    this.pollingInterval = Duration.zero,
    this.child,
  });

  //
  //
  //

  @override
  State<PollingPodBuilder<T>> createState() => _PollingPodBuilderState<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PollingPodBuilderState<T> extends State<PollingPodBuilder<T>> {
  //
  //
  //

  late final Widget? _staticChild = widget.child;

  //
  //
  //

  Timer? _pollTimer;
  late Pod<T>? _currentPod = widget.podPoller();

  //
  //
  //

  @override
  void initState() {
    super.initState();
    if (_currentPod == null) {
      _startPolling();
    }
  }

  //
  //
  //

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }

  //
  //
  //

  void _startPolling() {
    _pollTimer = Timer.periodic(widget.pollingInterval, (timer) {
      _currentPod = widget.podPoller();
      if (_currentPod != null) {
        timer.cancel();
        setState(() {});
      }
    });
  }

  //
  //
  //

  void _stopPolling() {
    _pollTimer?.cancel();
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodBuilder(
      key: ValueKey(_currentPod == null),
      pod: _currentPod,
      builder: widget.builder,
      placeholderBuilder: widget.placeholderBuilder,
      child: _staticChild,
    );
  }
}
