
// To activate, add "provider: ^6.0.5" to pubspec.yaml, and uncomment the code
// below.

/*

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - ProviderPod
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: unnecessary_this

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ProviderPod<T> extends ChangeNotifier {
  //
  //
  //

  T _value;

  //
  //
  //

  ProviderPod(this._value);

  //
  //
  //

  T get value => this._value;

  //
  //
  //

  set value(T value) {
    this._value = value;
    super.notifyListeners();
  }

  //
  //
  //

  ProviderPodScope<T> build(Widget Function(BuildContext, T) builder) {
    return ProviderPodScope<T>(
      pod: this,
      builder: builder,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ProviderPodScope<T> extends StatelessWidget {
  //
  //
  //

  final ProviderPod<T> pod;
  final Widget Function(BuildContext, T) builder;

  //
  //
  //

  const ProviderPodScope({
    super.key,
    required this.pod,
    required this.builder,
  });

  //
  //
  //

  @override
  Widget build(final context) {
    return ChangeNotifierProvider<ProviderPod<T>>(
      create: (_) => pod,
      child: Consumer<T>(
        builder: (final context, final value, _) {
          return this.builder(context, value);
        },
      ),
    );
  }
}

*/
