import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shartflix_movie_app_case/core/utils/themes.dart';
import 'package:shartflix_movie_app_case/main_screen.dart';

void main() {
  runApp(const ShartflixApp());
}

final themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.light,
); // tema modu dinleyici

class ShartflixApp extends StatelessWidget {
  const ShartflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentTheme, child) {
        return ResponsiveSizer(
          builder: (p0, p1, p2) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            home: MainScreen(),
          ),
        );
      },
    );
  }
}
