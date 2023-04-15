// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XyzPod - Equality
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:collection/collection.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef FEquality<T> = bool Function(T a, T b);

/// Function to compare equality between two lists.
bool equalsList(dynamic a, dynamic b) {
  return const ListEquality().equals(a, b);
  //return const ListEquality().equals(letAs<List?>(a), letAs<List?>(a));
}

/// Function to compare equality between two sets.
bool equalsSet(dynamic a, dynamic b) {
  return const SetEquality().equals(a, b);
  //return const SetEquality().equals(letAs<Set?>(a), letAs<Set?>(b));
}

/// Function to compare equality between two iterables.
bool equalsIterable(dynamic a, dynamic b) {
  return const IterableEquality().equals(a, b);
  //return const IterableEquality().equals(letAs<Iterable?>(a), letAs<Iterable?>(b));
}

/// Function to compare equality between two maps.
bool equalsMap(dynamic a, dynamic b) {
  return const MapEquality().equals(a, b);
  //return const MapEquality().equals(letAs<Map?>(a), letAs<Map?>(b));
}

/// Function to compare equality between nested collections.
bool equalsDeepCollection(dynamic a, dynamic b) => const DeepCollectionEquality().equals(a, b);

/// Function that recursively checks if collection [a] contains at least all
/// elements of collection [b]. Collections may be of type Map or Iterable.
final FEquality equalsAtLeastAll = <T>(T a, T b) {
  if (a is Map && b is Map) {
    for (final key in b.keys) {
      if (!a.containsKey(key)) {
        return false;
      }
      final value1 = a[key];
      final value2 = b[key];
      if (!equalsAtLeastAll(value1, value2)) {
        return false;
      }
    }
    return true;
  } else if (a is Iterable && b is Iterable) {
    for (final e2 in b) {
      var found = false;
      for (final e1 in a) {
        if (equalsAtLeastAll(e1, e2)) {
          found = true;
          break;
        }
      }
      if (!found) {
        return false;
      }
    }
    return true;
  } else {
    return a == b;
  }
};
