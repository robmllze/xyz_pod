# XYZ Pod

[![pub package](https://img.shields.io/pub/v/xyz_pod.svg)](https://pub.dev/packages/xyz_pod)

## Examples

- [Example 1: A basic example on how to use a Pod and PodBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_builder/lib/main.dart)
- [Example 2: A basic example on how to use PodList, PodListHelper and PodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_builder/lib/main.dart)
- [Example 3: Modular Service Based State Management with PodWatchListBuilder.](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_watch_list_builder/lib/main.dart)
- [Example 4: Temp Pods.](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_temp_pods/lib/main.dart)

## Overview
`xyz_pod` is a Flutter package designed to enhance and simplify state management in Flutter applications. Building upon the capabilities of `ValueNotifier`, this package introduces several additional functionalities that streamline the state management process, making it more efficient and scalable.

## Why Use Pod Over ValueNotifier?
`Pod<T>` extends `ValueNotifier<T>`, inheriting its fundamental capabilities while providing advanced features. It addresses some of the limitations of `ValueNotifier` by offering:
- Asynchronous state updates, ensuring the UI reflects the most recent state.
- Improved handling of complex data types like lists and maps, where `ValueNotifier` requires manual notification.
- Simplified management of multiple state objects within a single widget, enhancing reactivity and maintainability.

## Features

### Pod<T>
- **Extension of ValueNotifier**: Inherits and enhances `ValueNotifier<T>`.
- **Asynchronous State Updates**: Allows for asynchronous state updates, keeping the Pod's state current.
- **Temporary Instances**: Includes functionality for marking instances as temporary for efficient resource management.
- **Generic Type Parameter**: Generic class with the type parameter `T` for flexible data handling.
- **Constructors**: Offers standard and specialized constructors for Pod creation.
- **Value Setting and Updating**: Provides set, update, and refresh methods for state management.
- **Single Execution Listener**: Adds a listener that executes once and then removes itself.

### PodBuilder
- **Generic Type Support**: Works with different data types.
- **Pod Listening**: Triggers UI rebuild on Pod data changes.
- **Builder Function**: Reconstructs the UI with every data change in the Pod.
- **Placeholder Builder Function**: For scenarios where no data is available.
- **State Management**: Manages widget's state effectively.

### PodListBuilder
- **Pod List Management**: Manages a list of Pod objects and updates the UI in response.
- **Stateful Widget**: Maintains state changes throughout the widget's lifecycle.
- **Builder Function**: Rebuilds the widget with changes in any Pod objects in the list.

### PodWatchListBuilder
- **Dynamic Pod List Generation**: Generates Pod lists dynamically for flexible list management.
- **Advanced Builder Function**: Rebuilds the widget as the list of Pod objects changes.
- **State Management**: Focuses on managing dynamic data states.

## Advantages Over ValueNotifier
- **Simplified State Management**: Eases managing complex data types, automating updates.
- **Multi-State Management**: Allows handling multiple state objects within a single widget.
- **Safe and Consistent State Updates**: Ensures asynchronous and safe state changes.

## Example: Basic Usage of PodList, PodListHelper, and PodListBuilder

```dart
import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

final pTemperature = Pod<double>(68.0);
final pWeatherCondition = Pod<String>("Sunny");

class WeatherPods extends PodListHelper {
  const WeatherPods();
  PodList get pods => [pTemperature, pWeatherCondition];
  double get temperature => pods.elementAt(0)!.value as double;
  String get weatherCondition => pods.elementAt(1)!.value as String;
}

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PodListBuilder(
                pods: WeatherPods().pods,
                builder: (context, child, pods) {
                  final temperature = WeatherPods().temperature;
                  final weatherCondition = WeatherPods().weatherCondition;
                  return Text(
                    "Today is $weatherCondition and the temperature is $temperature°F.",
                  );
                },
              ),
              // ... Additional UI and Button to update Pods ...
            ],
          ),
        ),
      ),
    ),
  );
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