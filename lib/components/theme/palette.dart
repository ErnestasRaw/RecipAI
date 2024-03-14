import 'package:flutter/material.dart';

class Palette {
  /// Private constructor to get rid of suggestion for using the constructor
  Palette._();

  // Contrast colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const darkGrey = Color(0xFF333333);
  static const grey = Color(0xFF666666);
  static const lightGrey = Color(0xFFE5E5E5);
  // Green, blue, yellow, red
  static const green = Color(0xFF00FF00);
  static const blue = Color(0xFF0000FF);
  static const yellow = Color(0xFFFFFF00);
  static const red = Color(0xFFFF0000);
  // Seed color
  static const seedColor = Color(0xFF1B5730);

  ///Gradiant for [DrawerHeader]
  static const List<Color> greenGradient = [
    Color(0xFF1B5730),
    Color(0xFF2E7D32),
  ];
}
