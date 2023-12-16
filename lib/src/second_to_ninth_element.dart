//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Pod
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension SecondToNinthElement<T> on Iterable<T> {
  T get second => elementAt(1);
  T? get secondOrNull => elementAtOrNull(1);
  T get third => elementAt(2);
  T? get thirdOrNull => elementAtOrNull(2);
  T get fourth => elementAt(3);
  T? get fourthOrNull => elementAtOrNull(3);
  T get fifth => elementAt(4);
  T? get fifthOrNull => elementAtOrNull(4);
  T get sixth => elementAt(5);
  T? get sixthOrNull => elementAtOrNull(5);
  T get seventh => elementAt(6);
  T? get seventhOrNull => elementAtOrNull(6);
  T get eighth => elementAt(7);
  T? get eighthOrNull => elementAtOrNull(7);
  T get ninth => elementAt(8);
  T? get ninthOrNull => elementAtOrNull(8);
}
