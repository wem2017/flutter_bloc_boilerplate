import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:envato/repository/repository.dart';

enum SignState { init, signIn, signOut }

class SignCubit extends Cubit<SignState> {
  SignCubit() : super(SignState.init);

  ///On Login
  void onLogin({
    required String username,
    required String password,
  }) async {
    ///Notify
    emit(SignState.signIn);

    ///Attach token push
    await Application.setDeviceToken();

    final result = await UserRepository.login(
      username: username,
      password: password,
    );

    if (result != null) {
      ///Auth Sync
      await AppBloc.authenticationCubit.onSave(result);
    }

    ///Notify
    emit(SignState.init);
  }

  ///onLoginByToken
  void onLoginByToken(String token) async {
    ///Notify
    emit(SignState.signIn);

    ///Attach token push
    await Application.setDeviceToken();

    final user = UserModel.fromJson({
      "user": {
        "_id": "qrcode",
        "available_earnings": "",
        "username": "qrcode",
      },
      "token": token,
    });

    ///Save user to state
    await AppBloc.userCubit.onSetUser(user);

    ///Valid token
    final result = await UserRepository.validateToken();
    if (result != null) {
      ///Auth Sync
      await AppBloc.authenticationCubit.onSave(result);
    }

    ///Notify
    emit(SignState.init);
  }

  Future<void> onLogOut() async {
    ///Notify
    emit(SignState.signOut);
    await Future.delayed(const Duration(milliseconds: 500));
    await AppBloc.authenticationCubit.onClear();
    emit(SignState.init);
  }
}
