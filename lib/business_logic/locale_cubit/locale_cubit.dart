import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({required Locale locale}) : super(locale) {
    getSavedLanguage();
  }

  // تغيير اللغة وحفظها
  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    emit(Locale(languageCode));
  }

  // جلب اللغة المحفوظة عند تشغيل التطبيق
  Future<void> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String cachedLanguageCode = prefs.getString('language') ?? 'en';
    emit(Locale(cachedLanguageCode));
  }
}
