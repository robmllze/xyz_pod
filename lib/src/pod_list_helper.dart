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

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class PodListHelper<T extends Object?> {
  //
  //
  //

  const PodListHelper();

  //
  //
  //

  TPodList<T> get pods;

  //
  //
  //

  /// Disposes all `Pod` objects in the list. This method should be called when
  /// the `Pod` objects are no longer needed, to release resources.
  void dispose() {
    for (final pod in pods) {
      pod?.dispose();
    }
  }

  //
  //
  //

  /// Disposes only those `Pod` objects in the list that are marked as
  /// temporary. This method is useful for selectively releasing resources used
  /// by temporary `Pod` objects.
  void disposeIfMarkedAsTemp() {
    for (final pod in pods) {
      pod?.disposeIfMarkedAsTemp();
    }
  }
}