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

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:xyz_pod/src/pod_builder.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef Pod<T> = Pod2<T, dynamic>;

/// `Pod<T>` is a state management class that extends `ValueNotifier<T>`.
/// It offers advanced features for handling state changes in Flutter apps.
///
/// The class allows for asynchronous state updates and includes a flag to mark
/// the instance as temporary. However, automatic disposal of temporary `Pod` instances
/// requires implementation within a widget's lifecycle.
///
/// Generic Type:
/// - `T`: The type of value the `Pod` holds.
class Pod2<A, B> extends ValueNotifier<A> {
  /// Marks the `Pod` as temporary. Temporary `Pod` instances can be flagged
  /// for automatic disposal when used within a widget that supports this
  /// feature.
  bool isTemp;

  //
  //
  //

  /// Creates a new `Pod` instance with the given initial value.
  ///
  /// Parameters:
  /// - `value`: The initial value of the `Pod`.
  /// - `isTemp` (optional): Marks the `Pod` as temporary if set to `true`.
  ///     Defaults to `false`.
  Pod2(super.value, {this.isTemp = false});

  //
  //
  //

  /// Creates a temporary `Pod` instance with the given initial value.
  /// Temporary `Pod` instances are flagged for automatic disposal but this
  /// requires implementation within a widget's lifecycle.
  ///
  /// Parameters:
  /// - `value`: The initial value of the temporary `Pod`.
  Pod2.temp(A value) : this(value, isTemp: true);

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
  Future<void> set(A value) async {
    await Future.delayed(Duration.zero, () {
      this.value = value;
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
  Future<void> update(A Function(A) updater) async {
    await Future.delayed(Duration.zero, () {
      value = updater(value);
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
    await Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  //
  //
  //

  Widget build(Widget Function(A? value) builder) {
    return PodBuilder.value(pod: this, builder: builder);
  }

  //
  //
  //

  /// Disposes of the `Pod` if it is marked as temporary.
  ///
  /// This is useful for resource management, ensuring that temporary instances
  /// are properly disposed of when no longer needed.
  void disposeIfTemp() {
    if (this.isTemp) {
      dispose();
    }
  }

  //
  //
  //

  @override
  void dispose() {
    final children = Queue<Pod2>();

    void addToChildren(A value) {
      if (value is Pod2) {
        children.addFirst(value);
        addToChildren(value.value);
      }
    }

    addToChildren(value);

    for (final child in children) {
      child.dispose();
    }

    Text("Disposing");
    super.dispose();
  }

  //
  //
  //

  Pod2<B, C>? pChild<C>() {
    if (value is Pod2<B, C>) {
      final pod = value as Pod2<B, C>;
      pod.removeListener(notifyListeners);
      pod.addListener(notifyListeners);
      return value as Pod2<B, C>;
    }
    return null;
  }

  //
  //
  //

  @override
  operator ==(Object other) {
    if (other is Pod2) {
      return other.value == value;
    }
    return false;
  }

  //
  //
  //

  @override
  int get hashCode => value.hashCode;
}
