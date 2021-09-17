import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';

class ThemeState {
  final ThemeModel theme;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String? font;
  final DarkOption darkOption;

  ThemeState({
    required this.theme,
    required this.lightTheme,
    required this.darkTheme,
    this.font,
    required this.darkOption,
  });

  factory ThemeState.fromDefault() {
    return ThemeState(
      theme: AppTheme.defaultTheme,
      lightTheme: UtilTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.light,
        font: AppTheme.defaultFont,
      ),
      darkTheme: UtilTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.dark,
        font: AppTheme.defaultFont,
      ),
      font: AppTheme.defaultFont,
      darkOption: AppTheme.darkThemeOption,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.fromDefault());

  void onChangeTheme({
    ThemeModel? theme,
    String? font,
    DarkOption? darkOption,
  }) async {
    ///Setup Theme with setting darkOption
    final currentState = AppBloc.themeCubit.state;
    theme ??= currentState.theme;
    font ??= currentState.font;
    darkOption ??= currentState.darkOption;

    ThemeState themeState;

    switch (darkOption) {
      case DarkOption.dynamic:
        UtilPreferences.setString(Preferences.darkOption, 'dynamic');
        themeState = ThemeState(
          theme: theme,
          lightTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
      case DarkOption.alwaysOn:
        UtilPreferences.setString(Preferences.darkOption, 'on');
        themeState = ThemeState(
          theme: theme,
          lightTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          darkTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
      case DarkOption.alwaysOff:
        UtilPreferences.setString(Preferences.darkOption, 'off');
        themeState = ThemeState(
          theme: theme,
          lightTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: UtilTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
    }

    ///Preference save
    UtilPreferences.setString(
      Preferences.theme,
      jsonEncode(themeState.theme.toJson()),
    );

    ///Preference save
    if (themeState.font != null) {
      UtilPreferences.setString(Preferences.font, themeState.font!);
    }

    ///Notify
    emit(themeState);
  }
}
