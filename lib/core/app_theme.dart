import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF3045);
  static const primaryDark = Color(0xFFE51F34);
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const blueBadge = Color(0xFFE8F3FF);
  static const blue = Color(0xFF2F80ED);
  static const bg = Color(0xFFF8FAFF);
  static const gold = Color(0xFFF5A400);
  static const cream = Color(0xFFFFF3D7);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
    ),
    fontFamily: 'Noto Sans JP',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.text,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.text,
      ),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, color: AppColors.text),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w800,
        color: AppColors.text,
      ),
      bodyLarge: TextStyle(fontWeight: FontWeight.w600, color: AppColors.text),
      bodyMedium: TextStyle(fontWeight: FontWeight.w600, color: AppColors.text),
      labelLarge: TextStyle(fontWeight: FontWeight.w800),
    ),
  );
}

List<BoxShadow> softShadow([double opacity = .12]) => [
  BoxShadow(
    color: const Color(0xFF1F2937).withValues(alpha: opacity),
    blurRadius: 22,
    offset: const Offset(0, 10),
  ),
];
