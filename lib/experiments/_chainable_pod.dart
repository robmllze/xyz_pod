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
import 'package:xyz_pod/xyz_pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ChainPod<A, B> extends Pod<A> {
  //
  //
  //

  ChainPod(super.value, {super.temp});

  //
  //
  //

  ChainPod.temp(A initialValue) : this(initialValue, temp: true);

  //
  //
  //

  @override
  Future<void> set(
    A newValue, {
    bool disposeChain = true,
  }) async {
    await Future.delayed(Duration.zero, () {
      if (currentValue is ChainPod && disposeChain) {
        (currentValue as ChainPod).dispose();
      }
      currentValue = newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  @override
  Future<void> update(
    A Function(A) updater, {
    bool disposeChain = true,
  }) async {
    await Future.delayed(Duration.zero, () {
      final newValue = updater(currentValue);
      if (currentValue is ChainPod && disposeChain) {
        (currentValue as ChainPod).dispose();
      }
      currentValue = newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  @override
  Future<void> refresh() async {
    await Future.delayed(Duration.zero, notifyListeners);
  }

  //
  //
  //

  /// Returns the last value in the `Pod` chain.
  @override
  A get value => this.last.currentValue;

  //
  //
  //

  /// Returns the current value of the `Pod`.
  A get currentValue => super.value;

  //
  //
  //

  /// Sets the current value of the `Pod`.
  @protected
  set currentValue(A newValue) => super.value = newValue;

  //
  //
  //

  ChainPod<B, C>? _valueAsPodOrNull<C>() {
    return currentValue is ChainPod<B, C> ? currentValue as ChainPod<B, C> : null;
  }

  //
  //
  //

  /// Returns the length of the Pod chain.
  int get length => (_valueAsPodOrNull()?.length ?? 0) + 1;

  //
  //
  //

  /// Returns the Pod chain.
  List<ChainPod> get chain {
    final chain = <ChainPod>[];
    void addToChain(dynamic v) {
      if (v is ChainPod) {
        chain.add(v);
        addToChain(v.currentValue);
      }
    }

    addToChain(this);
    return chain;
  }

  //
  //
  //

  /// Returns the next `Pod` in the chain.
  ChainPod<B, C>? nextOrNull<C>() {
    return _valueAsPodOrNull<C>()
      ?..removeListener(notifyListeners)
      ..addListener(notifyListeners);
  }

  //
  //
  //

  /// Returns the last `Pod` in the chain.
  ChainPod get last {
    ChainPod? temp = nextOrNull();
    while (true) {
      final next = temp?.nextOrNull();
      if (next == null) {
        return temp ?? this;
      }
      temp = next;
    }
  }

  //
  //
  //

  @override
  String toString() => this.value.toString();

  //
  //
  //

  /// Disposes the `Pod` chain.
  @override
  void dispose() {
    if (!_disposed) {
      super.dispose();
      _disposed = true;
    }
    _valueAsPodOrNull()?.dispose();
  }

  bool _disposed = false;
}
