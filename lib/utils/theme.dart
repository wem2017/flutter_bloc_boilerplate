import 'package:envato/configs/config.dart';

class UtilTheme {
  static String exportLangTheme(DarkOption option) {
    switch (option) {
      case DarkOption.dynamic:
        return "dynamic_theme";
      case DarkOption.alwaysOff:
        return "always_off";
      default:
        return "always_on";
    }
  }

  ///Singleton factory
  static final UtilTheme _instance = UtilTheme._internal();

  factory UtilTheme() {
    return _instance;
  }

  UtilTheme._internal();
}
