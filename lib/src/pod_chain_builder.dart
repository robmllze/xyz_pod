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

class PodChainBuilder<A, B> extends StatefulWidget {
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

  const PodChainBuilder.def({
    super.key,
    this.pod,
    this.mapper,
    this.builder,
    this.child,
  });

  //
  //
  //

  factory PodChainBuilder({
    Key? key,
    Pod<A>? pod,
    Pod<B>? Function(A?)? mapper,
    Widget? Function(B?)? builder,
  }) {
    return PodChainBuilder<A, B>.def(
      key: key,
      pod: pod,
      mapper: mapper,
      builder: builder != null
          ? (_, __, value) => builder(_letAsOrNull(value))
          : null,
    );
  }

  //
  //
  //

  @override
  State<PodChainBuilder<A, B>> createState() => _PodChainBuilderState<A, B>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _PodChainBuilderState<A, B> extends State<PodChainBuilder<A, B>> {
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodBuilder.def(
      pod: widget.pod,
      builder: (context, widget, value) => _buildChain(context, widget, value),
      child: widget.child,
    );
  }

  //
  //
  //
  //

  Widget _buildChain(
    BuildContext context,
    Widget? child,
    dynamic value,
  ) {
    final pod = widget.mapper?.call(value);
    if (pod is Pod) {
      return PodChainBuilder<dynamic, dynamic>.def(
        pod: pod,
        mapper: (e) => widget.mapper?.call(_letAsOrNull(e)),
        builder: (a, b, c) => widget.builder?.call(a, b, c),
        child: child,
      );
    } else {
      return widget.builder?.call(context, child, value) ??
          const SizedBox.shrink();
    }
  }

  //
  //
  //

  @override
  void dispose() {
    widget.pod?.disposeIfMarkedAsTemp();
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T? _letAsOrNull<T>(dynamic value) => value is T ? value : null;
