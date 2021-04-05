import 'package:envato/api/api.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/database/provider.dart';
import 'package:envato/models/model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final application = Application();
  final database = DatabaseProvider();

  ///Fetch api login
  Future<dynamic> login({
    required String username,
    required password,
  }) async {
    final params = {'username': ''};
    return await Api.login(params);
  }

  Future<void> saveUser({required UserModel user}) async {
    Batch batch = DatabaseProvider.database!.batch();
    batch.insert(
      DatabaseProvider.tableUser,
      user.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }

  Future<UserModel?> getUser() async {
    final List userList = await DatabaseProvider.database!.query(
      DatabaseProvider.tableUser,
      limit: 1,
    );
    if (userList.isNotEmpty) {
      return UserModel.fromDatabase(userList[0]);
    }
    return null;
  }

  Future<void> deleteUser() async {
    await FirebaseMessaging.instance.deleteToken();
    await database.clearDatabase();
  }

  ///Singleton factory
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}
