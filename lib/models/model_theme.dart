import 'package:envato/utils/utils.dart';
import 'package:flutter/material.dart';

class ThemeModel {
  final String name;
  final Color primary;
  final Color secondary;

  ThemeModel({
    required this.name,
    required this.primary,
    required this.secondary,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      name: json['name'] ?? '',
      primary: UtilColor.getColorFromHex(json['primary']),
      secondary: UtilColor.getColorFromHex(json['secondary']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "primary": UtilColor.getStringColor(primary),
      "secondary": UtilColor.getStringColor(secondary),
    };
  }
}
