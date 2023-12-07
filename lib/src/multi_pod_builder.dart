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

class MultiPodBuilder<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>
    extends PodListBuilder {
  //
  //
  //

  MultiPodBuilder({
    super.key,
    required Pods<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>
        pods,
    Widget? child,
    required Widget Function(
      BuildContext,
      Widget?,
      Pods<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>,
    ) builder,
  }) : super(
          pods: pods.toList(),
          builder: (final context, final child, final values) {
            return builder(
              context,
              child,
              Pods<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>(
                podA: values.elementAtOrNull(0),
                podB: values.elementAtOrNull(1),
                podC: values.elementAtOrNull(2),
                podD: values.elementAtOrNull(3),
                podE: values.elementAtOrNull(4),
                podF: values.elementAtOrNull(5),
                podG: values.elementAtOrNull(6),
                podH: values.elementAtOrNull(7),
                podI: values.elementAtOrNull(8),
                podJ: values.elementAtOrNull(9),
                podK: values.elementAtOrNull(10),
                podL: values.elementAtOrNull(11),
                podM: values.elementAtOrNull(12),
                podN: values.elementAtOrNull(13),
                podO: values.elementAtOrNull(14),
                podP: values.elementAtOrNull(15),
                podQ: values.elementAtOrNull(16),
                podR: values.elementAtOrNull(17),
                podS: values.elementAtOrNull(18),
                podT: values.elementAtOrNull(19),
                podU: values.elementAtOrNull(20),
                podV: values.elementAtOrNull(21),
                podW: values.elementAtOrNull(22),
                podX: values.elementAtOrNull(23),
                podY: values.elementAtOrNull(24),
                podZ: values.elementAtOrNull(25),
              ),
            );
          },
        );

  //
  //
  //

  factory MultiPodBuilder.values({
    Key? key,
    required Pods<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>
        pods,
    required Widget Function(
      BuildContext,
      Pods<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>,
    ) builder,
  }) {
    return MultiPodBuilder<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X,
        Y, Z>(
      pods: pods,
      builder: (_, __, values) => builder(_, values),
    );
  }
}
