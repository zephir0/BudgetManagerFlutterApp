import 'package:http/http.dart' as http;

class UserSession {
  static final UserSession _session = UserSession._internal();

  factory UserSession() {
    return _session;
  }
  late String cookies;

  UserSession._internal();

  String getCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");

    return refreshToken.substring(idx + 1).trim();
  }

  void clearCookies() {
    cookies = "";
  }
}
