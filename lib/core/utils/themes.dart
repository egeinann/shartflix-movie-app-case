import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/colors.dart';
import 'package:shartflix_movie_app_case/core/utils/strings.dart';

class AppTheme {
  // *** LİGHT ***
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    shadowColor: AppColorsLight.shadow,
    primaryColor: AppColorsLight.primary,
    highlightColor: AppColorsLight.highlight,
    cardColor: AppColorsLight.card,
    iconTheme: IconThemeData(color: AppColorsDark.background),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      bodyMedium: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      bodySmall: TextStyle(
        color: AppColorsLight.shadow,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineLarge: TextStyle(
        color: AppColorsLight.background,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineMedium: TextStyle(
        color: AppColorsLight.background,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineSmall: TextStyle(
        color: AppColorsLight.background,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      labelLarge: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
      ),
      labelMedium: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
      ),
      labelSmall: TextStyle(
        color: AppColorsLight.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
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
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      bodyMedium: TextStyle(
        color: AppColorsDark.shadow,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      bodySmall: TextStyle(
        color: AppColorsDark.shadow,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineLarge: TextStyle(
        color: AppColorsDark.background,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineMedium: TextStyle(
        color: AppColorsDark.background,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      headlineSmall: TextStyle(
        color: AppColorsDark.background,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansRegular,
      ),
      labelLarge: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
      ),
      labelMedium: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
      ),
      labelSmall: TextStyle(
        color: AppColorsDark.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppFontFamilies.instrumentSansMedium,
      ),
    ),
  );
}
