import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final languageCubit = LanguageCubit();
  static final themeCubit = ThemeCubit();
  static final authenticationCubit = AuthenticationCubit();
  static final signCubit = SignCubit();
  static final userCubit = UserCubit();
  static final messageBloc = MessageBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<LanguageCubit>(
      create: (context) => languageCubit,
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticationCubit,
    ),
    BlocProvider<SignCubit>(
      create: (context) => signCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    BlocProvider<MessageBloc>(
      create: (context) => messageBloc,
    ),
  ];

  static void dispose() {
    applicationCubit.close();
    languageCubit.close();
    themeCubit.close();
    authenticationCubit.close();
    signCubit.close();
    userCubit.close();
    messageBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
