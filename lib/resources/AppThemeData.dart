import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: Colors.black12,
        width: 1,
      ),
    ),
  ),
  colorScheme: ColorScheme.light(
    error: Color.fromRGBO(255, 94, 4, 1),
    secondary: Color.fromRGBO(255, 184, 0, 1),
  ),
);
