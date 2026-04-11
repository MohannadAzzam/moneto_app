import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale); // هذا هو السطر الذي يحل المشكلة

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;

 Future<bool> load() async {
  try {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    print("Language file loaded: ${locale.languageCode}"); // للتأكد
    
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  } catch (e) {
    print("Error loading language: $e"); // سيطبع لك السبب الحقيقي للـ null
    return false;
  }
}

String translate(String key) {
  // إذا كانت النصوص لم تُحمل بعد، أرجع المفتاح نفسه كـ String
  if (_localizedStrings == null) return key; 
  return _localizedStrings![key] ?? key;
}}