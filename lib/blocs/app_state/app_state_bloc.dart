import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/repository/repository.dart';

import 'bloc.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppStateBloc() : super(AppStateInitial());

  final userRepository = UserRepository();

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    if (event is OnResume) {
      yield Active();

      ///More Task
    }
    if (event is OnBackground) {
      yield Background();
    }
  }
}
