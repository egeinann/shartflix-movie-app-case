import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('tr')) {
    _loadSavedLanguage();
  }

  // SharedPreferences'ten kaydedilmiş dili yükle
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code');

    if (langCode != null) {
      emit(Locale(langCode));
    } else {
      // Sistem dili kontrolü
      final systemLocale = WidgetsBinding.instance.window.locale;
      if (systemLocale.languageCode == 'tr') {
        emit(Locale('tr'));
      } else {
        emit(Locale('en'));
      }
    }
  }

  // Dili değiştir
  Future<void> changeLanguage(Locale locale, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);

    emit(locale);
    context.setLocale(locale); // easy_localization’a bildir
  }
}
