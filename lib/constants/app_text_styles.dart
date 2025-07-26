import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

/// Uygulama text style sabitleri
/// Single Responsibility Principle: Sadece text stillerinden sorumlu
class AppTextStyles {
  AppTextStyles._();

  // Header Styles
  static const TextStyle headerTextStyle = TextStyle(
    fontFamily: AppFonts.gilroySemiBold,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.white,
    letterSpacing: 2,
  );

  // Time Display Style
  static const TextStyle timeTextStyle = TextStyle(
    fontFamily: AppFonts.gilroyBold,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.darkText,
  );

  // Country and Location Text Styles
  static const TextStyle countryNameTextStyle = TextStyle(
    fontFamily: AppFonts.gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.darkText,
  );

  static const TextStyle cityNameTextStyle = TextStyle(
    fontFamily: AppFonts.gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.lightText,
  );

  // Search and Input Styles
  static const TextStyle searchHintTextStyle = TextStyle(
    fontFamily: AppFonts.gilroyRegular,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.lightText,
  );

  // Navigation Styles
  static const TextStyle bottomNavTextStyle = TextStyle(
    fontFamily: AppFonts.gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.darkText,
  );

  // Label Styles
  static const TextStyle connectionTimeLabelStyle = TextStyle(
    color: AppColors.darkText,
    fontFamily: AppFonts.gilroyRegular,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const TextStyle freeLocationsLabelStyle = TextStyle(
    color: AppColors.lightText,
    fontFamily: AppFonts.gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  // Strength Percentage Style
  static const TextStyle strengthPercentageStyle = TextStyle(
    fontFamily: AppFonts.gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColors.darkText,
  );
}
