// -----------------------------------------------------------------------------
//
// Example 1: A basic example on how to use a Pod and PodBuilder.
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

// Step 1: Import the package.
import 'package:xyz_pod/xyz_pod.dart';

// Step 2: Create a Pod of any type.
final pCounter = Pod<int>(0);
final pCounterList = Pod<List<int>>([0]);

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Step 3: Use the PodBuilder widget to listen to changes in the
              // Pods.
              PodBuilder(
                pod: pCounter,
                builder: (context, child, counter) {
                  return Text(
                    "pCounter's value: $counter",
                  );
                },
                // This is optional.
                child: null,
              ),
              const SizedBox(height: 16.0),
              PodBuilder(
                pod: pCounterList,
                builder: (context, child, counterList) {
                  return Text(
                    "pCounterList's first value: ${counterList.firstOrNull}",
                  );
                },
              ),
              const SizedBox(height: 16.0),
              // Step 4: Use the Pod's update method to update the value.
              ElevatedButton(
                onPressed: () {
                  pCounter.update((e) => ++e);

                  /*
                  // This works too, and is safe to use even during a build:

                  pCounter.value++;
                  
                  // This won't work, since we're returning the value first then
                  // incrementing it instead of incrementing it first then
                  // returning it:
                  
                  pCounter.update((e) => e++); // e++ vs. ++e
                  */
                },
                child: Text("Increment pCounter's value"),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  pCounterList.update((e) => e..first = e.first + 1);

                  /*
                  // This works too, but it's creating a new list every time
                  // which is unnecessary:

                  pCounterList.value = [pCounterList.value.first + 1];
                  
                  // This won't work, because the notifiers won't be
                  // called to let the PodBuilders know that they need to
                  // rebuild. This is because the list is still the same list,
                  // but with a different first value:

                  pCounterList.value.first++;
                  pCounterList.value.first = pCounterList.value.first + 1;

                  // So rather use the the update method because it's will
                  // always let the PodBuilders know that they need to rebuild
                  // even if you update the value with the same value:
                  */
                },
                child: Text("Increment pCounterList's first value"),
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

  - A Pod is a safer ValueNotifier.
  - A PodBuilder is a widget designed to pair with a Pod. It actively listens
    for any updates in its associated Pod and invokes its builder function each
    time there's a change in the connected Pod. It works exactly the same as
    the native ValueListenableBuilder.

  Additional Notes:

  - A ValueListenableBuilder can be used instead of a PodBuilder but it's
    recommended to use a PodBuilder for the following reasons:
    - Pods can be marked as "temp" when you create them, and PodBuilders will
      dispose of Pods marked as "temp" when they themselves get automatically
      disposed of.
    - Future versions of PodBuilder may have additional features that
      ValueListenableBuilder doesn't have.
    - As well as the "update" method, Pods also have a "set" method and a
      "refresh" method.
    - The Pod class is quite simple so if you want to know more about it, you
      can just read the source code.
 */
