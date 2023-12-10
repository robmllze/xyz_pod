import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

final pTest = Pod(null);

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
                  pTest.last.update((e) => (e as int) + 1);
                  //pTest.child()?.child()?.update((e) => (e as int) + 1);
                  //pTest.child()?.update((e) => (e as int) + 1);
                },
                child: Text("INCREMENT"),
              ),
              TextButton(
                onPressed: () {
                  print(pTest.length);
                },
                child: Text("FORWARD LENGTH"),
              ),
              TextButton(
                onPressed: () {
                  pTest.dispose();
                },
                child: Text("DISPOSE"),
              ),
              TextButton(
                onPressed: () {
                  print(pTest.chain.length);
                },
                child: Text("FORWARD CHAIN"),
              ),
              TextButton(
                onPressed: () {
                  pTest.chain.reversed.forEach((e) => e.dispose());
                },
                child: Text("DISPOSE CHAIN"),
              ),
              PodListBuilder.values(
                pods: [pTest],
                builder: (final value) {
                  print("!!!");
                  return Text("${value.last}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
