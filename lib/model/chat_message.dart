// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/scheduler.dart';

import 'package:budget_manager_flutter/model/chat_message.dart';

class ChatMessage {
  late int? id;
  late String message;
  late String? createdAt;
  late bool? admin;
  ChatMessage({
    this.id,
    required this.message,
    this.createdAt,
    this.admin,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        id: json['id'],
        message: json['message'],
        createdAt: json['createdAt'],
        admin: json['admin']);
  }
}
