import 'package:flutter/material.dart';

class ThemeModel {
  final String name;
  final Color color;
  final String lightTheme;
  final String darkTheme;

  ThemeModel(
    this.name,
    this.color,
    this.lightTheme,
    this.darkTheme,
  );

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      json['name'] ?? "",
      json['color'] ?? Colors.black,
      json['light'] ?? "",
      json['dark'] ?? "",
    );
  }
}
