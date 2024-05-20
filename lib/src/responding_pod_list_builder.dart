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

/// A widget that rebuilds its child in response to changes in a dynamically
/// determined list of Pod instances.
///
/// This widget monitors a collection of Pod instances, specified by a
/// responder function, for updates. It intelligently rebuilds its child widget
/// whenever any observed Pod instance changes. This setup ensures the UI
/// always reflects the most current data state. The dynamic nature of the
/// `podListResponder` allows for a responsive design that adapts to changes in
/// pod dependencies, enabling the observation of pods that may initially be
/// null but become non-null as application state changes.
///
/// The observation starts when the widget enters the tree and halts upon its
/// removal, optimizing resource consumption by limiting updates to active and
/// visible periods. This design supports the construction of real-time,
/// data-driven interfaces that maintain optimal performance and user
/// experience.
///
/// Example Usage:
/// ```dart
/// final pUserService = Pod<UserService?>(null);
/// final userService = await UserService.create();
/// pUserService.set(userService);
///
/// TPodList userPlr() => [
///   pUserService,
///   pUserService.value?.pUser,
/// ];
///
/// UserModel? userSnapshot() => pUserService.value?.pUser.value;
///
/// ResponsivePodListBuilder(
///   podListResponder: userPlr,
///   builder: (context, child, values) {
///     final user = userSnapshot();
///     if (user != null) {
///       return Text('User: ${user.email}');
///     }
///     return Container(); // Use Container or another fallback for null data.
///   },
/// )
/// ```
///
/// ### Parameters:
/// - `key`: An optional key to use for the widget.
/// - `podListResponder`: A function returning a list of Pod instances to
///   observe. It is called each time a pod in the list changes, ensuring
///   dynamic adaptation to the evolving application state. This mechanism
///   allows for a chain of dependent pods, where updates to one pod can
///   activate or deactivate the observation of others, based on their current
///   state.
/// - `builder`: A function that rebuilds the widget based on the current
///   states of the observed Pods. It receives the build context, the optional
///   `child` widget, and the values from the observed pods returned by
///   `podListResponder`.
/// - `child`: An optional child widget that is passed to the `builder`, useful
///   for optimization if the child is part of a larger widget that does not
///   need to rebuild.
class RespondingPodListBuilder extends StatefulWidget {
  //
  //
  //

  /// A function that returns a `PodList`. This function is called to obtain
  /// the current list of `Pod` objects to be observed. Changes in the returned
  /// list will trigger the widget to rebuild.
  final TPodListResponder podListResponder;

  //
  //
  //

  /// A function to rebuild the widget based on the data received from
  /// [podListResponder].
  final Widget Function(
    BuildContext context,
    Widget? child,
    TPodDataList data,
  ) builder;

  //
  //
  //

  /// An optional static child widget that is passed to the [builder].
  final Widget? child;

  //
  //
  //

  /// An optional function to call when the widget is disposed.
  final void Function()? onDispose;

  //
  //
  //

  /// Creates a `RespondingPodListBuilder` widget.
  ///
  /// ### Parameters:
  /// - `key`: An optional key to use for the widget.
  /// - `podListResponder`: A function returning a list of Pod instances to
  ///   observe. It is called each time a pod in the list changes, ensuring
  ///   dynamic adaptation to the evolving application state. This mechanism
  ///   allows for a chain of dependent pods, where updates to one pod can
  ///   activate or deactivate the observation of others, based on their current
  ///   state.
  /// - `builder`: A function that constructs the widget based on the current
  ///   states of the observed Pod instances. It receives the build context,
  ///   an optional child widget, and the values from the observed pods, enabling
  ///   dynamic and responsive UI updates.
  /// - `child`: An optional child widget that is passed to the `builder` and,
  ///   useful for optimization if the child is part of a larger widget that
  ///   does not need to rebuild.
  /// - `onDispose`: An optional function to call when the widget is disposed.
  const RespondingPodListBuilder({
    super.key,
    required this.podListResponder,
    required this.builder,
    this.child,
    this.onDispose,
  });

  //
  //
  //

  @override
  State<RespondingPodListBuilder> createState() =>
      _RespondingPodListBuilderState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _RespondingPodListBuilderState extends State<RespondingPodListBuilder> {
  //
  //
  //

  late final Widget? _staticChild;

  //
  //
  //

  TPodList _currentWatchList = {};

  //
  //
  //

  @override
  void initState() {
    super.initState();
    _staticChild = widget.child;
    _currentWatchList = widget.podListResponder();
    _addListenerToPods(_currentWatchList);
  }

  //
  //
  //

  @override
  void didUpdateWidget(RespondingPodListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.podListResponder != widget.podListResponder) {
      _removeListenerFromPods(_currentWatchList);
      _currentWatchList = widget.podListResponder();
      _addListenerToPods(_currentWatchList);
    }
  }

  //
  //
  //

  void _addListenerToPods(TPodList pods) {
    for (final pod in pods) {
      pod?.addListener(_update);
    }
  }

  //
  //
  //

  void _removeListenerFromPods(TPodList pods) {
    for (final pod in pods) {
      pod?.removeListener(_update);
    }
  }

  //
  //
  //

  void _update() {
    final newPods = widget.podListResponder();
    _removeListenerFromPods(_currentWatchList);
    _currentWatchList = newPods;
    _addListenerToPods(_currentWatchList);
    if (mounted) {
      setState(() {});
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    final values = _currentWatchList.map((pod) => pod?.value);
    return widget.builder(
      context,
      _staticChild,
      values,
    );
  }

  //
  //
  //

  @override
  void dispose() {
    for (final pod in _currentWatchList) {
      pod?.removeListener(_update);
      pod?.disposeIfMarkedAsTemp();
    }
    widget.onDispose?.call();
    super.dispose();
  }
}
