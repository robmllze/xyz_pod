// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

// -----------------------------------------------------------------------------

class Service {
  Service() {
    print("Service created");
  }
  final pSubService = Pod<SubService?>(null);

  static Pod<dynamic>? subSubServiceCounterMapper(e) {
    switch (e.runtimeType) {
      case Service:
        return (e as Service).pSubService;
      case SubService:
        return (e as SubService).pSubSubService;
      case SubSubService:
        return (e as SubSubService).pCounter;
      default:
        return null;
    }
  }
}

// -----------------------------------------------------------------------------

class SubService {
  SubService() {
    print("SubService created");
  }
  final pSubSubService = Pod<SubSubService?>(null);
}

// -----------------------------------------------------------------------------

class SubSubService {
  SubSubService() {
    print("SubSubService created");
  }
  final Pod<int> pCounter = Pod<int>(0);
}

// -----------------------------------------------------------------------------

final Pod<Service?> pService = Pod<Service?>(null);

// -----------------------------------------------------------------------------

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                pService.set(Service());
              },
              child: Text("Init Service"),
            ),
            TextButton(
              onPressed: () {
                pService.value?.pSubService.set(SubService());
              },
              child: Text("Init SubService"),
            ),
            TextButton(
              onPressed: () {
                pService.value?.pSubService.value?.pSubSubService
                    .set(SubSubService());
              },
              child: Text("Init SubSubService"),
            ),
            TextButton(
              onPressed: () {
                pService
                    .value?.pSubService.value?.pSubSubService.value?.pCounter
                    .update((e) => e + 1);
              },
              child: Text("Increment pCounter"),
            ),
            PodChainBuilder(
              pod: Pod.temp(123),
              builder: (value) => Text(value.toString()),
            ),
            PodChainBuilder<Service?, int>(
              pod: pService,
              mapper: Service.subSubServiceCounterMapper,
              builder: (value) {
                print("${value.runtimeType}");
                return Text(value.toString());
              },
            ),
          ],
        ),
      ),
    ),
  );
}
