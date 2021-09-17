import 'package:envato/api/api.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/database/provider.dart';
import 'package:envato/models/model.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  ///Login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final result = await Api.requestLogin({
      'username': username,
      'password': password,
    });

    ///Case API success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Valid Token
  static Future<UserModel?> validateToken() async {
    final result = await Api.requestValidateToken();

    ///Fetch api success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Get user remote
  static Future<UserModel?> getUserRemote() async {
    final result = await Api.requestUser();

    ///Case API success
    if (result.success) {
      return UserModel.fromJson(result.data);
    }

    ///show message
    AppBloc.messageBloc.add(OnMessage(message: result.message));
  }

  ///Save User
  static Future<void> saveUser({required UserModel user}) async {
    user.setActive(true);

    final userList = await getUserList();
    final exist = userList.where((item) => item.id == user.id).isNotEmpty;

    Batch batch = DatabaseProvider.database!.batch();

    if (userList.isEmpty || !exist) {
      userList.add(user);
    }

    for (var element in userList) {
      if (element.id == user.id) {
        element = user;
      } else {
        element.setActive(false);
      }
      batch.insert(
        DatabaseProvider.tableUser,
        element.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  ///Get User
  static Future<UserModel?> getUser() async {
    final List userList = await DatabaseProvider.database!.query(
      DatabaseProvider.tableUser,
      limit: 1,
      where: 'active = ?',
      whereArgs: [1],
    );
    if (userList.isNotEmpty) {
      return UserModel.fromDatabase(userList.first);
    }
  }

  ///Get User List
  static Future<List<UserModel>> getUserList() async {
    final List userList = await DatabaseProvider.database!.query(
      DatabaseProvider.tableUser,
      orderBy: 'lastUsed DESC',
    );
    return userList.map((e) {
      return UserModel.fromDatabase(e);
    }).toList();
  }

  ///Delete User
  static Future<void> deleteUser(UserModel user) async {
    await DatabaseProvider.database!.delete(
      DatabaseProvider.tableUser,
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  ///Singleton factory
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}
