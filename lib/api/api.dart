import 'dart:async';

import 'package:envato/api/http_manager.dart';
import 'package:envato/models/model.dart';
import 'package:envato/repository/repository.dart';

class Api {
  static final httpManager = HTTPManager();
  static final userRepository = UserRepository();

  ///URL API
  static const String LOGIN = "/api/sync/login";

  ///Login api
  static Future<dynamic> login(params) async {
    Map<String, dynamic> result = await httpManager.post(
      url: LOGIN,
      data: params,
    );
    result['success'] = true;
    result['data'] = {"_id": ''};
    return ResultModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
