// -----------------------------------------------------------------------------
// Example of using temporarty Pods.
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

// -----------------------------------------------------------------------------

final pGlobalText = Pod<String>("Hello World");

// -----------------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XYZ Pod Example',
      home: Material(
        child: Column(
          children: [
            MyText(
              // Create a temporary String Pod that will be disposed when the
              // MyText widget is disposed.
              pText: Pod.temp("Hello World"),
            ),
            // The Pod here is not temporary, so it will not be disposed by
            //  MyText.
            MyText(
              pText: pGlobalText,
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

class MyText extends StatefulWidget {
  //
  //
  //

  final Pod<String> pText;

  //
  //
  //

  const MyText({
    super.key,
    required this.pText,
  });

  //
  //
  //

  @override
  MyTextState createState() => MyTextState();
}

// -----------------------------------------------------------------------------

class MyTextState extends State<MyText> {
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodBuilder.value(
      pod: widget.pText,
      builder: (value) {
        return Text(
          value ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }

  //
  //
  //

  @override
  void dispose() {
    // Dispose pText if it is temporary.
    widget.pText.disposeIfTemp();
    super.dispose();
  }
}
