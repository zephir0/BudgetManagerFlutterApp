import 'dart:convert';

import 'package:budget_manager_flutter/auth/user_session.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import 'api_service.dart';

class UserJsonService {
  UserSession session = UserSession();
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    Map<String, dynamic> jsonData = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };

    var response = await http.post(
      Uri.parse(ApiService().backEndServerUrl + "/api/user/changePassword"),
      body: jsonEncode(jsonData),
      headers: <String, String>{
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeLogin(String newLogin, String userPassword) async {
    Map<String, dynamic> jsonData = {
      "newLogin": newLogin,
      "userPassword": userPassword,
    };

    var response = await http.post(
      Uri.parse(ApiService().backEndServerUrl + "/api/user/changeLogin"),
      body: jsonEncode(jsonData),
      headers: <String, String>{
        'Cookie': 'JSESSIONID=${session.cookies}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUser() async {
    var url = Uri.parse(ApiService().backEndServerUrl + "/api/user");
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
