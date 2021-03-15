abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}

class DatabaseProcessing extends DatabaseState {
  final int value;
  DatabaseProcessing({this.value});
}

class DatabaseSyncCompleted extends DatabaseState {}
