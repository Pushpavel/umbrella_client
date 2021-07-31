import 'package:flutter/material.dart';
import 'package:umbrella_client/resources/theme/colors.dart';

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

final appWhiteTexts = Typography.whiteMountainView.copyWith(
  headline1: TextStyle(color: AppColors.whiteHigh),
  headline2: TextStyle(color: AppColors.whiteHigh),
  headline3: TextStyle(color: AppColors.whiteHigh),
  subtitle1: TextStyle(color: AppColors.whiteMedium),
  subtitle2: TextStyle(color: AppColors.whiteMedium),
);

final appBlackTexts = Typography.blackMountainView.copyWith(
  headline1: TextStyle(color: AppColors.blackHigh),
  headline2: TextStyle(color: AppColors.blackHigh),
  headline3: TextStyle(color: AppColors.blackHigh),
  subtitle1: TextStyle(color: AppColors.blackMedium),
  subtitle2: TextStyle(color: AppColors.blackMedium),
);
