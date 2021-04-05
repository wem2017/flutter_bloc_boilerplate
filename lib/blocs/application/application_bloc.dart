import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/database/provider.dart';
import 'package:envato/models/model.dart';
import 'package:envato/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(InitialApplicationState());

  final application = Application();
  final databaseProvider = DatabaseProvider();

  @override
  Stream<ApplicationState> mapEventToState(event) async* {
    if (event is OnSetupApplication) {
      ///Firebase init
      await Firebase.initializeApp();

      ///Setup SharedPreferences
      await application.setPreferences();

      ///Load database
      await databaseProvider.createDatabase();

      ///Get old Theme & Font & Language
      final oldTheme = UtilPreferences.getString(Preferences.theme);
      final oldFont = UtilPreferences.getString(Preferences.font);
      final oldLanguage = UtilPreferences.getString(Preferences.language);
      final oldDarkOption = UtilPreferences.getString(Preferences.darkOption);

      DarkOption? darkOption;
      String? font;
      ThemeModel? theme;

      ///Setup Language
      if (oldLanguage != null) {
        AppBloc.languageBloc.add(
          OnChangeLanguage(Locale(oldLanguage)),
        );
      }

      ///Find font support available
      try {
        font = AppTheme.fontSupport.firstWhere((item) {
          return item == oldFont;
        });
      } catch (e) {}

      ///Find theme support available
      try {
        theme = AppTheme.themeSupport.firstWhere((item) {
          return item.name == oldTheme;
        });
      } catch (e) {}

      ///check old dark option

      if (oldDarkOption != null) {
        switch (oldDarkOption) {
          case DARK_ALWAYS_OFF:
            darkOption = DarkOption.alwaysOff;
            break;
          case DARK_ALWAYS_ON:
            darkOption = DarkOption.alwaysOn;
            break;
          default:
            darkOption = DarkOption.dynamic;
        }
      }

      ///Setup Theme & Font with dark Option
      AppBloc.themeBloc.add(
        OnChangeTheme(
          theme: theme,
          font: font,
          darkOption: darkOption,
        ),
      );

      ///Authentication begin check
      AppBloc.authBloc.add(OnAuthCheck());

      yield ApplicationCompleted();
    }
  }
}
