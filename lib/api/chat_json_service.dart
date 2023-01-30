import 'dart:convert';

import 'package:budget_manager_flutter/model/chat_message.dart';
import 'package:http/http.dart' as http;

import '../auth/user_session.dart';
import 'api_service.dart';

class ChatJsonService {
  final UserSession session = UserSession();

  Future<List<ChatMessage>> getMessages(int ticketId) async {
    var url =
        Uri.parse(ApiService().backEndServerUrl + "/api/chat/${ticketId}");
    var response = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );

    if (response.statusCode == 200) {
      List<ChatMessage> chatMessages = (json.decode(response.body) as List)
          .map((data) => ChatMessage.fromJson(data))
          .toList();
      return chatMessages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  void createMessage(int ticketId, String message) async {
    Map<String, dynamic> jsonData = {
      "message": message,
    };

    var url =
        Uri.parse(ApiService().backEndServerUrl + "/api/chat/${ticketId}");
    var body = json.encode(jsonData);

    await http.post(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: body);
  }
}
