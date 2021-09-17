class UserPermissionModel {
  final bool pushNotification;
  final bool emailNotification;
  final bool multipleDevice;
  final bool showAds;

  UserPermissionModel({
    required this.pushNotification,
    required this.emailNotification,
    required this.multipleDevice,
    required this.showAds,
  });

  factory UserPermissionModel.fromJson(Map<String, dynamic> json) {
    return UserPermissionModel(
      pushNotification: json['push_notification'] ?? false,
      emailNotification: json['multiple_device'] ?? false,
      multipleDevice: json['email_notification'] ?? false,
      showAds: json['show_ads'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'push_notification': pushNotification,
      'multiple_device': emailNotification,
      'email_notification': multipleDevice,
      'show_ads': showAds,
    };
  }
}
