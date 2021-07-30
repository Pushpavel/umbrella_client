import 'package:flutter/material.dart';

final appTextTheme = TextTheme(
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
);

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

  colorScheme: ColorScheme.light(
    primary: Color(0xff048fff),
    primaryVariant: Color(0xffeff7ff),
    secondary: Color.fromRGBO(85, 85, 85, 1),
    secondaryVariant: Color.fromRGBO(255, 184, 0, 1),
    error: Color.fromRGBO(255, 94, 4, 1),
  ),

  textTheme: appTextTheme,
  primaryTextTheme: appTextTheme,
  accentTextTheme: appTextTheme,
);
