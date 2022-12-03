import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingMenu {
  Padding menu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Column(children: [
        menuBuilder(context, Icons.restore, "Reset everything"),
        menuBuilder(context, Icons.headphones_battery, "Help Center"),
        menuBuilder(context, Icons.notifications, "Notifications"),
        menuBuilder(context, Icons.logout, "Log out"),
      ]),
    );
  }

  Padding menuBuilder(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.06,
          // decoration: BoxDecoration(color: Colors.amber),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 25, 39, 119)),
            onPressed: (() => print("iconhelp")),
            icon: Icon(icon),
            label: Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
          )),
    );
  }
}
