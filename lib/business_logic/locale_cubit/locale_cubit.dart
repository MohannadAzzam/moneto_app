import 'package:flutter/material.dart'; // للتعامل مع كلاس Locale و BuildContext
import 'package:flutter_bloc/flutter_bloc.dart'; // لاستخدام الـ Cubit
import 'package:shared_preferences/shared_preferences.dart'; // لحفظ اللغة في الجهاز

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(Locale('en')) {
    getSavedLanguage();
  }

  // تغيير اللغة وحفظها
  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    emit(Locale(languageCode));
  }

  Future<void> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String cachedLanguageCode = prefs.getString('language') ?? 'en';
    emit(Locale(cachedLanguageCode));
  }
}
