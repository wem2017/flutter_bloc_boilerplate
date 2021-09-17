import 'package:envato/configs/config.dart';
import 'package:flutter/material.dart';

class UtilOther {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static exportMarketIcon(String market) {
    switch (market) {
      case "3DOcean":
        return Images.ocean;
      case "AudioJungle":
        return Images.audioJungle;
      case "CodeCanyon":
        return Images.codeCanyon;
      case "GraphicRiver":
        return Images.graphics;
      case "PhotoDune":
        return Images.photo;
      case "ThemeForest":
        return Images.themeForest;
      case "VideoHive":
        return Images.video;
      default:
        return Images.envato;
    }
  }

  ///Singleton factory
  static final _instance = UtilOther._internal();

  factory UtilOther() {
    return _instance;
  }

  UtilOther._internal();
}
