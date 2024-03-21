//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
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

// Step 2: Create a Pod of any type, that's initially null.
Pod<int>? pCounter;

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Step 3: Use the PollingPodBuilder widget to listen to changes in the
              // Pods.
              PollingPodBuilder(
                podPoller: () => pCounter,
                builder: (context, child, counter) {
                  return Text(
                    "pCounter's value: $counter",
                  );
                },
                placeholderBuilder: (context, child) {
                  return const Text("Waiting for pCounter's value...");
                },
              ),
              const SizedBox(height: 16.0),
              // Step 4: Use the Pod's update method to update the value.
              ElevatedButton(
                onPressed: () {
                  // If the Pod is null, we'll initialize it with a value of 0.
                  pCounter ??= Pod<int>(0);

                  // Then we'll update the value.
                  pCounter!.update((e) => ++e);
                },
                child: const Text("Increment pCounter's value"),
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

  - A PollingPodBuilder is a widget designed to pair with a Pod. It repeatedly
    calls the podPoller function to get the Pod it should listen to until the
    Pod is no longer null. It then listens for any updates in its associated Pod
    and invokes its builder function each time there's a change.

  Additional Notes:

  - Do not add any other logic in the podPoller function other than returning
    the Pod. Since the podPoller function is called repeatedly until, any
    additional logic will be executed repeatedly as well and may cause
    performance issues.
 */
