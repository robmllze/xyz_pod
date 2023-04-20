// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - PodMap
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: unnecessary_this

import 'pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A collection of Pods associated with a key.
///
/// Provides a way to dispose all the Pods at once and access them via their key.
class PodMap<K, V, P extends Pod<V>> {
  //
  //
  //

  final Map<K, P> pods;

  //
  //
  //

  const PodMap(this.pods);

  //
  //
  //

  P? operator [](K key) => pods[key];

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

  void dispose() {
    for (final b in this.pods.values) {
      b.dispose();
    }
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
