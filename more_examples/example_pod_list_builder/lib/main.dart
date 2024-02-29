//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev 
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
// 
// Licensing details can be found in the LICENSE file in the root directory.
// 
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:flutter/material.dart';

// Step 1: Import the package.
import 'package:xyz_pod/xyz_pod.dart';

// Step 2: Create a list of Pods with different types. You may wish to keep
// these Pods in a separate file that holds the global state of your app.
final pTemperature = Pod<double>(68.0);
final pWeatherCondition = Pod<String>("Sunny");

// Step 3: Create a helper class to make it easier to access the Pods. This is
// entirely optional, but it makes the code cleaner.
class WeatherPods extends PodListHelper {
  const WeatherPods();
  TPodList get pods => [pTemperature, pWeatherCondition];
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
              // Step 2: Use PodListBuilder to listen to changes in any of the Pods.
              PodListBuilder(
                podList: WeatherPods().pods,
                //pods: [pTemperature, pWeatherCondition], // This works too!
                builder: (context, child, pods) {
                  // Extracting values from the list of Pod values.
                  final temperature = WeatherPods().temperature;
                  //final temperature = pods.elementAt(0)!.value as double; // This works too!
                  final weatherCondition = WeatherPods().weatherCondition;
                  //final weatherCondition = pods.elementAt(1)!.value as String; // This works too!
                  return Text(
                    "Today is $weatherCondition and the temperature is $temperature°F.",
                  );
                },
              ),
              const SizedBox(height: 16.0),
              // Step 3: Update the Pods and watch the UI update.
              ElevatedButton(
                onPressed: () {
                  // Incrementing temperature.
                  pTemperature.update((temp) => temp + 1.0);
                },
                child: Text("Increase Temperature"),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Changing weather condition.
                  pWeatherCondition.set("Rainy");
                },
                child: Text("Change Weather Condition to Rainy"),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Changing weather condition.
                  pWeatherCondition.set("Snowy");
                },
                child: Text("Change Weather Condition to Snowy"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------

/*
  Summary:

  - `PodListBuilder` is a widget that can manage and respond to changes in
    multiple `Pod` objects.
  - It listens to a list of `Pod` objects and rebuilds its UI whenever any of
    the `Pod` objects change.
  - This example demonstrates a practical use of `PodListBuilder` to display
    weather information that updates in response to changes in `Pod` objects
    representing temperature and weather condition.
  - You may use a helper class to make it easier to access the `Pod` objects.
    This is entirely optional, but it makes the code cleaner.
  
  Additional Notes:

  - `PodListBuilder` is particularly useful in scenarios where UI needs to
    respond to changes in multiple
    state objects simultaneously.
  - It keeps the code clean and consolidated, as it handles all the `Pod`
    objects in one place.
*/