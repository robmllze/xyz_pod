//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A wrapper for the [RespondingPodListBuilder] that provides a simpler
/// solution.
class RespondingBuilder<T> extends StatelessWidget {
  //
  //
  //

  final TPodListResponder podListResponder;
  final T? Function() getData;
  final bool Function(T data)? isUsableData;
  final TRespondingBuilder<T> builder;
  final Widget? child;

  //
  //
  //

  const RespondingBuilder({
    super.key,
    required this.podListResponder,
    required this.getData,
    required this.builder,
    this.child,
    this.isUsableData,
  });

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return RespondingPodListBuilder(
      podListResponder: podListResponder,
      builder: (context, staticChild, _) {
        final data = this.getData();
        final hasData = data is T;
        final hasUsableData =
            hasData && (this.isUsableData?.call(data) ?? true);
        final snapshot = RespondingBuilderSnapshot<T>(
          data: data,
          hasData: hasData,
          hasUsableData: hasUsableData,
        );
        final widget = this.builder(
          context,
          staticChild,
          snapshot,
        );
        return widget;
      },
      child: this.child,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class RespondingBuilderSnapshot<T> {
  //
  //
  //

  final T? data;
  final bool hasData;
  final bool hasUsableData;

  //
  //
  //

  RespondingBuilderSnapshot({
    required this.data,
    required this.hasData,
    required this.hasUsableData,
  });
}
