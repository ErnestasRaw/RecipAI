import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Palette.seedColor,
);

ThemeData get appTheme => ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      fontFamily: 'Inter',
    );
