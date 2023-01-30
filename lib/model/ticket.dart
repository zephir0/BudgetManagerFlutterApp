// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/scheduler.dart';

import 'package:budget_manager_flutter/model/chat_message.dart';

class Ticket {
  late int id;
  late String subject;
  late String message;
  late String createdAt;
  late String updatedAt;

  Ticket({
    required this.id,
    required this.subject,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        createdAt: json['subject'],
        message: json['message'],
        subject: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
