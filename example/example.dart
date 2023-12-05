// -----------------------------------------------------------------------------
// Example of using a Pod to manage a counter.
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

// -----------------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'XYZ Pod Example',
      home: CounterPage(),
    );
  }
}

// -----------------------------------------------------------------------------

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  CounterPageState createState() => CounterPageState();
}

// -----------------------------------------------------------------------------

class CounterPageState extends State<CounterPage> {
  // Create a Pod of any type, including Lists, Maps, and custom objects.
  final Pod<int> pCounter = Pod<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XYZ Pod Counter Example'),
      ),
      body: Center(
        // Consume the value of the Pod in your UI.
        child: PodBuilder<int>(
          pod: pCounter,
          builder: (context, child, value) => Text(
            'Counter Value: ${value.toString()}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update the value of the Pod anywhere in your code.
          pCounter.update((value) => value + 1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the Pod when it is no longer needed.
    pCounter.dispose();
    super.dispose();
  }
}
