import 'dart:convert';

import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/login-page/login_form.dart';
import 'package:budget_manager_flutter/screens/login-page/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/user.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    User user = User("", "");
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: ListView(children: [
          LoginForms().loginIcon(),
          userLoginForm(user),
          LoginForms().userPasswordForm(user),
          regiterButton(context, user),
        ]),
      ),
    );
  }

  Padding userLoginForm(User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextFormField(
          style: TextStyle(
              color: GlobalVariables().userInputTextColor,
              fontSize: GlobalVariables().textSize),
          controller: TextEditingController(text: user.login),
          onChanged: (value) {
            user.login = value;
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              errorText: isRegisterNameWrong ? "Error" : "NULL",
              // ignore: prefer_const_constructors
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Icon(
                  Icons.account_circle,
                  size: 35,
                ),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              fillColor: GlobalVariables().secondaryColor,
              filled: true,
              hintText: "Login",
              contentPadding: const EdgeInsets.fromLTRB(0, 20, 50, 20),
              hintStyle: TextStyle(color: GlobalVariables().hintTextColor))),
    );
  }

  Padding regiterButton(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 0, 110, 10),
      child: ElevatedButton(
          onPressed: () {
            register(user, context);
          },
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: GlobalVariables().registerButtonColor,
              minimumSize: GlobalVariables().loginButtonSize),
          // ignore: prefer_const_constructors
          child: Text(
            "REGISTER",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}

bool isRegisterNameWrong = false;

Future register(User user, BuildContext context) async {
  String url = "http://192.168.0.14:9999/auth/api/register";
  var response = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'login': user.login, 'password': user.password}));

  if (response.statusCode == 200) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  } else if (response.statusCode == 500) {
    setState() => isRegisterNameWrong = true;
  }
}
