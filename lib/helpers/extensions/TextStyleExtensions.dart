import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle highEmphasis() => copyWith(color: this._isDark() ? AppColors.blackHigh : AppColors.whiteHigh);

  TextStyle mediumEmphasis() => copyWith(color: this._isDark() ? AppColors.blackMedium : AppColors.whiteMedium);

  TextStyle disabledEmphasis() => copyWith(color: this._isDark() ? AppColors.blackDisabled : AppColors.whiteDisabled);

  bool _isDark() => color != null && ThemeData.estimateBrightnessForColor(color!) == Brightness.dark;
}
