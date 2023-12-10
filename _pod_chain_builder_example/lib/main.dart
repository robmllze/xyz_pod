// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

// -----------------------------------------------------------------------------

class Service {
  final subService = SubService();
}

// -----------------------------------------------------------------------------

class SubService {
  final Pod<int> pCounter = Pod<int>(0);
}

// -----------------------------------------------------------------------------

final pService = Pod<Service>(Service());

// -----------------------------------------------------------------------------

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                pService.value.subService.pCounter.value++;
              },
              child: Text("Increment"),
            ),
            PodChainBuilder.value(
              pod: pService,
              mapper: (e) => e?.subService.pCounter,
              builder: (value) => Text(value.toString()),
            ),
          ],
        ),
      ),
    ),
  );
}
