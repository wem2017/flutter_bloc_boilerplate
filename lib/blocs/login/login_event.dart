abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  final String username;
  final String password;
  OnLogin({required this.username, required this.password});
}

class OnLogout extends LoginEvent {
  OnLogout();
}
