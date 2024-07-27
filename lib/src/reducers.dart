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

extension ReducePodsOnPodIterableExtension on Iterable<Pod> {
  /// Reduces a set of [Pod] instances to a single [ChildPod] instance.
  ChildPod<dynamic, T> reduceManyPods<T>(
    T Function(ManyPods values) reducer,
  ) {
    return _reduceToSinglePod(this, reducer);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of [Pod] instances to a single [ChildPod] instance.
ChildPod<A, B> reduceManyPods<A, B>(
  final Iterable<Pod<A>> pods,
  B Function(ManyPods values) reducer,
) {
  return ChildPod<A, B>(
    parents: pods.toList(),
    reducer: (_) => reducer(ManyPods(pods)),
  );
}

const _reduceToSinglePod = reduceManyPods;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final class ManyPods<A> {
  //
  //
  //

  final Iterable<Pod<A>> pods;

  //
  //
  //

  const ManyPods(this.pods);

  //
  //
  //

  Iterable<A> get values => pods.map((pod) => pod.value);

  //
  //
  //

  List<T> valuesWhereType<T>() {
    final results = <T>[];
    for (var pod in pods) {
      if (pod.value is T) {
        results.add(pod.value as T);
      }
    }
    return results;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of 2 [Pod] instances to a single [ChildPod] instance.
ChildPod<dynamic, T> reduceTwoPods<T, A, B>(
  TwoPods<A, B> values,
  T Function(TwoPods<A, B> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 2 [Pod] instances to be used with [reduceTwoPods].
final class TwoPods<A, B> {
  final Pod<A>? pA;
  final Pod<B>? pB;

  TwoPods([
    this.pA,
    this.pB,
  ]);

  Iterable<Pod<dynamic>?> get pods => [pA, pB];
  Iterable<dynamic> get values => [a, b];

  A? get a => pA?.value;
  B? get b => pB?.value;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of 3 [Pod] instances to a single [ChildPod] instance.
ChildPod<dynamic, T> reduceThreePods<T, A, B, C>(
  ThreePods<A, B, C> values,
  T Function(ThreePods<A, B, C> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 3 [Pod] instances to be used with [reduceThreePods].
final class ThreePods<A, B, C> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;

  ThreePods([
    this.pA,
    this.pB,
    this.pC,
  ]);

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC];
  Iterable<dynamic> get values => [a, b, c];

  A? get a => pA?.value;
  B? get b => pB?.value;
  C? get c => pC?.value;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of 4 [Pod] instances to a single [ChildPod] instance.
ChildPod<dynamic, T> reduceFourPods<T, A, B, C, D>(
  FourPods<A, B, C, D> values,
  T Function(FourPods<A, B, C, D> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 4 [Pod] instances to be used with [reduceFourPods].
final class FourPods<A, B, C, D> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;

  FourPods([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
  ]);

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD];
  Iterable<dynamic> get values => [a, b, c, d];

  A? get a => pA?.value;
  B? get b => pB?.value;
  C? get c => pC?.value;
  D? get d => pD?.value;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of 5 [Pod] instances to a single [ChildPod] instance.
ChildPod<dynamic, T> reduceFivePods<T, A, B, C, D, E>(
  FivePods<A, B, C, D, E> values,
  T Function(FivePods<A, B, C, D, E> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 5 [Pod] instances to be used with [reduceFivePods].
final class FivePods<A, B, C, D, E> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;

  FivePods([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
    this.pE,
  ]);

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD, pE];
  Iterable<dynamic> get values => [a, b, c, d, e];

  A? get a => pA?.value;
  B? get b => pB?.value;
  C? get c => pC?.value;
  D? get d => pD?.value;
  E? get e => pE?.value;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of 6 [Pod] instances to a single [ChildPod] instance.
ChildPod<dynamic, T> reduceSixPods<T, A, B, C, D, E, F>(
  SixPods<A, B, C, D, E, F> values,
  T Function(SixPods<A, B, C, D, E, F> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 6 [Pod] instances to be used with [reduceSixPods].
final class SixPods<A, B, C, D, E, F> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;
  final Pod<F>? pF;

  SixPods([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
    this.pE,
    this.pF,
  ]);

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD, pE, pF];
  Iterable<dynamic> get values => [a, b, c, d, e, f];

  A? get a => pA?.value;
  B? get b => pB?.value;
  C? get c => pC?.value;
  D? get d => pD?.value;
  E? get e => pE?.value;
  F? get f => pF?.value;
}
