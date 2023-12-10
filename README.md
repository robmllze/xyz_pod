# XYZ Pod

XYZ Pod (xyz_pod) is a Flutter package designed to streamline and enhance state management in Flutter applications. It offers a suite of tools including `Pod`, `PodBuilder`, `PodListBuilder`, `PodChainBuilder`, classes, each tailored to handle different aspects of state management with ease and flexibility.

## Features

- **Pod**: A flexible state management object that notifies listeners of changes.
- **PodBuilder**: A widget for building UIs in response to changes in a `Pod` object.
- **PodListBuilder**: Manages a list of `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.
- **PodChainBuilder**: Manages a chain of `Pod` objects and rebuilds child widgets in response to changes in any of these `Pod` objects.

## Preferred Over ValueNotifier

### Simplified State Management with Complex Types

The Pod class simplifies state management, especially when dealing with complex data types like lists, maps, and custom objects. Unlike ValueNotifier, which may require explicit calls to notifyListeners for complex data types, Pod handles these updates automatically. This reduces the boilerplate code and potential for errors, making your state management more efficient and reliable.

### Multi-State Management with PodListBuilder

With the PodListBuilder, you can effortlessly manage and respond to changes in multiple state objects within a single widget. This capability is a significant enhancement over the traditional ValueNotifier, which requires manual management of multiple listeners and can quickly become cumbersome in complex applications.

### Chain State Management with PodChainBuilder

The PodChainBuilder is designed to handle a sequence or "chain" of Pod objects. It extends the capabilities of individual Pods by allowing developers to manage and respond to changes across a series of interconnected state objects.

### Safe and Consistent State Updates
A standout feature of Pod is its use of Future.delayed(Duration.zero) for state updates, ensuring that changes are applied asynchronously and safely. This approach prevents common issues associated with modifying state during the build phase of the widget tree, a challenge often encountered with ValueNotifier. By automatically scheduling updates to the next event loop cycle, Pod ensures consistent and error-free UI updates.

## Getting Started

To use XYZ Pod in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  xyz_pod: ^0.7.2
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

## Using the PodChainBuilder

```dart
// 1. Create some service chain.

class AuthService {
  final userDataService = UserDataService();
  final newsUpdatesService = NewsUpdatesService();
}

class UserDataService {
  final pUserData = Pod<UserDataModel?>(null);
}

class UserDataModel {
  // ... fromJson, toJson, etc.
}

class NewsUpdatesService {
  final pNewsUpdatesData = Pod<NewsUpdatesDataModel?>(null);
}

class NewsUpdatesDataModel {
  // ... fromJson, toJson, etc.
}

// 2. Create a Pod for the service chain.

final pAuthService = Pod(AuthService());

// 3. Consume the values of the Pods in your UI.

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                await pAuthService.value.userDataService.pUserData.update((e) => e..name = "Bob");
              },
              child: Text("Call me Bob"),
            ),
            PodChainBuilder(
              pod: pAuthService,
              mapper: (e) => e?.userDataService.pUserData,
              builder: (value) => Text(value.name),
            ),
          ],
        ),
      ),
    ),
  );
}

// 4. Dispose the Pods when they are no longer needed. You may want to create dispose methods for each service.

void dispose() {
  pAuthService.value.userDataService.pUserData.dispose();
  pAuthService.value.newsUpdatesService.pNewsUpdatesData.dispose();
  pAuthService.dispose();
  super.dispose();
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