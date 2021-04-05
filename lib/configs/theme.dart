import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:flutter/material.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

class AppTheme {
  ///Optional Color
  static Color blueColor = Color.fromRGBO(93, 173, 226, 1);
  static Color pinkColor = Color.fromRGBO(165, 105, 189, 1);
  static Color greenColor = Color.fromRGBO(88, 214, 141, 1);
  static Color yellowColor = Color.fromRGBO(253, 198, 10, 1);

  ///Default font
  static String currentFont = 'ProximaNova';

  ///List Font support
  static List<String> fontSupport = [
    "OpenSans",
    "ProximaNova",
    "Raleway",
    "Roboto",
    "Merriweather",
  ];

  ///Default Theme
  static ThemeModel currentTheme = ThemeModel.fromJson({
    "name": "default",
    "color": Color(0xff82B541),
    "light": "defaultLight",
    "dark": "defaultDark",
  });

  ///List Theme Support in Application
  static List<ThemeModel> themeSupport = [
    {
      "name": "default",
      "color": Color(0xff82B541),
      "light": "defaultLight",
      "dark": "defaultDark",
    },
    {
      "name": "orange",
      "color": Color(0xfff4a261),
      "light": "orangeLight",
      "dark": "orangeDark",
    },
  ].map((item) => ThemeModel.fromJson(item)).toList();

  ///Dark Theme option
  static DarkOption darkThemeOption = DarkOption.dynamic;

  static ThemeData lightTheme = CollectionTheme.getCollectionTheme(
    theme: currentTheme.lightTheme,
    font: currentFont,
  );

  static ThemeData darkTheme = CollectionTheme.getCollectionTheme(
    theme: currentTheme.darkTheme,
    font: currentFont,
  );

  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
