import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationBloc = ApplicationBloc();
  static final databaseBloc = DatabaseBloc();
  static final languageBloc = LanguageBloc();
  static final themeBloc = ThemeBloc();
  static final authBloc = AuthBloc();
  static final loginBloc = LoginBloc();
  static final appStateBloc = AppStateBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<DatabaseBloc>(
      create: (context) => databaseBloc,
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<AppStateBloc>(
      create: (context) => appStateBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
  ];

  static void dispose() {
    applicationBloc.close();
    databaseBloc.close();
    languageBloc.close();
    appStateBloc.close();
    themeBloc.close();
    authBloc.close();
    loginBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
