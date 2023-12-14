# XYZ Pod

XYZ Pod (xyz_pod) is a Flutter package designed to streamline and enhance state management in Flutter applications. It offers a suite of tools including `Pod`, `PodBuilder`, `PodListBuilder`, `PodRemapper`, classes, each tailored to handle different aspects of state management with ease and flexibility.

## Features

- **Pod**: A flexible state management object that notifies listeners of changes.
- **PodBuilder**: A widget for building UIs in response to changes in a `Pod` object.
- **PodListBuilder**: Manages a list of `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.
- **PodRemapper**: Manages a chain of `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.

## Preferred Over ValueNotifier

### Simplified State Management with Complex Types

The Pod class simplifies state management, especially when dealing with complex data types like lists, maps, and custom objects. Unlike ValueNotifier, which may require explicit calls to notifyListeners for complex data types, Pod handles these updates automatically. This reduces the boilerplate code and potential for errors, making your state management more efficient and reliable.

### Multi-State Management with PodListBuilder

With the PodListBuilder, you can effortlessly manage and respond to changes in multiple state objects within a single widget. This capability is a significant enhancement over the traditional ValueNotifier, which requires manual management of multiple listeners and can quickly become cumbersome in complex applications.

### Chain State Management with PodRemapper

The PodRemapper represents an evolution in state management for Flutter applications. It goes beyond the linear chaining of Pod objects, providing a more flexible and dynamic way to listen to and remap state from multiple sources. With PodRemapper, developers can easily orchestrate state dependencies and transformations across different parts of their application, enhancing both modularity and responsiveness in handling complex state scenarios.

### Safe and Consistent State Updates

A standout feature of Pod is its use of Future.delayed(Duration.zero) for state updates, ensuring that changes are applied asynchronously and safely. This approach prevents common issues associated with modifying state during the build phase of the widget tree, a challenge often encountered with ValueNotifier. By automatically scheduling updates to the next event loop cycle, Pod ensures consistent and error-free UI updates.

## Getting Started

To use XYZ Pod in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  xyz_pod: any
```

## Using the PodBuilder

```dart
// 1. Import the package.
import 'package:xyz_pod/xyz_pod.dart';

// 2. Create a Pod of any type, including Lists, Maps, and custom objects.
final pCounter = Pod<int>(0);

// 3. Consume the value of the Pod in your UI.
PodBuilder(
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

## Using the PodListBuilder

```dart
// 1. Define your Pods.

final pCounter = Pod<int>(0);
final pUserData = Pod<Map<String, dynamic>>({});
final pIsSignedIn = Pod<bool>(false);

// 2. Consume the values of the Pods in your UI.

PodListBuilder(
  pods: [pCounter, pUserData, pIsSignedIn],
  builder: (values) => Text("${values.firstOrNull}"),
)
```

## Using the PodRemapper

```dart
// Define your service classes and models.

class AuthService {
  final userDataService = UserDataService();
}

class UserDataService {
  final pUserData = Pod<UserDataModel?>(null);
}

class UserDataModel {
  final String name;
  UserDataModel(this.name);

  // Implement fromJson, toJson, etc., as needed.
}

// Create a Pod for your service.

final pAuthService = Pod(AuthService());

// Set up PodRemappers for your service chain.

PodRemappers authServiceRemappers = [
  remap<AuthService, UserDataModel?>((e) => [e.userDataService.pUserData]),
];

// Use the PodRemapper in your UI to dynamically update based on Pod changes.

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: PodRemapper<UserDataModel>(
            pods: [pAuthService],
            remappers: authServiceRemappers,
            builder: (context, child, values) {
              final userData = values.first; // values will never be empty.
              return Text(userData?.name ?? 'User Name Unavailable');
            },
            emptyBuilder: (context, child) => Text("Loading..."),
          ),
        ),
      ),
    ),
  );
}

// Ensure proper disposal of Pods when no longer needed.

void disposeServices() {
  pAuthService.value.userDataService.pUserData.dispose();
  pAuthService.dispose();
}

```

## Contributing

Contributions to XYZ Pod are welcome.

## License

This package is released under the MIT License.

## Contact

**Author:** Robert Mollentze

**Email:** robmllze@gmail.com

For more information, questions, or feedback, feel free to contact me.