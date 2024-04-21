//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef XyzPod<T> = Pod<T>;
typedef XyzPodBuilder<T> = PodBuilder<T>;
typedef XyzPodListBuilder<T> = PodListBuilder;
typedef XyzPodListHelper<T> = PodListHelper<T>;
typedef XyzRespondingPodListBuilder = RespondingPodListBuilder;
typedef XyzPollingPodBuilder<T extends Pod<T>> = PollingPodBuilder<T>;

typedef TPodList<T> = Iterable<Pod<T>?>;
typedef TPodDataList<T> = Iterable<T>;
typedef TPodListResponder<T> = TPodList<T> Function();

typedef XyzPodServiceMixin = PodServiceMixin;

mixin PodServiceMixin {
  Future<void> startService();
  Future<void> stopService();
}
