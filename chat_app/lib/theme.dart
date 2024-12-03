import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        dynamicSchemeVariant: DynamicSchemeVariant.expressive,
        seedColor: Colors.green),
  );
}
