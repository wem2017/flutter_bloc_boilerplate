import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/models/model.dart';
import 'package:envato/repository/repository.dart';

enum AuthenticationState {
  loading,
  success,
  fail,
}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.loading);

  ///onAuthCheck
  Future<void> onCheck() async {
    UserModel? user = await UserRepository.getUser();
    if (user != null) {
      ///Attach token push
      Application.setDeviceToken();

      ///Trick Offline get token issue firebase
      double delay = 0.0;
      while (Application.device?.token == null && delay <= 2) {
        await Future.delayed(const Duration(milliseconds: 500));
        delay += 0.25;
      }

      ///Save user
      await AppBloc.userCubit.onSaveUser(user);

      ///Valid token
      final result = await UserRepository.validateToken();
      if (result != null) {
        ///Update user
        await AppBloc.userCubit.onSaveUser(result);
      }
      if (state != AuthenticationState.fail) {
        /// Notify
        emit(AuthenticationState.success);
      }
    } else {
      ///Notify
      emit(AuthenticationState.fail);
    }
  }

  ///onAuthSync
  Future<void> onSave(UserModel user) async {
    ///Save user
    await AppBloc.userCubit.onSaveUser(user);

    ///Notify
    emit(AuthenticationState.success);
  }

  ///onClear
  Future<void> onClear() async {
    emit(AuthenticationState.fail);
    AppBloc.userCubit.onClear();
  }
}
