import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();
  static ThemeData buildTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Colors.white,
            fontSize: 12.0),
        bodySmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Colors.black,
            fontSize: 8.0),
        bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Colors.black,
            fontSize: 12.0),
        titleSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Colors.white,
            fontSize: 20.0),
        titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Colors.white,
            fontSize: 18.0),
        displaySmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Dana',
            color: Colors.white,
            fontSize: 18.0),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Dana',
            color: Colors.white,
            fontSize: 14.0),
        labelSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Dana',
            color: Color.fromARGB(188, 255, 255, 255),
            fontSize: 12.0),
      ),
    );
  }
}
