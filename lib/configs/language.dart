import 'package:flutter/material.dart';

class AppLanguage {
  ///Default Language
  static const Locale defaultLanguage = Locale("en");

  ///List Language support in Application
  static final List<Locale> supportLanguage = [
    const Locale("en"),
    const Locale("vi"),
    const Locale("da"),
    const Locale("de"),
    const Locale("el"),
    const Locale("fr"),
    const Locale("id"),
    const Locale("ja"),
    const Locale("ko"),
    const Locale("nl"),
    const Locale("zh"),
    const Locale("ru"),
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
