import 'dart:convert';

import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/login-page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/user.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool registerMessage = false;
  bool formVisibility = true;
  bool userPassVisibility = true;
  bool registerButtonVisibility = true;
  bool goToLoginPageVisibility = false;
  bool failedRegisterMessageVisibility = false;
  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = User("", "");
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: ListView(children: [
          LoginScreenState().loginIcon(),
          Visibility(
              visible: failedRegisterMessageVisibility,
              child: failRegisterMessage()),
          Visibility(
            visible: registerMessage,
            child: successRegisterMessage(),
          ),
          Visibility(visible: formVisibility, child: userLoginForm(user)),
          Visibility(
              visible: userPassVisibility,
              child: LoginScreenState().userPasswordForm(user, passwordKey)),
          Visibility(
              visible: registerButtonVisibility,
              child: regiterButton(context, user)),
          Visibility(
              visible: goToLoginPageVisibility,
              child: gotoLoginPageButton(context, user))
        ]),
      ),
    );
  }

  Padding userLoginForm(User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Form(
        key: loginKey,
        child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This field cannot be empty";
              } else
                return null;
            },
            style: TextStyle(
                color: GlobalVariables().userInputTextColor,
                fontSize: GlobalVariables().textSize),
            controller: TextEditingController(text: user.login),
            onChanged: (value) {
              user.login = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
      ),
    );
  }

  Padding regiterButton(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 0, 110, 10),
      child: ElevatedButton(
          onPressed: () {
            if (loginKey.currentState!.validate() &
                passwordKey.currentState!.validate()) {
              register(user, context);
            }
          },
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: GlobalVariables().registerButtonColor,
              minimumSize: GlobalVariables().loginButtonSize),
          child: Text(
            "REGISTER",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }

  Padding gotoLoginPageButton(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 0, 110, 10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.green,
              minimumSize: GlobalVariables().loginButtonSize),
          child: Center(
            child: Text(
              "LOGIN PAGE",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Padding successRegisterMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
      child: Center(
        child: Column(
          children: [
            Text(
              "CONGRATULATIONS!",
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 223, 102),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Text(
              "YOU HAVE!",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Text(
              "SUCCESSFULLY REGISTERED!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Padding failRegisterMessage() {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Center(
          child: Column(
        children: [
          Text(
            "REGISTRATION FAILED!",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "LOGIN ALREADY EXIST",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      )),
    );
  }

  Future register(User user, BuildContext context) async {
    String url = "http://192.168.0.14:9999/auth/api/register";
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'login': user.login, 'password': user.password}));

    if (response.statusCode == 200) {
      setState(() {
        registerMessage = true;
        formVisibility = false;
        userPassVisibility = false;
        registerButtonVisibility = false;
        goToLoginPageVisibility = true;
        failedRegisterMessageVisibility = false;
      });
    } else {
      setState(() {
        failedRegisterMessageVisibility = true;
      });
    }
  }
}
