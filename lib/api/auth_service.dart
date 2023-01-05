import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/user_session.dart';
import '../model/user.dart';
import '../screens/home-page/home_screen.dart';
import 'api_service.dart';

class AuthService {
  Future<bool> login(User user, BuildContext buildContext) async {
    String url = ApiService().backEndServerUrl + "/auth/api/login";
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'login': user.login, 'password': user.password}));

    if (response.statusCode == 200) {
      UserSession().getCookie(response);
      var session = UserSession();
      session.cookies = UserSession().getCookie(response);
      Navigator.push(buildContext,
          MaterialPageRoute(builder: (buildContext) => HomeScreen()));
      return false;
    } else
      return true;
  }

  Future<bool> register(User user, BuildContext context) async {
    String url = ApiService().backEndServerUrl + "/auth/api/register";
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'login': user.login, 'password': user.password}));
    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }
}
