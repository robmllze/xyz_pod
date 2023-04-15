// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //
// // XyzPod - AutoDisposingPod
// //
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// // ignore_for_file: unnecessary_this

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:xyz_utils/xyz_utils.dart';

// import '_equality.dart';

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class AutoDisposingPod<T> extends StateNotifier<DisposableValue> {
//   //
//   //
//   //

//   late final AutoDisposeStateNotifierProvider _provider;

//   //
//   //
//   //

//   final callbacks = Callbacks<T, TCallback<T>>();

//   //
//   //
//   //

//   AutoDisposingPod(T initial) : super(DisposableValue(initial)) {
//     this._provider = AutoDisposeStateNotifierProvider((_) => this);
//   }

//   AutoDisposingPod.pass(AutoDisposingPod other) : super(other.state) {
//     this._provider = AutoDisposeStateNotifierProvider((_) => this);
//   }

//   //
//   //
//   //

//   Type get genericType => T;

//   @visibleForTesting
//   T get value => this.state.value;

//   set value(T value) => this.state.value = value;

//   E? tryValueAs<E extends T>() => letAs<E>(this.state.value);

//   E valueAs<E extends T>() => this.state.value as E;

//   @visibleForTesting
//   E call<E extends T>() => this.valueAs<E>();

//   //
//   //
//   //

//   E watch<E extends T>(WidgetRef ref) {
//     assert(
//       this.mounted,
//       "Usage error: Pod has been disposed and is no longer usable",
//     );
//     return (ref.watch(this._provider) as DisposableValue).value as E;
//   }

//   //
//   //
//   //

//   Future<Map<dynamic, dynamic>?> _executeTaskWithDelay(
//     Future<Map<dynamic, dynamic>?>? Function() task,
//     Duration? delay,
//   ) async {
//     return (delay == null ? task() : Future.delayed(delay, task));
//   }

//   //
//   //
//   //

//   Future<Map<dynamic, dynamic>?> refresh({
//     bool shouldExecuteCallbacks = true,
//     Duration? delay,
//   }) {
//     assert(
//       this.mounted,
//       "Usage error: Pod has been disposed and is no longer usable",
//     );
//     Future<Map<dynamic, dynamic>?>? task() async {
//       this.state = this.state.pass;
//       if (shouldExecuteCallbacks) {
//         return await callbacks.callAll(this.value);
//       }
//       return null;
//     }

//     return this._executeTaskWithDelay(task, delay);
//   }

//   //
//   //
//   //

//   Future<Map<dynamic, dynamic>?> update(
//     T Function(T valueOld) stateNew, {
//     FEquality<T>? equals,
//     bool shouldExecuteCallbacks = true,
//     Duration? delay,
//   }) {
//     assert(
//       this.mounted,
//       "Usage error: Pod has been disposed and is no longer usable",
//     );
//     Future<Map<dynamic, dynamic>?>? task() async {
//       final stateNew1 = stateNew(this.value);
//       final stateOld = this.value;
//       if (!(equals?.call(stateOld, stateNew1) ?? stateOld == stateNew1)) {
//         this.value = stateNew1;
//         this.state = this.state.pass;
//         if (shouldExecuteCallbacks) {
//           return await callbacks.callAll(stateNew1);
//         }
//       }
//       return null;
//     }

//     return this._executeTaskWithDelay(task, delay);
//   }

//   //
//   //
//   //

//   Future<Map<dynamic, dynamic>?> set(
//     T stateNew, {
//     FEquality<T>? equals,
//     bool shouldExecuteCallbacks = true,
//     Duration? delay,
//   }) {
//     assert(
//       this.mounted,
//       "Usage error: Pod has been disposed and is no longer usable",
//     );
//     Future<Map<dynamic, dynamic>?>? task() async {
//       final stateOld = this.value;
//       if (!(equals?.call(stateOld, stateNew) ?? stateOld == stateNew)) {
//         this.value = stateNew;
//         this.state = this.state.pass;
//         if (shouldExecuteCallbacks) {
//           return await callbacks.callAll(stateNew);
//         }
//       }
//       return null;
//     }

//     return this._executeTaskWithDelay(task, delay);
//   }

//   //
//   //
//   //

//   Consumer build(Widget? Function(T) builder) {
//     assert(
//       this.mounted,
//       "Usage error: Pod has been disposed and is no longer usable",
//     );
//     return Consumer(
//       builder: (_, final ref, __) {
//         if (this.mounted) {
//           final result = builder(this.watch(ref));
//           if (result != null) {
//             return result;
//           }
//         }
//         return const SizedBox();
//       },
//     );
//   }

//   //
//   //
//   //

//   @override
//   Future<void> dispose() async {
//     if (this.mounted) {
//       await this.callbacks.wait();
//       this.callbacks.clear();
//       this.state.dispose(true);
//       super.dispose();
//       debugLogAlert("Disposed Pod of type ${this._provider.runtimeType}");
//     }
//   }
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// class AutoDisposingPod<dynamic> extends AutoDisposingPod<dynamic> {
//   //
//   //
//   //

//   AutoDisposingPod<dynamic>(dynamic value) : super(value);

//   //
//   //
//   //

//   AutoDisposingPod<dynamic>.pass(AutoDisposingPod other) : super(other.state) {
//     this._provider = AutoDisposeStateNotifierProvider((_) => this);
//   }
// }
