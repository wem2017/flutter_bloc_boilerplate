enum ValidateType {
  email,
  password,
  phone,
}

class UtilValidator {
  static const String errorEmpty = "value_not_empty";
  static const String errorRange = "value_not_valid_range";
  static const String errorEmail = "value_not_valid_email";
  static const String errorPhone = "value_not_valid_phone";
  static const String errorPassword = "value_not_valid_password";
  static const String errorId = "value_not_valid_id";

  static validate(
    String data, {
    required ValidateType type,
    int? min,
    int? max,
    bool allowEmpty = false,
  }) {
    ///Empty
    if (!allowEmpty && data.isEmpty) {
      return errorEmpty;
    }

    switch (type) {
      case ValidateType.email:

        ///Email pattern
        final RegExp emailRegex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        if (!emailRegex.hasMatch(data)) {
          return errorEmail;
        }
        return null;
      case ValidateType.phone:

        ///Phone pattern
        final RegExp phoneRegex = RegExp(r'^[0-9]*$');
        if (!phoneRegex.hasMatch(data)) {
          return errorPhone;
        }
        return null;

      default:
        return null;
    }
  }

  ///Singleton factory
  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
