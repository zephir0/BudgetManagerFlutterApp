import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/home-screen/setting-screen/setting_menu_items.dart';
import 'package:flutter/material.dart';

import 'edit_profile_screen/edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration:
              BoxDecoration(gradient: GlobalVariables().backgroundGradient),
          child: Column(children: [
            userAvatar(context),
            editProfileButton(context),
            SettingMenuItems().mainMenu(context)
          ])),
    );
  }

  Center userAvatar(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              onPressed: () {
                print("AVATAR CHANGE");
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://steamuserimages-a.akamaihd.net/ugc/795370174521845565/8F2A715B24E6CDDBC4F9DE5AF12D5D25843FD477/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true"),
                radius: 60,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                "Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Text(
              "adres@gmail.com",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 167, 165, 165),
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Center editProfileButton(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Color.fromARGB(255, 15, 150, 173)),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditProfileScreen())),
        child: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
