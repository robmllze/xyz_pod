// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - PodMap
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: unnecessary_this

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A collection of Pods associated with a key.
///
/// Provides a way to dispose all the Pods at once and access them via their key.
class PodMap<K, V> {
  //
  //
  //

  final Map<K, Pod<V>> pods;

  //
  //
  //

  const PodMap(this.pods);

  //
  //
  //

  Pod<V>? operator [](K key) => pods[key];

  //
  //
  //

  Map<K, V> value() {
    return this.pods.map(
      (final key, final pod) {
        final value = pod.value;
        return MapEntry(key, value);
      },
    );
  }

  //
  //
  //

  Map<K, V> watch(WidgetRef? ref) {
    final results = <K, V>{};
    for (final pod in this.pods.entries) {
      final k = pod.key;
      final v = pod.value;
      final temp = ref == null ? v.value : v.watch(ref);
      if (temp != null) {
        results[k] = temp;
      }
    }
    return results;
  }

  //
  //
  //

  Future<void> dispose() async {
    await Future.forEach(this.pods.values, (final e) => e.dispose());
    this.pods.clear();
  }

  //
  //
  //

  Future<void> disposeIfRequested() async {
    await Future.forEach(this.pods.values, (final e) => e.disposeIfRequested());
    this.pods.clear();
  }
}

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class Pod<dynamic>Map<K> {
//   //
//   //
//   //

//   final Map<K, Pod<dynamic>> pods;

//   //
//   //
//   //

//   const Pod<dynamic>Map(this.pods);

//   //
//   //
//   //

//   Pod<dynamic>? operator [](K key) => pods[key];

//   //
//   //
//   //

//   void dispose() {
//     for (final b in this.pods.values) {
//       b.dispose();
//     }
//     this.pods.clear();
//   }
// }
