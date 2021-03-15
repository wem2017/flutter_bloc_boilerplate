import 'package:flutter/material.dart';

abstract class LanguageEvent {}

class OnChangeLanguage extends LanguageEvent {
  final Locale locale;

  OnChangeLanguage(this.locale);
}
