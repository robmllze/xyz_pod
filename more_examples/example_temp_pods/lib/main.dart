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
import 'package:xyz_pod/xyz_pod.dart';

final pText = Pod<String>("Hello World");

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: Column(
          children: [
            MyText(
              // Create a temporary String Pod that will be disposed when the
              // MyText widget is disposed.
              pText: Pod.temp("Hello World"),
            ),
            // The Pod here is not temporary, so it will not be disposed by
            // MyText.
            MyText(pText: pText),
          ],
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------

class MyText extends StatefulWidget {
  final Pod<String> pText;

  const MyText({
    super.key,
    required this.pText,
  });

  @override
  MyTextState createState() => MyTextState();
}

class MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return PodBuilder(
      pod: widget.pText,
      builder: (context, child, text) {
        return Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose pText if it is temporary.
    widget.pText.disposeIfMarkedAsTemp();
    super.dispose();
  }
}