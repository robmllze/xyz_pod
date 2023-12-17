# XYZ Pod

[![pub package](https://img.shields.io/pub/v/xyz_pod.svg)](https://pub.dev/packages/xyz_pod)

## Examples

- [Example 1: A basic example on how to use a Pod and PodBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_builder/lib/main.dart)
- [Example 2: A basic example on how to use PodList, PodListHelper and PodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_builder/lib/main.dart)
- [Example 3: Modular Service-Based State Management with PodListRebuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_rebuilder/lib/main.dart)
- [Example 4: Temp Pods](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_temp_pods/lib/main.dart)

## Overview
`xyz_pod` is a Flutter package designed to enhance and simplify state management in Flutter applications. Building upon the capabilities of `ValueNotifier`, this package introduces several additional functionalities that streamline the state management process, making it more efficient and scalable. The recommended state management approach to pair with `xyz_pod` is the MSM (Modular Service-Based State Management) pattern. Further details on MSM can be found in [Example 3](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_rebuilder/lib/main.dart).

## Why Use Pod Over ValueNotifier?
`Pod<T>` extends `ValueNotifier<T>`, inheriting its fundamental capabilities while providing advanced features. It addresses some of the limitations of `ValueNotifier` by offering:
- State updates during the build phase, which `ValueNotifier` does not support.
- Improved handling of complex data types like lists and maps, where `ValueNotifier` requires manual notification.
- Easier handling of numerous state objects in PodListBuilder or PodListRebuilder, improving both responsiveness and upkeep. This differs from ValueListenableBuilder, which is limited to managing just one ValueNotifier object.

## Features

### Pod<T>
- **Extension of ValueNotifier**: Inherits and enhances `ValueNotifier<T>`.
- **State Updates During Build**: Allows state updates during the build phase.
- **Temporary Instances**: Includes functionality for marking instances as temporary for efficient resource management.
- **Value Setting and Updating**: Provides set, update, and refresh methods for state management.
- **Single Execution Listener**: Adds a listener that executes once and then removes itself.

### PodBuilder
- **Pod Listening**: Triggers UI rebuild on Pod data changes.
- **Builder Function**: Reconstructs the UI with every data change in the Pod.
- **Placeholder Builder Function**: For scenarios where no data is available.

### PodListBuilder
- **Pod List Management**: Manages a list of Pod objects and updates the UI in response.

### PodListRebuilder
- **Dynamic Pod List Generation**: Generates Pod lists dynamically for flexible list management.
- **Advanced Builder Function**: Rebuilds the widget as the list of Pod objects changes.

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