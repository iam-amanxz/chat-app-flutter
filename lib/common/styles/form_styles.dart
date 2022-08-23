import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      Colors.white,
    ),
    foregroundColor: MaterialStateProperty.all(
      Colors.black,
    ),
  );
}

InputDecoration formInputDecoration({required String labelText}) {
  return InputDecoration(
    labelText: labelText,
    border: const UnderlineInputBorder(),
    errorMaxLines: 2,
  );
}
