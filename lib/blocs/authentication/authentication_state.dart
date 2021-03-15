abstract class AuthState {}

class InitialAuthenticationState extends AuthState {}

class AuthenticationSuccess extends AuthState {}

class AuthenticationFail extends AuthState {}
