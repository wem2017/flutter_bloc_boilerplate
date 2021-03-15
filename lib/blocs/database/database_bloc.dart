import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envato/blocs/bloc.dart';

import 'bloc.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseInitial());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is OnSyncDatabase) {
      ///Sync database flow
    }
  }
}
