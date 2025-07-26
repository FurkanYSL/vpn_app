import 'package:flutter/material.dart';

/// Uygulama renk sabitleri
/// Single Responsibility Principle: Sadece renklerden sorumlu
class AppColors {
  AppColors._();
  // Primary Colors
  static const Color primaryBlue = Color(0xFF185BFF);
  static const Color lightBlue = Color(0xFF3B74FF);

  // Background Colors
  static const Color lightGray = Color(0xFFF0F5F5);
  static const Color cardBackground = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);

  // Text Colors
  static const Color darkText = Color(0xFF00091F);
  static const Color lightText = Color(0x6600091F);

  // Border Colors
  static const Color borderColor = Color(0x3300091F);
  static const Color cardBorderColor = Color(0x0A00091F);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);
  static const Color warningOrange = Color(0xFFFF9800);

  // Icon Colors
  static const Color iconGray = Color(0xFF292D32);
}
