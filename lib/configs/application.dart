import 'package:envato/models/model.dart';
import 'package:envato/utils/device.dart';

class Application {
  /// [Production - Dev]
  /// "sale-tracker-vhf6zehy" - "sale-tracker-9wkmolrl"

  static const bool debug = true;
  static const String version = '1.2.4';
  static const String dateFormat = 'HH:mm, MMM dd yyyy';
  static const String clientID = "";
  static const String domain = "https://api.saleboltapp.com";
  static const String playStoreID = "com.huynh.envato";
  static const String appStoreID = "1526910309";
  static const String statementSyncTime = '2021-01-01';
  static const String supportEmail = 'service@passionui.com';
  static const String website = 'https://saleboltapp.com';
  static bool localTimeZone = true;
  static DeviceModel? device;

  static Future<void> setDevice() async {
    device = await UtilDevice.loadDevice();
  }

  static Future<void> setDeviceToken() async {
    final token = await UtilDevice.getDeviceToken();
    device!.newToken = token;
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
