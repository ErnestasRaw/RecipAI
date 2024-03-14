import 'package:flutter/material.dart';

class Sizes {
  /// Private constructor to get rid of suggestion for using the constructor
  Sizes._();

  static const EdgeInsets pageMargins = EdgeInsets.symmetric(horizontal: 22, vertical: 16);
  static const EdgeInsets pdfPageMargins = EdgeInsets.symmetric(horizontal: 0, vertical: 16);
  static const EdgeInsets menuMargins = EdgeInsets.symmetric(horizontal: 36, vertical: 48);
  static const EdgeInsets dialogMargins = pageMargins;

  // static const EdgeInsets pageMarginsBig = EdgeInsets.symmetric(horizontal: 22, vertical: 48);
  // static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 14);

  static const EdgeInsets boxMargins = EdgeInsets.symmetric(horizontal: 8, vertical: 12);
  static const EdgeInsets boxMarginsMedium = EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  static const EdgeInsets boxMarginsBig = EdgeInsets.symmetric(horizontal: 20, vertical: 22);

  static const double inputHeight = 44;

  /// default vertical spacing between column widgets
  static const double spacingTiny = 4;
  static const double spacingSmall = 8;
  static const double spacingMedium = 12;
  static const double spacingBig = 16;
  static const double spacingLarge = 24;
  static const double spacingHuge = 36;

  // static const double spacingGigantic = 48;

  static const double pillsSpacing = 24;
  static const double dialogSpacing = spacingLarge;

  static const double iconSmall = 30;
  static const double iconBig = 36;
  static const double iconLarge = 42;

  /////////////////////////////////////////////////
  /// Dynamic values

  static Size screenSize = const Size(0, 0);
  static double get width => screenSize.width;
  static double get height => screenSize.height;

  static void init(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
  }
}
