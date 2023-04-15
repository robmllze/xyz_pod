// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - RiverpodPod
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: unnecessary_this

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class RiverpodPod<T> extends StateNotifier<T> {
  //
  //
  //

  late final StateNotifierProvider provider;

  //
  //
  //

  RiverpodPod(T value) : super(value) {
    this.provider = StateNotifierProvider((_) => this);

    //
    //
    //

    T getData() => super.state;

    //
    //
    //

    void setData(T value) => super.state = value;

    //
    //
    //

    RiverpodPodScope<T> build(Widget Function(BuildContext, T) builder) {
      return RiverpodPodScope<T>(
        pod: this,
        builder: builder,
      );
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class RiverpodPodScope<T> extends StatelessWidget {
  //
  //
  //

  final RiverpodPod<T> pod;
  final Widget Function(BuildContext, T) builder;

  //
  //
  //

  /// NOTE: Must wrap the application with a [ProviderScope].
  const RiverpodPodScope({
    super.key,
    required this.pod,
    required this.builder,
  });

  //
  //
  //

  @override
  Widget build(final context) {
    return Consumer(
      builder: (final context, final ref, _) {
        final value = ref.watch(pod.provider);
        return this.builder(context, value);
      },
    );
  }
}
