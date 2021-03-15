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
      json['name'] as String ?? "",
      json['color'] as Color ?? Colors.black,
      json['light'] as String ?? "",
      json['dark'] as String ?? "",
    );
  }
}
