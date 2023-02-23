import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:budget_manager_flutter/auth/user_session.dart';
import 'package:budget_manager_flutter/screens/home-screen/setting-screen/setting_service.dart';
import 'package:budget_manager_flutter/screens/home-screen/setting-screen/ticket-screen/ticket_screen.dart';
import 'package:flutter/material.dart';

class SettingMenuItems {
  Padding mainMenu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Column(children: [
        menuBuilder(context, Icons.restore, "Reset everything",
            () => SettingService().deleteAllBudgets(context)),
        menuBuilder(
          context,
          Icons.headphones_battery,
          "Help Center",
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TicketScreen())),
        ),
        menuBuilder(context, Icons.notifications, "Notifications",
            () => SettingService().logoutFunction(context)),
        menuBuilder(context, Icons.logout, "Log out",
            () => SettingService().logoutFunction(context)),
      ]),
    );
  }

  Widget menuBuilder(BuildContext context, IconData icon, String text,
      void Function() onPressed) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 39, 119)),
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
          )),
    );
  }
}
