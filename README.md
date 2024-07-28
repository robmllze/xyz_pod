# 🇽🇾🇿 Pod

This package simplifies state management in Flutter applications and is well-suited for use with a Modular Services State Management (MSSM) pattern.

[![pub package](https://img.shields.io/pub/v/xyz_pod.svg)](https://pub.dev/packages/xyz_pod)

## Installation

Use this package as a dependency by adding it to your `pubspec.yaml` file (see [here](https://pub.dev/packages/xyz_pod/install)).

## Documentation

🔜 Documentation and video tutorials are coming soon. Feel free to contact me for more information.

## Resources

### Examples:

- [Example 1: A basic example on how to use a Pod and PodBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_builder/lib/main.dart)
- [Example 2: A basic example on how to use PodList, PodListHelper and PodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_pod_list_builder/lib/main.dart)
- [Example 3: Modular Services State Management with RespondingPodListBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_responding_pod_list_builder/lib/main.dart)
- [Example 4: A basic example on how to use a PollingPodBuilder](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_polling_pod_builder/lib/main.dart)
- [Example 5: Temp Pods](https://github.com/robmllze/xyz_pod/blob/main/more_examples/example_temp_pods/lib/main.dart)

### Slides (Outdated):

- [Modular Services State Management and Leveraging Pods for Flutter](https://docs.google.com/presentation/d/11lI1OmV06dB7GMnVSKnna-Yu5s2A1OgMLRbnFEI2m8w/edit?usp=sharing)

### Here is a basic example on how to use a Pod and PodBuilder:

```dart
import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

final pTemperature = Pod<double>(68.0);
final pWeatherCondition = Pod<String>('Sunny');

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
                    'Today is $weatherCondition and the temperature is $temperature°F.',
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

## Contributing and Discussions

This is an open-source project, and contributions are welcome from everyone, regardless of experience level. Contributing to projects is a great way to learn, share knowledge, and showcase your skills to the community. Join the discussions to ask questions, report bugs, suggest features, share ideas, or find out how you can contribute.

### TODO:

- [ ] Set up automatic publishing with GitHub.
- [ ] Write more examples for developers.
- [ ] Write Flutter tests for each feature.
- [ ] Add comments where absent.
- [ ] Improve comments.
- [ ] Improve file structure.
- [ ] Write a manual.
- [ ] Update the slide.
- [ ] Write a blog post.
- [ ] Add a video tutorial.
- [ ] Compare with other state management solutions and see where we can improve.
- [ ] Seek advice and feedback from community.
- [ ] Add useful content to GitHub and Reddit discussions.

### Join GitHub Discussions:

💬 https://github.com/robmllze/xyz_pod/discussions

### Join Reddit Discussions:

💬 https://www.reddit.com/r/xyz_pod/

### Chief Maintainer:

📧 Email _Robert Mollentze_ at robmllze@gmail.com

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/xyz_pod/main/LICENSE) for more information.
