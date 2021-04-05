enum ValidateType {
  email,
  password,
  phone,
}

class UtilValidator {
  static const String error_empty = "value_not_empty";
  static const String error_range = "value_not_valid_range";
  static const String error_email = "value_not_valid_email";
  static const String error_phone = "value_not_valid_phone";
  static const String error_password = "value_not_valid_password";
  static const String error_id = "value_not_valid_id";

  static validate(
    String data, {
    ValidateType? type,
    int? min,
    int? max,
    bool allowEmpty = false,
  }) {
    ///Empty
    if (!allowEmpty && data.isEmpty) {
      return error_empty;
    }

    switch (type) {
      case ValidateType.email:

        ///Email pattern
        final RegExp emailRegex = new RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        if (!emailRegex.hasMatch(data)) {
          return error_email;
        }
        return null;
      case ValidateType.phone:

        ///Phone pattern
        final RegExp phoneRegex = new RegExp(r'^[0-9]*$');
        if (!phoneRegex.hasMatch(data)) {
          return error_phone;
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
