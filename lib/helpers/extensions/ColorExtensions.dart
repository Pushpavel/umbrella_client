import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

extension ColorExtensions on Color {
  Color highEmphasis() => this._isDark() ? AppColors.blackHigh : AppColors.whiteHigh;

  Color mediumEmphasis() => this._isDark() ? AppColors.blackMedium : AppColors.whiteMedium;

  Color disabledEmphasis() => this._isDark() ? AppColors.blackDisabled : AppColors.whiteDisabled;

  bool _isDark() => ThemeData.estimateBrightnessForColor(this) == Brightness.dark;
}
