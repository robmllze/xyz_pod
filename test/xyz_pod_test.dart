// //.title
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //
// // XYZ Pod
// //
// // Copyright (c) 2023 Robert Mollentze
// // See LICENSE for details.
// //
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //.title~

// import 'package:flutter_test/flutter_test.dart';
// import 'package:xyz_pod/xyz_pod.dart';

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// void main() {
//   group("Pod", () {
//     test("Should update value and notify listeners", () async {
//       final pod = Pod<int>(0);

//       bool isNotified = false;
//       pod.addListener(() {
//         isNotified = true;
//       });

//       await pod.set(1);

//       expect(pod.value, 1);
//       expect(isNotified, true);
//     });

//     test("Should correctly apply update function", () async {
//       final pod = Pod<int>(1);

//       await pod.update((value) => value + 1);

//       expect(pod.value, 2);
//     });

//     test("Should notify listeners on refresh", () async {
//       final pod = Pod<int>(0);

//       bool isNotified = false;
//       pod.addListener(() {
//         isNotified = true;
//       });

//       await pod.refresh();

//       expect(isNotified, true);
//     });

//     test("Should dispose if temporary", () {
//       final pod = Pod.temp(0);
//       expect(pod.isTemp, isTrue);
//       pod.disposeIfTemp();
//     });
//   });
// }
