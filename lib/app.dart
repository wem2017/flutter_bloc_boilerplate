import 'package:envato/app_container.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/screens/screen.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, theme) {
              return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, auth) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: theme.lightTheme,
                    darkTheme: theme.darkTheme,
                    onGenerateRoute: Routes.generateRoute,
                    locale: locale,
                    localizationsDelegates: const [
                      Translate.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLanguage.supportLanguage,
                    home: Scaffold(
                      body: BlocListener<MessageBloc, MessageState>(
                        listener: (context, message) {
                          if (message is MessageShow) {
                            SnackBarAction? action;
                            if (message.action != null) {
                              action = SnackBarAction(
                                label: Translate.of(context).translate(
                                  message.action!,
                                ),
                                onPressed: message.onPressed!,
                              );
                            }
                            final snackBar = SnackBar(
                              content: Text(
                                Translate.of(context).translate(
                                  message.text,
                                ),
                              ),
                              action: action,
                              duration: Duration(
                                seconds: message.duration ?? 1,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          }
                        },
                        child: BlocBuilder<ApplicationCubit, ApplicationState>(
                          builder: (context, application) {
                            if (application == ApplicationState.completed) {
                              if (auth == AuthenticationState.fail) {
                                return const SignIn();
                              }
                              if (auth == AuthenticationState.success) {
                                return const AppContainer();
                              }
                            }
                            return const SplashScreen();
                          },
                        ),
                      ),
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
