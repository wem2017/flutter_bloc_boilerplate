import 'package:bloc/bloc.dart';
import 'package:envato/app.dart';
import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(BlocBase bloc, Object event) {
    UtilLogger.log('BLOC EVENT', event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    UtilLogger.log('BLOC ERROR', error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(BlocBase bloc, Transition transition) {
    UtilLogger.log('BLOC TRANSITION', transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
