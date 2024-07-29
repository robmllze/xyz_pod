# Changelog

## [0.49.0]

- Released @ 2024-07-29 06:12:00.994304Z
- refactor: Improve Pod reducers to use standard Dart Tuples

## [0.48.0]

- Released @ 2024-07-28 11:02:30.211524Z
- refactor: Rename bind to bindParent and \_bind to bindChild for better understanding

## [0.47.0]

- Released @ 2024-07-28 07:51:18.834118Z
- chore: Update bind to use ChangeNotifier instead of ValueNotifier

## [0.46.0]

- Released @ 2024-07-28 07:50:15.816880Z
- refactor: Update Pod.bindWith method to use bind instead of bindWith

## [0.45.2]

- Released @ 2024-07-28 07:25:51.308863Z
- fix: Fix return type of bind method in BindWithMixin

## [0.45.1]

- Released @ 2024-07-28 07:21:19.009026Z
- chore: Update BindWithMixin to return ValueNotifier in bind method

## [0.45.0]

- Released @ 2024-07-28 07:17:41.670789Z
- chore: Update BindWithMixin to use ValueNotifier instead of Pod

## [0.44.0]

- Released @ 2024-07-28 06:54:01.784760Z
- chore: Add BindWithMixin to facilitate auto-disposal of Pods when the classes they're binded with dispose

## [0.43.2]

- Released @ 2024-07-28 04:30:25.278266Z
- refactor: Move static constructors from ChildPod to Pod and update comments
- chore: Update readme with a list of TODOs

## [0.43.1]

- Released @ 2024-07-27 17:35:40.894374Z
- fix: Fix type casting issue in ChildPod

## [0.43.0]

- Released @ 2024-07-27 17:34:44.653531Z
- refactor: Add static factory methods to ChildPod for reducing multiple Pods into a single ChildPod instance

## [0.42.0]

- Released @ 2024-07-27 17:05:53.656333Z
- refactor: Update Pod.map and Pod.mapToTemp to return ChildPod instead of Pod
- refactor: Update Pod reducers to support mapping multiple Pods into a single Pod

## [0.41.0]

- Released @ 2024-07-27 15:56:48.998275Z
- refactor: Update ChildPod class to support multiple parents

## [0.40.0]

- Released @ 2024-07-27 15:29:53.940834Z
- chore: Add ChildPod class for managing child pods in Pod
- chore: Update documentation links in README.md
