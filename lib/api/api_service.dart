import 'package:budget_manager_flutter/auth/user_session.dart';

import 'package:http/http.dart' as http;

class ApiService {
  // String backEndServerUrl = "https://serene-reaches-23699.herokuapp.com";
  final String backEndServerUrl = "http://192.168.0.14:8080";
  final UserSession session = UserSession();

  Future<bool> deleteBudget(int? id) async {
    var url = Uri.parse(backEndServerUrl + "/api/budget/${id}");
    await http.delete(
      url,
      headers: {
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-type': 'application/json'
      },
    );
    return true;
  }

  Future logout() async {
    try {
      var url = Uri.parse(backEndServerUrl + "/auth/api/logout");
      await http.post(url, headers: {
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-type': 'application/json'
      });
    } catch (e) {
      print(e);
    }
  }

  Future deleteAllBudgets() async {
    try {
      var url = Uri.parse(backEndServerUrl + "/api/budget/deleteAll");
      await http.delete(url, headers: {
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-type': 'application/json'
      });
    } catch (e) {
      print(e);
    }
  }
}
