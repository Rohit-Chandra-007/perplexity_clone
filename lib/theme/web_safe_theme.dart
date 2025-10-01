import 'package:flutter/material.dart';
import '../utils/font_helper.dart';
import 'app_colors.dart';

class WebSafeTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.submitButton,
        secondary: AppColors.textSecondary,
        surface: AppColors.cardColor,
      ),
      textTheme: TextTheme(
        displayLarge: FontHelper.systemFont(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        displayMedium: FontHelper.systemFont(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        displaySmall: FontHelper.systemFont(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
        headlineLarge: FontHelper.systemFont(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        headlineMedium: FontHelper.systemFont(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        headlineSmall: FontHelper.systemFont(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        titleLarge: FontHelper.systemFont(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleMedium: FontHelper.systemFont(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        titleSmall: FontHelper.systemFont(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: FontHelper.systemFont(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: FontHelper.systemFont(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        bodySmall: FontHelper.systemFont(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
        labelLarge: FontHelper.systemFont(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelMedium: FontHelper.systemFont(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        labelSmall: FontHelper.systemFont(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        titleTextStyle: FontHelper.systemFont(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.searchBar,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchBarBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.searchBarBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.submitButton),
        ),
      ),
    );
  }
}