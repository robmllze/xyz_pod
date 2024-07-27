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

  final Pod<A> parent;
  final B Function(A parentValue) mapper;

  //
  //
  //

  ChildPod({
    required this.parent,
    required this.mapper,
    bool temp = false,
  }) : super(mapper(parent.value), temp: temp) {
    parent._addChild(this);
  }

  //
  //
  //

  factory ChildPod.temp({
    required Pod<A> parent,
    required B Function(A parentValue) mapper,
  }) {
    return ChildPod(
      parent: parent,
      mapper: mapper,
      temp: true,
    );
  }

  //
  //
  //

  @override
  Future<void> refresh() async {
    await this.set(mapper(parent.value));
  }

  //
  //
  //

  @override
  void dispose() {
    parent._removeChild(this);
    super.dispose();
  }
}
