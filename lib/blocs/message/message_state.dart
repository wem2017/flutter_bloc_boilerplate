import 'package:flutter/material.dart';

abstract class MessageState {}

class MessageInit extends MessageState {}

class MessageShow extends MessageState {
  final String text;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;

  MessageShow({
    required this.text,
    this.action,
    this.onPressed,
    this.duration,
  });
}
