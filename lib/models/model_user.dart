import 'dart:convert';

import 'package:envato/blocs/bloc.dart';
import 'package:envato/models/model.dart';

class UserModel {
  final String id;
  final String image;
  final String banner;
  final String username;
  final String firstName;
  final String surname;
  final double availableEarnings;
  final double totalDeposits;
  final int totalSale;
  final double balance;
  final String country;
  final String? token;
  final String? envatoToken;
  final int followers;
  final UserConfigModel configs;
  final UserPermissionModel permissions;
  final DateTime lastUsed;
  bool active;

  UserModel({
    required this.id,
    required this.image,
    required this.banner,
    required this.username,
    required this.firstName,
    required this.surname,
    required this.availableEarnings,
    required this.totalDeposits,
    required this.totalSale,
    required this.balance,
    required this.country,
    this.token,
    this.envatoToken,
    required this.followers,
    required this.configs,
    required this.permissions,
    required this.lastUsed,
    required this.active,
  });

  void setActive(bool active) {
    this.active = active;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> user = json['user'];

    return UserModel(
      id: user['_id'],
      image: user['image'] ?? '',
      banner: user['homepage_image'] ?? '',
      username: user['username'] ?? '',
      firstName: user['firstname'] ?? '',
      surname: user['surname'] ?? '',
      availableEarnings: double.tryParse(user['available_earnings']) ?? 0.0,
      totalDeposits: double.tryParse(user['total_deposits'] ?? '') ?? 0.0,
      totalSale: int.tryParse(user['sales'] ?? '') ?? 0,
      balance: double.tryParse(user['balance'] ?? '') ?? 0.0,
      country: user['country'] ?? '',
      token: json['token'] ?? AppBloc.userCubit.state!.token,
      envatoToken: user['access_token'],
      followers: int.tryParse(user['followers'] ?? '') ?? 0,
      configs: UserConfigModel.fromJson(json['configs'] ?? {}),
      permissions: UserPermissionModel.fromJson(json['permissions'] ?? {}),
      lastUsed: DateTime.now().toUtc(),
      active: false,
    );
  }

  factory UserModel.fromDatabase(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      image: json['image'] ?? '',
      banner: json['banner'] ?? '',
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      surname: json['surname'] ?? '',
      availableEarnings: json['availableEarnings'] ?? 0.0,
      totalDeposits: json['totalDeposits'] ?? 0.0,
      totalSale: json['totalSale'] ?? 0,
      balance: json['balance'] ?? 0.0,
      country: json['country'] ?? '',
      token: json['token'],
      envatoToken: json['envatoToken'],
      followers: json['followers'] ?? 0,
      configs: UserConfigModel.fromJson(jsonDecode(json['configs']) ?? {}),
      permissions: UserPermissionModel.fromJson(
        jsonDecode(json['permissions']) ?? {},
      ),
      lastUsed: DateTime.fromMillisecondsSinceEpoch(
        json['lastUsed'],
        isUtc: true,
      ),
      active: json['active'] == 1,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      "id": id,
      "image": image,
      "banner": banner,
      "username": username,
      "firstName": firstName,
      "surname": surname,
      "availableEarnings": availableEarnings,
      "totalDeposits": totalDeposits,
      "totalSale": totalSale,
      "balance": balance,
      "country": country,
      "token": token,
      "envatoToken": envatoToken,
      "followers": followers,
      "configs": jsonEncode(configs.toJson()),
      "permissions": jsonEncode(permissions.toJson()),
      "lastUsed": lastUsed.millisecondsSinceEpoch,
      "active": active == true ? 1 : 0,
    };
  }
}
