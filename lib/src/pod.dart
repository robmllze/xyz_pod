// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - Pod
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xyz_utils/xyz_utils.dart';

import 'equality.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A state notifier that holds a mutable value of type `T`.
///
/// This class provides a simple way to manage state and notify listeners when
/// the value changes. It also supports auto-disposing of resources to help
/// prevent memory leaks.
///
/// To connect the `Pod` to the UI, use a `Consumer` widget.
class Pod<T> extends StateNotifier<DisposableValue> {
  //
  //
  //

  late final StateNotifierProvider _provider;

  /// Callbacks to execute each time the value changes.
  final callbacks = Callbacks<T, TCallback<T>>();

  final bool requestDispose;

  Pod(T initial, {this.requestDispose = false}) : super(DisposableValue(initial)) {
    this._provider = StateNotifierProvider((_) => this);
  }

  factory Pod.requestDispose(T initial) => Pod(initial, requestDispose: true);

  Pod.pass(Pod other)
      : requestDispose = other.requestDispose,
        super(other.state) {
    this._provider = StateNotifierProvider((_) => this);
  }

  //
  //
  //

  Pod<dynamic> get toDynamic => this;

  Type get genericType => T;

  T get value => this.state.value as T;

  set value(T value) => this.state.value = value;

  T? tryValueAs() => letAs<T>(this.state.value);

  T valueAs() => this.value;

  T call() => this.valueAs();

  //
  //
  //

  /// Watches the current Pod instance and returns its value cast to type [E].
  ///
  /// Usage example:
  /// ```dart
  /// final myPod = Pod<String>("Hello, world!");
  /// ...
  /// final value = myPod.watch<String>(ref);
  /// ```
  E watch<E extends T>(WidgetRef ref) {
    assert(
      this.mounted,
      "Usage error: Pod has been disposed and is no longer usable",
    );
    return (ref.watch(this._provider) as DisposableValue).value as E;
  }

  /// Executes the given `task` immediately if there's no delay, otherwise waits
  /// the specified `delay`. Returns a Future that resolves to the result of the
  /// `task`.
  Future<Map<dynamic, dynamic>?> _executeTaskWithDelay(
    Future<Map<dynamic, dynamic>?>? Function() task,
    Duration? delay,
  ) async {
    return (delay == null ? task() : Future.delayed(delay, task));
  }

  /// Refreshes the value of the Pod and optionally executes registered
  /// callbacks.
  ///
  /// If shouldExecuteCallbacks is true (default), it calls all registered
  /// callbacks with the new value. If a delay is provided, the execution of
  /// the callbacks is delayed by the specified duration.
  Future<Map<dynamic, dynamic>?> refresh({
    bool shouldExecuteCallbacks = true,
    Duration? delay,
  }) {
    assert(
      this.mounted,
      "Usage error: Pod has been disposed and is no longer usable",
    );
    // Define a function that updates the Pod's state to the current value and
    // optionally executes callbacks.
    Future<Map<dynamic, dynamic>?>? task() async {
      this.state = this.state.pass;
      if (shouldExecuteCallbacks) {
        return await callbacks.callAll(this.value);
      }
      return null;
    }

    // Return the result of the function immediately or after a specified delay.
    return this._executeTaskWithDelay(task, delay);
  }

  /// Updates the value of the Pod using a provided update function.
  ///
  /// If the old and new values are different, it updates the value and
  /// optionally executes registered callbacks. If a delay is provided, the
  /// execution of the callbacks is delayed by the specified duration. The
  /// optional equals parameter allows for custom equality checks between the
  /// old and new values.
  Future<Map<dynamic, dynamic>?> update(
    T Function(T valueOld) stateNew, {
    FEquality<T>? equals,
    bool shouldExecuteCallbacks = true,
    Duration? delay,
  }) {
    assert(
      this.mounted,
      "Usage error: Pod has been disposed and is no longer usable",
    );
    Future<Map<dynamic, dynamic>?>? task() async {
      final stateNew1 = stateNew(this.value);
      final stateOld = this.value;
      if (!(equals?.call(stateOld, stateNew1) ?? stateOld == stateNew1)) {
        this.value = stateNew1;
        this.state = this.state.pass;
        if (shouldExecuteCallbacks) {
          return await callbacks.callAll(stateNew1);
        }
      }
      return null;
    }

    return this._executeTaskWithDelay(task, delay);
  }

  /// Sets the value of the Pod to a new value.
  ///
  /// If the old and new values are different, it updates the value and
  /// optionally executes registered callbacks. If a delay is provided, the
  /// execution of the callbacks is delayed by the specified duration. The
  /// optional equals parameter allows for custom equality checks between the
  /// old and new values.
  Future<Map<dynamic, dynamic>?> set(
    T stateNew, {
    FEquality<T>? equals,
    bool shouldExecuteCallbacks = true,
    Duration? delay,
  }) {
    assert(
      this.mounted,
      "Usage error: Pod has been disposed and is no longer usable",
    );

    Future<Map<dynamic, dynamic>?>? task() async {
      final stateOld = this.value;
      if (!(equals?.call(stateOld, stateNew) ?? stateOld == stateNew)) {
        this.value = stateNew;
        this.state = this.state.pass;
        if (shouldExecuteCallbacks) {
          return await callbacks.callAll(stateNew);
        }
      }
      return null;
    }

    return this._executeTaskWithDelay(task, delay);
  }

  /// Builds a widget from the Pod.
  ///
  /// Usage example:
  ///
  /// ```dart
  /// // The usual way to display a Pod's value.
  /// Consumer(
  ///   build: (_, final ref, __) {
  ///     final name = pName.watch(ref);
  ///     return Text("$name");
  ///   }
  /// ),
  /// // The shortcut way to display a Pod's value.
  /// pName.build((final name) => Text("$name")),
  /// ```
  Consumer build(Widget? Function(T) builder) {
    assert(
      this.mounted,
      "Usage error: Pod has been disposed and is no longer usable",
    );
    return Consumer(
      builder: (_, final ref, __) {
        if (this.mounted) {
          final result = builder(this.watch(ref));
          if (result != null) {
            return result;
          }
        }
        return const SizedBox();
      },
    );
  }

  // Disposes all resources used by the Pod, including callbacks and the
  // DisposableValue state.
  @override
  Future<void> dispose() async {
    if (this.mounted) {
      await this.callbacks.wait();
      this.callbacks.clear();
      this.state.dispose(true);
      super.dispose();
      debugLogAlert("Disposed Pod of type ${this._provider.runtimeType}");
    }
  }

  /// Calls [dispose] if [requestDispose] is true.
  Future<void> disposeIfRequested() async {
    if (this.requestDispose) {
      await this.dispose();
    }
  }
}
