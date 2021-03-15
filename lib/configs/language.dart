import 'package:flutter/material.dart';

class AppLanguage {
  ///Default Language
  static Locale defaultLanguage = Locale("en");

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    Locale("en"),
    Locale("vi"),
    Locale("da"),
    Locale("de"),
    Locale("el"),
    Locale("fr"),
    Locale("id"),
    Locale("ja"),
    Locale("ko"),
    Locale("nl"),
    Locale("zh"),
    Locale("ru"),
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
