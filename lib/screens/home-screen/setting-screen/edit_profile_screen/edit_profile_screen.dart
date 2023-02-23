import 'package:budget_manager_flutter/screens/home-screen/setting-screen/edit_profile_screen/change_password.dart';
import 'package:flutter/material.dart';

import '../../../global_variables.dart';
import 'change_login.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: ListView(children: [
          _pagetitle(),
          Divider(
              height: 20,
              indent: 10,
              endIndent: 10,
              thickness: 1,
              color: Colors.white),
          _settingItemsContainer(context),
        ]),
      ),
    );
  }

  Widget _pagetitle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Text(
          "Profile Settings",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _settingItemsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.82,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: GridView.count(
                crossAxisCount: 2,
                children: _buildGridList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGridList() {
    return [
      _buildGridItem("Change\nPassword", Icons.lock,
          () => ChangePassword().changePassword(context)),
      // _buildGridItem("Change\nEmail", Icons.email),
      _buildGridItem("Change\nUsername", Icons.person,
          () => ChangeLogin().changeLogin(context)),
      // _buildGridItem("Change\nAvatar", Icons.image),
      // _buildGridItem("Export to CSV", Icons.file_copy),
      // _buildGridItem("Set\nPincode", Icons.lock_open),
      // _buildGridItem("Delete\nAccount", Icons.delete, ),
    ];
  }

  Widget _buildGridItem(
    String title,
    IconData icon,
    void Function() onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
