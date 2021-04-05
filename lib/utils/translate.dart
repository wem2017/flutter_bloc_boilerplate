import 'package:envato/app_locale_delegate.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';

class Translate {
  final Locale locale;

  Translate(this.locale);

  static Translate? of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate);
  }

  static const LocalizationsDelegate<Translate> delegate = AppLocaleDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    final jsonMap = await UtilAsset.loadJson(
      "assets/locale/${locale.languageCode}.json",
    );

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
