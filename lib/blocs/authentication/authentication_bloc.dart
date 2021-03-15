import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/repository/repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());

  final userRepository = UserRepository();
  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      await Future.delayed(Duration(seconds: 2));

      ///authentication check flow

      yield AuthenticationFail();
    }

    if (event is OnAuthProcess) {
      ///authentication process flow
      yield AuthenticationSuccess();
    }

    if (event is OnClear) {
      ///Delete user
      await userRepository.deleteUser();

      yield AuthenticationFail();
    }
  }
}
