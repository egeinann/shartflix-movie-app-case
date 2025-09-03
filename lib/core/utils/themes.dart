import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/colors.dart';

class AppTheme {
  // *** LİGHT ***
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    shadowColor: AppColorsLight.shadow,
    primaryColor: AppColorsLight.primary,
    highlightColor: AppColorsLight.highlight,
    cardColor: AppColorsLight.card,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: AppColorsLight.background,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColorsLight.background,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColorsLight.background,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // *** Dark ***
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    shadowColor: AppColorsDark.shadow,
    primaryColor: AppColorsDark.primary,
    highlightColor: AppColorsLight.highlight,
     cardColor: AppColorsDark.card,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColorsDark.shadow,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColorsDark.shadow,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: AppColorsDark.shadow,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: AppColorsDark.background,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColorsDark.background,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColorsDark.background,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
