import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? instance;

  static const String resetDB = 'resetDB';
  static const String localTimeZone = 'localTimeZone';
  static const String language = 'language';
  static const String theme = 'theme';
  static const String darkOption = 'darkOption';
  static const String font = 'font';
  static const String reportPeriod = 'reportPeriod';
  static const String reportItems = 'reportItems';

  static Future<void> setPreferences() async {
    instance = await SharedPreferences.getInstance();
  }

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
