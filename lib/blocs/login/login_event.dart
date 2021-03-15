abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  final String username;
  final String password;
  OnLogin({this.username, this.password});
}

class OnLogout extends LoginEvent {
  OnLogout();
}
