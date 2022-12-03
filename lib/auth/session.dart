import 'package:http/http.dart' as http;

class Session {
  static final Session _session = Session._internal();
  late String cookies;
  factory Session() {
    return _session;
  }

  Session._internal();

  String getCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");
    // print(refreshToken.substring(idx + 1).trim());
    return refreshToken.substring(idx + 1).trim();
  }
}
