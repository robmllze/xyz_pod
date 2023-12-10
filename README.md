# XYZ Pod

XYZ Pod is a Flutter package designed to streamline and enhance state management in Flutter applications. It offers a suite of tools including `Pod`, `PodBuilder`, `PodListBuilder`, `MultiPodBuilder`, and `Pods` classes, each tailored to handle different aspects of state management with ease and flexibility.

## Features

- **Pod**: A flexible state management object that notifies listeners of changes.
- **PodBuilder**: A widget for building UIs in response to changes in a `Pod` object.
- **PodListBuilder**: Manages a list of `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.
- **MultiPodBuilder**: Manages up to 26 `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.
- **Pods**: A class that encapsulates up to 26 `Pod` objects of different types for comprehensive state management.

## Preferred Over ValueNotifier

### Simplified State Management with Complex Types

The Pod class in XYZ Pod package simplifies state management, especially when dealing with complex data types like lists, maps, and custom objects. Unlike ValueNotifier, which may require explicit calls to notifyListeners for complex data types, Pod handles these updates automatically. This reduces the boilerplate code and potential for errors, making your state management more efficient and reliable.

### Multi-State Management with PodListBuilder and MultiPodBuilder

With XYZ Pod’s PodListBuilder and MultiPodBuilder, you can effortlessly manage and respond to changes in multiple state objects within a single widget. This capability is a significant enhancement over the traditional ValueNotifier, which requires manual management of multiple listeners and can quickly become cumbersome in complex applications.

### Safe and Consistent State Updates
A standout feature of Pod is its use of Future.delayed(Duration.zero) for state updates, ensuring that changes are applied asynchronously and safely. This approach prevents common issues associated with modifying state during the build phase of the widget tree, a challenge often encountered with ValueNotifier. By automatically scheduling updates to the next event loop cycle, Pod ensures consistent and error-free UI updates.

## Getting Started

To use XYZ Pod in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  xyz_pod: ^0.6.0
```

## Usage

```dart
// 1. Import the package.
import 'package:xyz_pod/xyz_pod.dart';

// 2. Create a Pod of any type, including Lists, Maps, and custom objects.
final pCounter = Pod<int>(0);

// 3. Consume the value of the Pod in your UI.
PodBuilder.value(
  pod: pCounter,
  builder: (counter) => Text("${counter}"),
)

// 4. Set the value of the Pod anywhere in your code.
void resetCounter() => pCounter.set(0);

// 5. Update the value of the Pod anywere in your code.
TextButton(
  onPressed: () => pCounter.update((value) => value + 1),
  child: Text("Increment"),
)

// 6. Dispose the Pod when it is no longer needed.
void dispose() {
  pCounter.dispose();
  super.dispose();
}
```

## Contributing

Contributions to XYZ Pod are welcome.

## License

XYZ Pod is released under the MIT License.

## Contact

Author: robmllze
Email: robmllze@gmail.com

For more information, questions, or feedback, feel free to contact me.