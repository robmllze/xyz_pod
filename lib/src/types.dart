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

import '/xyz_pod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef XyzPod<T> = Pod<T>;
typedef XyzPodBuilder<T> = PodBuilder<T>;
typedef XyzPodListBuilder<T> = PodListBuilder;
typedef XyzPodListHelper<T> = PodListHelper<T>;
typedef XyzRespondingPodListBuilder = RespondingPodListBuilder;
typedef XyzPollingPodBuilder<T extends Pod<T>> = PollingPodBuilder<T>;

@Deprecated("This was renamed to `RespondingPodListBuilder`.")
typedef ResponsivePodListBuilder = RespondingPodListBuilder;

typedef TPodList<T extends Object?> = Iterable<Pod<T>?>;
typedef TPodDataList<T extends Object?> = Iterable<T>;
typedef TPodListResponder<T> = TPodList<T> Function();

typedef XyzPodServiceMixin = PodServiceMixin;

mixin PodServiceMixin {
  Future<void> startService();
  Future<void> stopService();
}
