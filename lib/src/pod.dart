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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// `Pod<T>` helps you manage state in Flutter apps. It works like
/// `ValueNotifier<T>`, but with added bells and whistles.
///
/// This class lets you update state asynchronously and mark some instances as
/// temporary, which can be automatically cleaned up in certain situations.
///

class Pod<T> extends ValueNotifier<T> {
  //
  //
  //

  /// Whether this Pod is marked as temporary. Pods marked as temporary are
  /// disposed by [PodBuilder], [PodListBuilder], [PollingPodBuilder], and [ResponsivePodListBuilder]
  ///
  bool markedAsTemp;

  //
  //
  //

  /// Holds the latest value temporarily during asynchronous updates, ensuring
  /// the Pod's state is always current.
  T? _cachedValue;

  //
  //
  //

  /// Create a new `Pod<T>` with an initial value.
  ///
  /// - `value`: The starting value.
  /// - `temp` (optional): If true, the `Pod<T>` is temporary. Defaults to false.
  Pod(super.value, {bool temp = false}) : markedAsTemp = temp;

  //
  //
  //

  /// Creates a temporary `Pod<T>` with an initial value. These get cleaned up automatically,
  /// but you need to set this up in your widget's lifecycle.
  ///
  /// - `initialValue`: The starting value for the temporary `Pod<T>`.
  Pod.temp(T initialValue) : this(initialValue, temp: true);

  //
  //
  //

  /// Gets the `Pod<T>` value without notifying any listeners.
  @override
  T get value => _cachedValue ?? super.value;

  //
  //
  //

  /// Sets the `Pod<T>` value and notifies any listeners.
  set value(T newValue) => this.set(newValue);

  //
  //
  //

  /// Gets the `Pod<T>` value and notifies any listeners.
  T call() {
    Future.delayed(Duration.zero, notifyListeners);
    return value;
  }

  //
  //
  //

  /// Set the `Pod<T>` value asynchronously and notify any listeners.
  /// This is done after the current build phase to avoid UI issues.
  ///
  /// - `value`: The new value to set.
  Future<void> set(T newValue) async {
    _cachedValue = newValue;
    await Future.delayed(Duration.zero, () {
      super.value = _cachedValue ?? newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  /// Update the `Pod<T>` value asynchronously with a function.
  /// Like `set`, but uses a function to determine the new value.
  ///
  /// - `updater`: Function to create the new value from the old one.
  Future<void> update(T Function(T value) updater) async {
    final newValue = updater(value);
    _cachedValue = newValue;
    await Future.delayed(Duration.zero, () {
      super.value = _cachedValue ?? newValue;
      notifyListeners();
    });
  }

  //
  //
  //

  /// Refresh the `Pod<T>`, notifying listeners. Useful when the state changes
  /// in ways not shown by a simple value change.
  Future<void> refresh() async {
    await Future.delayed(Duration.zero, notifyListeners);
  }

  //
  //
  //

  /// Add a listener that only runs once and then removes itself.
  void addSingleExecutionListener(VoidCallback listener) {
    late final VoidCallback tempLlistener;
    tempLlistener = () {
      listener();
      removeListener(tempLlistener);
    };
    addListener(tempLlistener);
  }

  //
  //
  //

  /// Clean up the `Pod<T>` if it's marked as temporary. This is for managing
  /// resources efficiently.
  void disposeIfMarkedAsTemp() {
    if (markedAsTemp) {
      dispose();
    }
  }
}