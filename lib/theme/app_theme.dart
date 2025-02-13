import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/app_colors.dart';

class AppTheme {
  AppTheme._();
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    // Define the default text theme
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
    textTheme: ThemeData.dark().textTheme.copyWith(
      titleLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
      titleMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
      titleSmall: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
      bodyLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontFamily: 'SF Pro Display',
      ),
      bodyMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
        fontFamily: 'SF Pro Display',
      ),
      bodySmall: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 14,
        fontFamily: 'SF Pro Display',
      ),
      labelLarge: TextStyle(
        color: AppColors.textGrey,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
      labelMedium: TextStyle(
        color: AppColors.textGrey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
      labelSmall: TextStyle(
        color: AppColors.textGrey,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'SF Pro Display',
      ),
    ),
  );
}
