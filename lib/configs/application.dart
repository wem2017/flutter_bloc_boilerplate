import 'package:shared_preferences/shared_preferences.dart';

class Application {
  /// [Production - Dev]

  static bool debug = false;
  static String version = '1.0.0';
  static String dateFormat = 'HH:MM, MMM dd yyyy';
  static String clientID = "sale-tracker-vhf6zehy";
  static String domain = "https://api.saleboltapp.com";
  static SharedPreferences? preferences;

  Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
