import 'package:flutter/material.dart';

final appTheme = {
  "bg": Colors.black,
  "text_primary": Colors.white,
  "text_secondary": Colors.grey.shade400,
  "button_bg": const Color(0xFF138a36)
};

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey.shade500,
    selectedItemColor: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.deepPurple,
      onPrimary: Colors.white,
    ),
  ),
  dialogBackgroundColor: Colors.white,
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText1: const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      color: Colors.grey.shade500,
    ),
    button: const TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
  ),
);
ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.grey.shade700,
    selectedItemColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
  ),
  dialogBackgroundColor: Colors.black,
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyText1: const TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.grey.shade700,
    ),
    button: const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  ),
);
