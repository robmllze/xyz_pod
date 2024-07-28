//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
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
    List<dynamic> Function(T childValue)? updateParents,
  ) {
    return _reduceToSinglePod(
      this,
      reducer,
      updateParents,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces many [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<A, B> reduceManyPods<A, B>(
  final Iterable<Pod<A>> instances,
  B Function(ManyPods<A> values) reducer,
  Iterable<A> Function(B childValue)? updateParents,
) {
  return ChildPod<A, B>(
    parents: instances,
    reducer: (_) => reducer(ManyPods(instances)),
    updateParents: updateParents,
  );
}

const _reduceToSinglePod = reduceManyPods;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple of many [Pod] instances.
final class ManyPods<A> {
  final Iterable<Pod<A>> pods;

  const ManyPods(this.pods);

  Iterable<A> get values => pods.map((pod) => pod.value);

  /// Returns a list of Pod values where the type matches the generic type [T].
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

/// Reduces a tuple 2 [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<dynamic, T> reduce2Pods<T, A, B>(
  Pods2<A, B> instances,
  T Function(Pods2<A, B> values) reducer,
  (A?, B?) Function(T childValue)? updateParents,
) {
  return ChildPod<dynamic, T>(
    parents: instances.pods.nonNulls,
    reducer: (_) => reducer(instances),
    updateParents: updateParents != null
        ? (e) {
            final temp = updateParents(e);
            return [temp.$1, temp.$2];
          }
        : null,
  );
}

/// A tuple of 2 [Pod] instances.
final class Pods2<A, B> implements _Tuple2<A?, B?> {
  final Pod<A>? pA;
  final Pod<B>? pB;

  const Pods2([
    this.pA,
    this.pB,
  ]);

  @override
  A? get a => pA?.value;
  @override
  B? get b => pB?.value;

  @override
  Iterable<dynamic> get values => [a, b];

  Iterable<Pod<dynamic>?> get pods => [pA, pB];
}

/// A tuple of 2 values.
final class _Tuple2<A, B> {
  final A a;
  final B b;

  const _Tuple2(this.a, this.b);

  Iterable<dynamic> get values => [a, b];
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a tuple 3 [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<dynamic, T> reduce3Pods<T, A, B, C>(
  Pods3<A, B, C> instances,
  T Function(Pods3<A, B, C> values) reducer,
  (A?, B?, C?) Function(T childValue)? updateParents,
) {
  return ChildPod<dynamic, T>(
    parents: instances.pods.nonNulls,
    reducer: (_) => reducer(instances),
    updateParents: updateParents != null
        ? (e) {
            final temp = updateParents(e);
            return [temp.$1, temp.$2, temp.$3];
          }
        : null,
  );
}

/// A tuple of 3 [Pod] instances.
final class Pods3<A, B, C> implements _Tuple3<A?, B?, C?> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;

  const Pods3([
    this.pA,
    this.pB,
    this.pC,
  ]);

  @override
  A? get a => pA?.value;
  @override
  B? get b => pB?.value;
  @override
  C? get c => pC?.value;

  @override
  Iterable<dynamic> get values => [a, b, c];

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC];
}

/// A tuple of 3 values.
final class _Tuple3<A, B, C> {
  final A a;
  final B b;
  final C c;

  const _Tuple3(this.a, this.b, this.c);

  Iterable<dynamic> get values => [a, b, c];
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a tuple 4 [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<dynamic, T> reduce4Pods<T, A, B, C, D>(
  Pods4<A, B, C, D> instances,
  T Function(Pods4<A, B, C, D> values) reducer,
  (A?, B?, C?, D?) Function(T childValue)? updateParents,
) {
  return ChildPod<dynamic, T>(
    parents: instances.pods.nonNulls,
    reducer: (_) => reducer(instances),
    updateParents: updateParents != null
        ? (e) {
            final temp = updateParents(e);
            return [temp.$1, temp.$2, temp.$3, temp.$4];
          }
        : null,
  );
}

/// A tuple of 4 [Pod] instances.
final class Pods4<A, B, C, D> implements _Tuple4<A?, B?, C?, D?> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;

  const Pods4([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
  ]);

  @override
  A? get a => pA?.value;
  @override
  B? get b => pB?.value;
  @override
  C? get c => pC?.value;
  @override
  D? get d => pD?.value;

  @override
  Iterable<dynamic> get values => [a, b, c, d];

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD];
}

/// A tuple of 4 values.
final class _Tuple4<A, B, C, D> {
  final A a;
  final B b;
  final C c;
  final D d;

  const _Tuple4(this.a, this.b, this.c, this.d);

  Iterable<dynamic> get values => [a, b, c, d];
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a tuple 5 [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<dynamic, T> reduce5Pods<T, A, B, C, D, E>(
  Pods5<A, B, C, D, E> instances,
  T Function(Pods5<A, B, C, D, E> values) reducer,
  (A?, B?, C?, D?, E?) Function(T childValue)? updateParents,
) {
  return ChildPod<dynamic, T>(
    parents: instances.pods.nonNulls,
    reducer: (_) => reducer(instances),
    updateParents: updateParents != null
        ? (e) {
            final temp = updateParents(e);
            return [temp.$1, temp.$2, temp.$3, temp.$4, temp.$5];
          }
        : null,
  );
}

/// A tuple of 5 [Pod] instances.
final class Pods5<A, B, C, D, E> implements Tuple5<A?, B?, C?, D?, E?> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;

  const Pods5([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
    this.pE,
  ]);

  @override
  A? get a => pA?.value;
  @override
  B? get b => pB?.value;
  @override
  C? get c => pC?.value;
  @override
  D? get d => pD?.value;
  @override
  E? get e => pE?.value;

  @override
  Iterable<dynamic> get values => [a, b, c, d, e];

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD, pE];
}

/// A tuple of 5 values.
final class Tuple5<A, B, C, D, E> {
  final A a;
  final B b;
  final C c;
  final D d;
  final E e;

  const Tuple5._Tuple5(this.a, this.b, this.c, this.d, this.e);

  Iterable<dynamic> get values => [a, b, c, d, e];
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reduces a tuple 6 [Pod] - [instances] to a single [ChildPod] instance via
/// [reducer]. Optionally provide [updateParents] to define how parent Pods
/// should be updated when this Pod changes.
ChildPod<dynamic, T> reduce6Pods<T, A, B, C, D, E, F>(
  Pods6<A, B, C, D, E, F> instances,
  T Function(Pods6<A, B, C, D, E, F> instances) reducer,
  (A?, B?, C?, D?, E?, F?) Function(T childValue)? updateParents,
) {
  return ChildPod<dynamic, T>(
    parents: instances.pods.nonNulls,
    reducer: (_) => reducer(instances),
    updateParents: updateParents != null
        ? (e) {
            final temp = updateParents(e);
            return [temp.$1, temp.$2, temp.$3, temp.$4, temp.$5, temp.$6];
          }
        : null,
  );
}

/// A tuple of 6 [Pod] instances.
final class Pods6<A, B, C, D, E, F> implements _Tuple6<A?, B?, C?, D?, E?, F?> {
  final Pod<A>? pA;
  final Pod<B>? pB;
  final Pod<C>? pC;
  final Pod<D>? pD;
  final Pod<E>? pE;
  final Pod<F>? pF;

  const Pods6([
    this.pA,
    this.pB,
    this.pC,
    this.pD,
    this.pE,
    this.pF,
  ]);

  @override
  A? get a => pA?.value;
  @override
  B? get b => pB?.value;
  @override
  C? get c => pC?.value;
  @override
  D? get d => pD?.value;
  @override
  E? get e => pE?.value;
  @override
  F? get f => pF?.value;

  @override
  Iterable<dynamic> get values => [a, b, c, d, e];

  Iterable<Pod<dynamic>?> get pods => [pA, pB, pC, pD, pE];
}

/// A tuple of 6 values.
final class _Tuple6<A, B, C, D, E, F> {
  final A a;
  final B b;
  final C c;
  final D d;
  final E e;
  final F f;

  const _Tuple6(this.a, this.b, this.c, this.d, this.e, this.f);

  Iterable<dynamic> get values => [a, b, c, d, e, f];
}
