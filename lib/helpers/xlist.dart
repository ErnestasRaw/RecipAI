import 'package:flutter/material.dart';

extension XEIterable<E> on Iterable<E> {
  E? get maybeFirst => isEmpty ? null : first;

  E? get maybeLast => isEmpty ? null : last;

  E? maybeFirstWhere(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// if [i] exceeds the length, returns null instead of throwing
  E? maybeElementAt(int i) {
    if (i >= length || i < 0) return null;
    return elementAt(i);
  }
}

extension XENumIntIterable on Iterable<int> {
  int sum() => fold<int>(0, (val, e) => val + e);
}

extension XENumDoubleIterable on Iterable<double> {
  double sum() => fold<double>(.0, (val, e) => val + e);
}

extension XENumIterable on Iterable<num> {
  num sum() => fold(0, (val, e) => val + e);

// num findMax() => length == 0 ? 0 : skip(1).fold(first, (val, e) => e > val ? e : val);
// num findMin() => length == 0 ? 0 : skip(1).fold(first, (val, e) => e < val ? e : val);
// double average() => length == 0 ? 0 : fold<double>(.0, (val, e) => val + e) / length;
}

extension XEList<E> on List<E> {
  /// Fills the list with [separator] in between existing items. The length becomes min(0, [length] * 2 - 1)
  /// [a, b, c].separate(e) => [a, e, b, e, c]
  /// [a, a].separate(e) => [a, e, a]
  /// [a].separate(e) => [a]
  /// [].separate(e) => []
  List<E> separate(E separator) {
    if (isEmpty) return <E>[];
    return List.generate(
      length * 2 - 1,
      (i) => i % 2 == 0 ? elementAt(i ~/ 2) : separator,
    );
  }

  /// Like [map], but error-throwing elements are discarded.
  /// The return list's length may be smaller.
  List<T> mapSafe<T>(T toElement(E e), {void Function(Object)? onError}) {
    final List<T> mapped = [];
    for (final item in this) {
      try {
        mapped.add(toElement(item));
      } catch (err) {
        onError?.call(err);
      }
    }
    return mapped;
  }
}

extension XEWidgetList on List<Widget> {
  /// Returns an expanded list of widgets, adding [SizedBox] spacings in between the items.
  /// Can only be used on Widget lists (List<Widget>)
  /// Example:
  ///   <Widget>[widget1, widget2, widget3].addSpacing(8)
  ///   =>
  ///   <Widget>[widget1, SizedBox(height: 8), widget2, SizedBox(height: 8), widget3]
  List<Widget> addSpacing<T extends Widget>(
    final double spacing, {
    Axis axis = Axis.vertical,
    bool? horizontal,
  }) {
    if (horizontal == true) axis = Axis.horizontal;
    return separate(
      SizedBox(
        height: axis == Axis.vertical ? spacing : 0.0,
        width: axis == Axis.horizontal ? spacing : 0.0,
      ),
    );
  }
}
