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

part of 'pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ChildPod<A, B> extends Pod<B> {
  //
  //
  //

  final List<Pod<A>> parents;
  final B Function(List<A> parentValues) reducer;

  //
  //
  //

  ChildPod({
    required this.parents,
    required this.reducer,
    bool temp = false,
  }) : super(reducer(parents.map((p) => p.value).toList()), temp: temp) {
    for (var parent in parents) {
      parent._addChild(this);
      parent.addListener(refresh);
    }
  }

  //
  //
  //

  /// Reduces many [Pod] instances to a single [ChildPod] instance.
  static ChildPod<A, B> fromMany<A, B>(
    Iterable<Pod<A>> pods,
    B Function(ManyPods<A> values) reducer,
  ) {
    return reduceManyPods(
      pods,
      reducer,
    );
  }

  /// Reduces a set of 2 [Pod] instances to a single [ChildPod] instance.
  static ChildPod<dynamic, T> from2<T, A, B>(
    Pods2<A, B> values,
    T Function(Pods2<A, B> values) reducer,
  ) {
    return reduce2Pods(
      values,
      reducer,
    );
  }

  /// Reduces a set of 3 [Pod] instances to a single [ChildPod] instance.
  static ChildPod<dynamic, T> from3<T, A, B, C>(
    Pods3<A, B, C> values,
    T Function(Pods3<A, B, C>  values) reducer,
  ) {
    return reduce3Pods(
      values,
      reducer,
    );
  }

  /// Reduces a set of 4 [Pod] instances to a single [ChildPod] instance.
  static ChildPod<dynamic, T> from4<T, A, B, C, D>(
    Pods4<A, B, C, D> values,
    T Function(Pods4<A, B, C, D> values) reducer,
  ) {
    return reduce4Pods(
      values,
      reducer,
    );
  }

  /// Reduces a set of 5 [Pod] instances to a single [ChildPod] instance.
  static ChildPod<dynamic, T> from5<T, A, B, C, D, E>(
    Pods5<A, B, C, D, E> values,
    T Function(Pods5<A, B, C, D, E> values) reducer,
  ) {
    return reduce5Pods(
      values,
      reducer,
    );
  }

  /// Reduces a set of 6 [Pod] instances to a single [ChildPod] instance.
  static ChildPod<dynamic, T> from6<T, A, B, C, D, E, F>(
    Pods6<A, B, C, D, E, F> values,
    T Function(Pods6<A, B, C, D, E, F> values) reducer,
  ) {
    return reduce6Pods(
      values,
      reducer,
    );
  }

  //
  //
  //

  factory ChildPod.temp({
    required List<Pod<A>> parents,
    required B Function(List<A> parentValues) mapper,
  }) {
    return ChildPod(
      parents: parents,
      reducer: mapper,
      temp: true,
    );
  }

  //
  //
  //

  @override
  Future<void> refresh() async {
    final newValue = reducer(parents.map((p) => p.value).toList());
    await this.set(newValue);
  }

  //
  //
  //

  @override
  void dispose() {
    for (var parent in parents) {
      parent._removeChild(this);
      parent.removeListener(refresh);
    }
    super.dispose();
  }
}
