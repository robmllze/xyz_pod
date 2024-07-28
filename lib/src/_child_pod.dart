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

part of 'pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ChildPod<A, B> extends Pod<B> {
  //
  //
  //

  final Iterable<Pod<A>> parents;
  final B Function(Iterable<A> parentValues) reducer;
  final Iterable<A> Function(B childValue)? updateParents;

  //
  //
  //

  ChildPod({
    required this.parents,
    required this.reducer,
    required this.updateParents,
    bool temp = false,
  }) : super(
          reducer(parents.map((p) => p.value).toList()),
          temp: temp,
        ) {
    for (var parent in parents) {
      parent._addChild(this);
      parent.addListener(refresh);
    }
  }

  //
  //
  //

  factory ChildPod.temp({
    required Iterable<Pod<A>> parents,
    required B Function(Iterable<A> parentValues) reducer,
    Iterable<A> Function(B childValue)? updateParents,
  }) {
    return ChildPod(
      parents: parents,
      reducer: reducer,
      updateParents: updateParents,
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
  void notifyListeners() {
    super.notifyListeners();
    if (this.updateParents != null) {
      final parentValues = updateParents!(this.value);
      for (var n = 0; n < parents.length; n++) {
        parents.elementAt(n).set(parentValues.elementAt(n));
      }
    }
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
