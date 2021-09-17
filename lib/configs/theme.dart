import 'package:envato/models/model.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

class AppTheme {
  ///Default font
  static const String defaultFont = 'ProximaNova';

  ///List Font support
  static final List<String> fontSupport = [
    "OpenSans",
    "ProximaNova",
    "Raleway",
    "Roboto",
    "Merriweather",
  ];

  ///Default Theme
  static final ThemeModel defaultTheme = ThemeModel.fromJson({
    "name": "default",
    "primary": 'ff82B541',
    "secondary": "ffff8a65",
  });

  ///List Theme Support in Application
  static final List<ThemeModel> themeSupport = [
    {
      "name": "default",
      "primary": 'ff82B541',
      "secondary": "ffff8a65",
    },
    {
      "name": "orange",
      "primary": 'fff4a261',
      "secondary": "ff2A9D8F",
    },
    {
      "name": "blue",
      "primary": 'ff077ef0',
      "secondary": "ff5B876C",
    },
    {
      "name": "summer",
      "primary": 'ff53ac7d',
      "secondary": "ff832400",
    },
  ].map((item) => ThemeModel.fromJson(item)).toList();

  ///Dark Theme option
  static const DarkOption darkThemeOption = DarkOption.dynamic;

  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
