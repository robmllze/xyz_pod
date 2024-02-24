# 🇽🇾🇿 Pod

This package is designed to simplify state management in Flutter applications and is well-suited for use with the Modular Services State Management (MSSM) pattern.

[![pub package](https://img.shields.io/pub/v/xyz_pod.svg)](https://pub.dev/packages/xyz_pod)

## Documentation

🔜 Documentation and video tutorials are coming soon. Feel free to contact me for more information.

### Here are some resources to help you get started:

#### Slides

- [Modular Services State Management and Leveraging Pods for Flutter](https://docs.google.com/presentation/d/11lI1OmV06dB7GMnVSKnna-Yu5s2A1OgMLRbnFEI2m8w/edit?usp=sharing)

## Examples

### Here are some examples to help you get started:

- [Example 1: A basic example on how to use a Pod and PodBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_builder/lib/main.dart)
- [Example 2: A basic example on how to use PodList, PodListHelper and PodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_builder/lib/main.dart)
- [Example 3: Modular Services State Management with RespondingPodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_responding_pod_list_builder/lib/main.dart)
- [Example 4: Temp Pods](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_temp_pods/lib/main.dart)

### Here is a basic example on how to use a Pod and PodBuilder:

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

Contributions are welcome. Here are a few ways you can help:

- Report bugs and make feature requests.
- Add new features.
- Improve the existing code.
- Help with documentation and tutorials.

## License

This package is released under the MIT License.

## Contact

**Author:** Robert Mollentze

**Email:** robmllze@gmail.com