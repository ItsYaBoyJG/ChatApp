import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
          secondary: Colors.blue[900],
          tertiary: Colors.amber[300]),
      appBarTheme: AppBarTheme(backgroundColor: Colors.blue[900]),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.amberAccent,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ));
}
