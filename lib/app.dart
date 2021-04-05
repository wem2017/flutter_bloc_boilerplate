import 'package:envato/blocs/bloc.dart';
import 'package:envato/bottom_navigation.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/screens/screen.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final route = Routes();

  @override
  void initState() {
    super.initState();
    AppBloc.applicationBloc.add(OnSetupApplication());
  }

  @override
  void dispose() {
    super.dispose();
    AppBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, lang) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, theme) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, auth) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    onGenerateRoute: route.generateRoute,
                    locale: AppLanguage.defaultLanguage,
                    localizationsDelegates: [
                      Translate.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLanguage.supportLanguage,
                    home: BlocBuilder<ApplicationBloc, ApplicationState>(
                      builder: (context, application) {
                        if (application is ApplicationCompleted) {
                          if (auth is AuthenticationFail) {
                            return SignIn();
                          }
                          if (auth is AuthenticationSuccess) {
                            return BottomNavigation();
                          }
                        }
                        return SplashScreen();
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
