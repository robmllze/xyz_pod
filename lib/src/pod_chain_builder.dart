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

class PodChainBuilder extends StatelessWidget {
  //
  //
  //

  final Widget? child;
  final Pod? pod;
  final Pod? Function(dynamic)? chainBuilder;
  final Widget Function(BuildContext, Widget?, Pod?, dynamic)? builder;

  //
  //
  //

  const PodChainBuilder({
    super.key,
    this.pod,
    this.chainBuilder,
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodChainBuilder.value({
    Key? key,
    Pod? pod,
    Widget Function(dynamic)? builder,
    Pod? Function(dynamic)? chainBuilder,
  }) {
    return PodChainBuilder(
      key: key,
      pod: pod,
      chainBuilder: chainBuilder,
      builder: builder != null
          ? (_, __, ___, value) {
              return builder(value);
            }
          : null,
    );
  }
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodBuilder(
      pod: pod,
      builder: (context, widget, value) => _buildChain(context, widget, value),
      child: child,
    );
  }

  //
  //
  //

  Widget _buildChain(BuildContext context, Widget? child, dynamic value) {
    final pod = chainBuilder?.call(value);
    if (pod != null) {
      return PodChainBuilder(
        pod: pod,
        chainBuilder: chainBuilder,
        builder: builder,
        child: child,
      );
    } else {
      return builder?.call(context, child, pod, value) ?? const SizedBox();
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T? letAsOrNull<T>(dynamic value) => value is T ? value : null;
