import 'package:envato/models/model.dart';

abstract class AuthEvent {}

class OnAuthCheck extends AuthEvent {}

class OnAuthProcess extends AuthEvent {
  final UserModel user;
  OnAuthProcess({required this.user});
}

class OnClear extends AuthEvent {}
