import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/theme/colors.dart';
import 'package:umbrella_client/resources/theme/typography.dart';

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
    primary: AppColors.primary,
    primaryVariant: AppColors.primaryVariant,
    secondary: AppColors.secondary,
    secondaryVariant: AppColors.secondaryVariant,
    error: AppColors.error,
  ),

  textTheme: appTextTheme,
  primaryTextTheme: appTextTheme,
  accentTextTheme: appTextTheme,

  typography: Typography.material2018(
    white: appWhiteTexts,
    black: appBlackTexts,
  ),
);
