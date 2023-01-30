import 'dart:convert';

import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:http/http.dart' as http;

import '../auth/user_session.dart';
import '../model/ticket.dart';

class TicketJsonService {
  final UserSession session = UserSession();

  void createTicket(String subject, String message) async {
    Map<String, dynamic> jsonData = {
      "subject": subject,
      "message": message,
    };

    var url = Uri.parse(ApiService().backEndServerUrl + "/api/ticket/");
    var body = json.encode(jsonData);

    await http.post(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: body);
  }

  Future<List<Ticket>> getAllTickets() async {
    var url = Uri.parse(ApiService().backEndServerUrl + "/api/ticket/findAll");
    var request = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );

    if (request.statusCode == 200) {
      List<Ticket> ticketList = (json.decode(request.body) as List)
          .map((data) => Ticket.fromJson(data))
          .toList();
      return ticketList;
    } else {
      throw Exception("Failed to get a balance.");
    }
  }
}
