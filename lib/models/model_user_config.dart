class UserConfigModel {
  final bool enablePushNotification;
  final bool enableEmailNotification;
  final bool alertLogin;

  UserConfigModel({
    required this.enablePushNotification,
    required this.enableEmailNotification,
    required this.alertLogin,
  });
  factory UserConfigModel.fromJson(Map<String, dynamic> json) {
    return UserConfigModel(
      enablePushNotification: json['push_notification'] ?? false,
      enableEmailNotification: json['email_notification'] ?? false,
      alertLogin: json['alert_login'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'push_notification': enablePushNotification,
      'email_notification': enableEmailNotification,
      'alert_login': alertLogin,
    };
  }
}
