import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppLocaleDelegate extends LocalizationsDelegate<Translate> {
  const AppLocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLanguage.supportLanguage.contains(locale);
  }

  @override
  Future<Translate> load(Locale locale) async {
    switch (locale.languageCode) {
      case "en":
        timeago.setLocaleMessages('en', timeago.EnMessages());
        break;
      case "vi":
        timeago.setLocaleMessages('vi', timeago.ViMessages());
        break;
      case "ar":
        timeago.setLocaleMessages('ar', timeago.ArMessages());
        break;
      case "da":
        timeago.setLocaleMessages('da', timeago.DaMessages());
        break;
      case "de":
        timeago.setLocaleMessages('de', timeago.DeMessages());
        break;
      case "fr":
        timeago.setLocaleMessages('fr', timeago.FrMessages());
        break;
      case "id":
        timeago.setLocaleMessages('id', timeago.IdMessages());
        break;
      case "ja":
        timeago.setLocaleMessages('ja', timeago.JaMessages());
        break;
      case "ko":
        timeago.setLocaleMessages('ko', timeago.KoMessages());
        break;
      case "nl":
        timeago.setLocaleMessages('nl', timeago.NlMessages());
        break;
      case "zh":
        timeago.setLocaleMessages('zh', timeago.ZhCnMessages());
        break;
      case "fa":
        timeago.setLocaleMessages('fa', timeago.FaMessages());
        break;
      case "km":
        timeago.setLocaleMessages('km', timeago.KmMessages());
        break;
      case "ru":
        timeago.setLocaleMessages('ru', timeago.RuMessages());
        break;

      default:
        timeago.setLocaleMessages('en', timeago.EnMessages());
    }

    Translate localizations = Translate(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocaleDelegate old) => false;
}
