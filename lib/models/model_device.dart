class DeviceModel {
  final String uuid;
  final String? userID;
  final String? name;
  final String? model;
  final String? version;
  final String? appVersion;
  String? token;
  final String? type;
  final DateTime? lastAccessTime;
  final DateTime? registerTime;

  DeviceModel({
    required this.uuid,
    this.userID,
    this.name,
    this.model,
    this.version,
    this.appVersion,
    this.token,
    this.type,
    this.lastAccessTime,
    this.registerTime,
  });

  set newToken(String? value) {
    if (value != null) {
      token = value;
    }
  }

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    final access = json['last_access_time'];
    final register = json['register_time'];

    DateTime accessTime = DateTime.now().toUtc();
    DateTime registerTime = DateTime.now().toUtc();

    if (access != null) {
      accessTime = DateTime.fromMicrosecondsSinceEpoch(
        access * 1000,
        isUtc: true,
      );
    }
    if (register != null) {
      registerTime = DateTime.fromMicrosecondsSinceEpoch(
        register * 1000,
        isUtc: true,
      );
    }

    return DeviceModel(
      uuid: json['uuid'],
      userID: json['user_id'],
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      version: json['version'] ?? '',
      appVersion: json['app_version'] ?? '',
      token: json['token'],
      type: json['type'] ?? '',
      lastAccessTime: accessTime,
      registerTime: registerTime,
    );
  }
}
