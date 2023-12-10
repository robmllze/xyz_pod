import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

final pTest = Pod<Pod<Pod<int>?>?>(null);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  pTest.set(Pod(Pod(1)));
                },
                child: Text("ASSIGN"),
              ),
              TextButton(
                onPressed: () {
                  pTest.pChild()?.pChild()?.update((e) => (e as int) + 1);
                },
                child: Text("INCREMENT"),
              ),
              PodBuilder.value(
                pod: pTest,
                builder: (final value) {
                  return Text("${value?.value?.value}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
