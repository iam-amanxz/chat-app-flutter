import 'package:flutter/material.dart';

final appTheme = {
  "bg": Colors.black,
  "text_primary": Colors.white,
  "text_secondary": Colors.grey.shade400,
  "button_bg": const Color(0xFF138a36)
};

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
);
ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
);
