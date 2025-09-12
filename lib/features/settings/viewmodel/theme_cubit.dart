import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = "theme_mode";

  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  // Başlangıçta shared preferencestan oku
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);

    if (themeString != null) {
      switch (themeString) {
        case "light":
          emit(ThemeMode.light);
          break;
        case "dark":
          emit(ThemeMode.dark);
          break;
        default:
          emit(ThemeMode.system);
      }
    } else {
      emit(ThemeMode.system);
    }
  }

  // Tema değiştirildiğinde kaydets
  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      newTheme == ThemeMode.light ? "light" : "dark",
    );
  }
}
