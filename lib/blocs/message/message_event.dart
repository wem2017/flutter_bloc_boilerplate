import 'package:flutter/material.dart';

abstract class MessageEvent {}

class OnMessage extends MessageEvent {
  final String message;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;
  OnMessage({
    required this.message,
    this.action,
    this.onPressed,
    this.duration,
  });
}
