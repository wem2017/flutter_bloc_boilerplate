import 'dart:async';

import 'package:envato/api/http_manager.dart';
import 'package:envato/models/model.dart';

class Api {
  static final httpManager = HTTPManager();

  static const String login = "/api/sync/login";
  static const String validateToken = "/api/sync/token";
  static const String user = "/api/private/user";

  static Future<ResultModel> requestLogin(params) async {
    await Future.delayed(const Duration(seconds: 1));
    // final result = await httpManager.post(url: login, data: params);
    final result = {
      'success': true,
      'data': {
        "user": {
          "_id": "qrcode",
          "available_earnings": "",
          "username": "qrcode",
        },
        "token": 'token',
      }
    };
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestValidateToken() async {
    await Future.delayed(const Duration(seconds: 1));
    // final result = await httpManager.post(url: validateToken);
    final result = {
      'success': true,
      'data': {
        "user": {
          "_id": "qrcode",
          "available_earnings": "",
          "username": "qrcode",
        },
        "token": 'token',
      }
    };
    return ResultModel.fromJson(result);
  }

  static Future<ResultModel> requestUser() async {
    await Future.delayed(const Duration(seconds: 1));
    // final result = await httpManager.get(url: user);
    final result = {
      'success': true,
      'data': {
        "user": {
          "_id": "qrcode",
          "available_earnings": "",
          "username": "qrcode",
        },
        "token": 'token',
      }
    };
    return ResultModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
