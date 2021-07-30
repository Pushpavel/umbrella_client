import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  /// Card Outline
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: Colors.black12,
        width: 1,
      ),
    ),
  ),

  /// Color Scheme
  primaryColor: Color(0xff048fff),
  errorColor: Color.fromRGBO(255, 94, 4, 1),
  accentColor: Color.fromRGBO(255, 184, 0, 1),

  /// Typography
  fontFamily: "Roboto",
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
    headline2: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
    ),
    button: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.17,
    ),
  ),
);
