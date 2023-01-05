import 'package:budget_manager_flutter/auth/user_session.dart';

import 'package:http/http.dart' as http;

class ApiService {
  String backEndServerUrl = "https://serene-reaches-23699.herokuapp.com";

  Future deleteBudget(int? id) async {
    var session = UserSession();
    var url = Uri.parse(backEndServerUrl + "/api/budget/${id}");

    await http.delete(
      url,
      headers: {
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-type': 'application/json'
      },
    );
  }
}
