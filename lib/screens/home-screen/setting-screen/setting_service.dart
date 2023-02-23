import 'package:flutter/cupertino.dart';

import '../../../api/api_service.dart';
import '../../../auth/user_session.dart';

class SettingService {
  void logoutFunction(BuildContext context) {
    var session = UserSession();
    session.clearCookies();
    ApiService().logout();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  void deleteAllBudgets(BuildContext context) {
    ApiService().deleteAllBudgets();
    Navigator.popAndPushNamed(context, "/home");
  }
}
