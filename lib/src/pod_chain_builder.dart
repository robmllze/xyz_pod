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

class PodChainBuilder<A, B> extends StatelessWidget {
  //
  //
  //

  final Widget? child;
  final Pod<A>? pod;
  final Pod<B>? Function(A?)? mapper;
  final Widget? Function(BuildContext, Widget?, B?)? builder;

  //
  //
  //

  const PodChainBuilder({
    super.key,
    this.pod,
    this.mapper,
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodChainBuilder.value({
    Key? key,
    Pod<A>? pod,
    Widget Function(B?)? builder,
    Pod<B>? Function(A?)? mapper,
  }) {
    return PodChainBuilder<A, B>(
      key: key,
      pod: pod,
      mapper: mapper,
      builder: builder != null ? (_, __, value) => builder(letAsOrNull(value)) : null,
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
    final pod = mapper?.call(value);
    if (pod is Pod) {
      return PodChainBuilder<dynamic, dynamic>(
        pod: pod,
        mapper: (e) => mapper?.call(letAsOrNull(e)),
        builder: (a, b, c) => builder?.call(a, b, c),
        child: child,
      );
    } else {
      return builder?.call(context, child, value) ?? const SizedBox();
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T? letAsOrNull<T>(dynamic value) => value is T ? value : null;
