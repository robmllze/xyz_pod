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
  ChildPod<dynamic, T> reduceToSinglePod<T>(
    T Function(_Pods values) reducer,
  ) {
    return _reduceToSinglePod(this, reducer);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a set of [Pod] instances to a single [ChildPod] instance.
ChildPod<A, B> reduceToSinglePod<A, B>(
  final Iterable<Pod<A>> pods,
  B Function(_Pods values) reducer,
) {
  return ChildPod<A, B>(
    parents: pods.toList(),
    reducer: (_) => reducer(_Pods(pods)),
  );
}

const _reduceToSinglePod = reduceToSinglePod;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _Pods<A> {
  //
  //
  //

  final Iterable<Pod<A>> pods;

  //
  //
  //

  const _Pods(this.pods);

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
ChildPod<dynamic, T> reduce2Pods<T, A, B>(
  PodSet2<A, B> values,
  T Function(PodSet2<A, B> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 2 [Pod] instances to be used with [reduce2Pods].
final class PodSet2<A, B> {
  final Pod<A>? pA;
  final Pod<B>? pB;

  PodSet2([
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
ChildPod<dynamic, T> reduce3Pods<T, A, B, C>(
  PodSet3<A, B, C> values,
  T Function(PodSet3<A, B, C> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 3 [Pod] instances to be used with [reduce3Pods].
final class PodSet3<A, B, C> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;

  PodSet3([
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
ChildPod<dynamic, T> reduce4Pods<T, A, B, C, D>(
  PodSet4<A, B, C, D> values,
  T Function(PodSet4<A, B, C, D> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 4 [Pod] instances to be used with [reduce4Pods].
final class PodSet4<A, B, C, D> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;

  PodSet4([
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
ChildPod<dynamic, T> reduce5Pods<T, A, B, C, D, E>(
  PodSet5<A, B, C, D, E> values,
  T Function(PodSet5<A, B, C, D, E> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 5 [Pod] instances to be used with [reduce5Pods].
final class PodSet5<A, B, C, D, E> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;

  PodSet5([
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
ChildPod<dynamic, T> reduce6Pods<T, A, B, C, D, E, F>(
  PodSet6<A, B, C, D, E, F> values,
  T Function(PodSet6<A, B, C, D, E, F> values) reducer,
) {
  return ChildPod<dynamic, T>(
    parents: values.pods.nonNulls.toList(),
    reducer: (_) => reducer(values),
  );
}

/// A set of 6 [Pod] instances to be used with [reduce6Pods].
final class PodSet6<A, B, C, D, E, F> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;
  final Pod<F>? pF;

  PodSet6([
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
