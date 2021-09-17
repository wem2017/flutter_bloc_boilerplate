import 'dart:io';

class Ads {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894~4114312083";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894~3524953443";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894/6148259114";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894/2950238374";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894/1445703528";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894/9707336924";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
