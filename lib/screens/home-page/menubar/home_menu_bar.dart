import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../setting-page/setting_screen.dart';
import '../../statistics-page/category_screen.dart';

class HomeMenuBar {
  Padding menuBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          menuBarCreator(context, Icons.calendar_month, "HISTORY",
              route: SettingScreen()),
          menuBarCreator(context, Icons.auto_graph_outlined, "STATISTICS",
              route: CategoryScreen()),
          menuBarCreator(context, Icons.settings, "SETTINGS",
              route: SettingScreen()),
        ],
      ),
    );
  }

  Container menuBarCreator(BuildContext context, IconData icon, String menuName,
      {required Widget route}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(156, 28, 146, 243),
              Color.fromARGB(156, 22, 104, 100)
            ]),
      ),
      height: MediaQuery.of(context).size.height * 0.105,
      width: MediaQuery.of(context).size.width * 0.28,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => route)),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  menuName.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
