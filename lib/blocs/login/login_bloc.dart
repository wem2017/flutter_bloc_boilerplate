import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/models/model.dart';
import 'package:envato/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());

  final userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is OnLogin) {
      ///Notify
      yield LoginLoading();

      ///Fetch API via repository
      final ResultModel result = await userRepository.login(
        username: '',
        password: '',
      );

      ///Case API success
      if (result.success) {
        UserModel user = UserModel.fromJson(result.data);

        ///Save
        AppBloc.authBloc.add(OnAuthProcess(user: user));

        ///Notify
        yield LoginSuccess();
      } else {
        ///Notify
        yield LoginFail(result.message);
      }
    }

    ///Event for logout
    if (event is OnLogout) {
      AppBloc.authBloc.add(OnClear());
    }
  }
}
