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

typedef TPodList<T extends Object?> = Iterable<Pod<T>?>;
typedef TPodDataList<T extends Object?> = Iterable<T>;
typedef TPodListResponder<T extends Object?> = TPodList<T> Function();

typedef XyzPodServiceMixin = PodServiceMixin;

typedef TOnDataBuilder<T> = Widget Function(
  BuildContext context,
  Widget? child,
  T snapshot,
);

typedef TOnLoadingBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

typedef TOnNoDataBuilder = Widget Function(
  BuildContext context,
  Widget? child,
);

typedef TRespondingBuilder<T> = Widget Function(
  BuildContext context,
  Widget? child,
  RespondingBuilderSnapshot<T> snapshot,
);

mixin PodServiceMixin {
  Future<void> startService();
  Future<void> stopService();
}
