abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFail extends LoginState {
  final String message;

  LoginFail(this.message);
}

class LoginSuccess extends LoginState {}
