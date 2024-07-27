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
  final B Function(List<A> parentValues) mapper;

  //
  //
  //

  ChildPod({
    required this.parents,
    required this.mapper,
    bool temp = false,
  }) : super(mapper(parents.map((p) => p.value).toList()), temp: temp) {
    for (var parent in parents) {
      parent._addChild(this);
      parent.addListener(refresh);
    }
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
      mapper: mapper,
      temp: true,
    );
  }

  //
  //
  //

  @override
  Future<void> refresh() async {
    final newValue = mapper(parents.map((p) => p.value).toList());
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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension MapOnPodIterableExtension on Iterable<Pod> {
  ChildPod<dynamic, T> map<T>(
    T Function(List<dynamic> parentValues) mapper,
  ) {
    return ChildPod<dynamic, T>(
      parents: this.toList(),
      mapper: mapper,
    );
  }
}
