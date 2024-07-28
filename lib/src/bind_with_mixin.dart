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

/// A mixin for classes that need to implement a `dispose` method.
mixin Disposable {
  void dispose();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A mixin to manage the disposal of `Pod` instances.
mixin BindWithMixin on Disposable {
  //
  //
  //

  @protected
  final List<ChangeNotifier> $children = [];

  //
  //
  //

  /// Binds the ChangeNotifier [child] to this (the parent) so that the child
  /// will be disposed when this is disposed.
  T bindChild<T extends ChangeNotifier>(T child) {
    $children.add(child);
    return child;
  }

  //
  //
  //

  @override
  void dispose() {
    for (final child in $children) {
      child.dispose();
    }
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension BindParentOnChangeNotifierExtension<T extends ChangeNotifier> on T {
  /// Binds this ChangeNotifier to [parent] so that it will be disposed when [parent] is disposed.
  T bindParent(BindWithMixin parent) => parent.bindChild(this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class _StatefulWidgetWithDisposable<T extends StatefulWidget> extends State<T>
    implements Disposable {}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Use `BindWithMixinState<T>` instead of `State<T>` to incorporate
/// `BindWithMixin`.
///
/// Example:
/// ```dart
/// class _MyWidgetState extends BindWithMixinState<MyWidget> {
///   late final pStatus = Pod<String>('init', bindWith: this);
/// }
/// ```
abstract class BindWithMixinState<T extends StatefulWidget> extends _StatefulWidgetWithDisposable<T>
    with BindWithMixin {}
