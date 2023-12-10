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
import 'package:xyz_pod/src/pod_builder.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef Pod<T> = ChainablePod<dynamic, T>;
typedef DynamicPod = ChainablePod<dynamic, dynamic>;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// `Pod<T>` is a state management class that extends `ValueNotifier<T>`.
/// It offers advanced features for handling state changes in Flutter apps.
///
/// The class allows for asynchronous state updates and includes a flag to mark
/// the instance as temporary. However, automatic disposal of temporary `Pod` instances
/// requires implementation within a widget's lifecycle.
///
/// Generic Type:
/// - `T`: The type of value the `Pod` holds.
class ChainablePod<A, B> extends ValueNotifier<A> {
  //
  //
  //

  /// Marks the `Pod` as temporary. Temporary `Pod` instances can be flagged
  /// for automatic disposal when used within a widget that supports this
  /// feature.
  bool markedAsTemp;

  //
  //
  //

  /// Creates a new `Pod` instance with the given initial value.
  ///
  /// Parameters:
  /// - `value`: The initial value of the `Pod`.
  /// - `isTemp` (optional): Marks the `Pod` as temporary if set to `true`.
  ///     Defaults to `false`.
  ChainablePod(super.value, {bool temp = false}) : markedAsTemp = temp;

  //
  //
  //

  /// Creates a temporary `Pod` instance with the given initial value.
  /// Temporary `Pod` instances are flagged for automatic disposal but this
  /// requires implementation within a widget's lifecycle.
  ///
  /// Parameters:
  /// - `value`: The initial value of the temporary `Pod`.
  ChainablePod.temp(A initialValue) : this(initialValue, temp: true);

  //
  //
  //

  /// Asynchronously sets the value of the `Pod` and notifies listeners.
  ///
  /// The update is scheduled to be executed after the current build phase,
  /// ensuring it does not interfere with the UI rendering process.
  ///
  /// Parameters:
  /// - `value`: The new value to set for the `Pod`.
  Future<void> set(
    A newValue, {
    bool disposeChain = true,
  }) async {
    await Future.delayed(Duration.zero, () {
      if (currentValue is Pod && disposeChain) {
        (currentValue as Pod).dispose();
      }
      currentValue = newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  /// Asynchronously updates the value of the `Pod` using the provided updater function.
  ///
  /// The update is applied after the current build phase, similar to `set`.
  ///
  /// Parameters:
  /// - `updater`: A function that takes the current value and returns the updated value.
  Future<void> update(
    A Function(A) updater, {
    bool disposeChain = true,
  }) async {
    await Future.delayed(Duration.zero, () {
      final newValue = updater(currentValue);
      if (currentValue is Pod && disposeChain) {
        (currentValue as Pod).dispose();
      }
      currentValue = newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  /// Asynchronously refreshes the `Pod`, triggering a notification to listeners.
  ///
  /// This method is useful when the internal state has changed in a way
  /// that is not captured by a simple value assignment.
  Future<void> refresh() async {
    await Future.delayed(Duration.zero, notifyListeners);
  }

  //
  //
  //

  Widget build(Widget Function(dynamic) builder) {
    return PodBuilder<A, B>.value(pod: this, builder: builder);
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

  ChainablePod<B, C>? _valueAsPodOrNull<C>() {
    return currentValue is ChainablePod<B, C> ? currentValue as ChainablePod<B, C> : null;
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
  List<ChainablePod> get chain {
    final chain = <ChainablePod>[];
    void addToChain(dynamic v) {
      if (v is ChainablePod) {
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
  ChainablePod<B, C>? nextOrNull<C>() {
    return _valueAsPodOrNull<C>()
      ?..removeListener(notifyListeners)
      ..addListener(notifyListeners);
  }

  //
  //
  //

  /// Returns the last `Pod` in the chain.
  ChainablePod get last {
    ChainablePod? temp = nextOrNull();
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

  /// Disposes the `Pod` chain if it is marked as" temp".
  void disposeIfMarkedAsTemp() {
    if (this.markedAsTemp) {
      dispose();
    }
  }

  /// Disposes the `Pod` chain.
  @override
  void dispose() {
    print("disposing ${this.runtimeType}");
    super.dispose();
    _valueAsPodOrNull()?.dispose();
  }
}
