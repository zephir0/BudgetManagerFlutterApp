import 'dart:convert';

import 'package:budget_manager_flutter/model/user.dart';
import 'package:budget_manager_flutter/auth/session.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<User> getUser() async {
    var session = Session();
    var url = Uri.parse("http://192.168.0.14:9999/api/user");

    var request = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );
    if (request.statusCode == 200) {
      return User.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Failed to show user details");
    }
  }
}
