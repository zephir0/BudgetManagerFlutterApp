import 'dart:convert';

import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:budget_manager_flutter/api/auth_service.dart';
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
  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  bool isFormVisible = true;
  bool isUserPassVisible = true;
  bool isRegisterButtonVisible = true;
  bool isGoToLoginPageVisible = false;
  bool isFailedMessageVisible = false;
  bool isSuccessMessageVisible = false;

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
              visible: isFailedMessageVisible,
              child: displayRegisterMessage(false)),
          Visibility(
            visible: isSuccessMessageVisible,
            child: displayRegisterMessage(true),
          ),
          Visibility(visible: isFormVisible, child: userLoginForm(user)),
          Visibility(
              visible: isUserPassVisible,
              child: LoginScreenState().userPasswordForm(user, passwordKey)),
          Visibility(
              visible: isRegisterButtonVisible,
              child: regiterButton(context, user)),
          Visibility(
              visible: isGoToLoginPageVisible,
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
              AuthService()
                  .register(user, context)
                  .then((value) => registeredSuccess(value));
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

  Padding displayRegisterMessage(bool success) {
    return Padding(
      padding: success
          ? const EdgeInsets.fromLTRB(20, 30, 20, 40)
          : EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Center(
        child: Column(
          children: [
            Text(
              success ? "CONGRATULATIONS!" : "REGISTRATION FAILED!",
              style: TextStyle(
                  color:
                      success ? Color.fromARGB(255, 51, 223, 102) : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: success ? 25 : 20),
            ),
            Text(
              success ? "YOU HAVE!" : "LOGIN ALREADY EXIST",
              style: TextStyle(
                  color:
                      success ? Color.fromARGB(255, 255, 255, 255) : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: success ? 25 : 18),
            ),
            success
                ? Text(
                    "SUCCESSFULLY REGISTERED!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void registeredSuccess(var value) {
    if (value == false) {
      setState(() {
        isSuccessMessageVisible = true;
        isFormVisible = false;
        isUserPassVisible = false;
        isRegisterButtonVisible = false;
        isGoToLoginPageVisible = true;
        isFailedMessageVisible = false;
      });
    } else {
      setState(() {
        isFailedMessageVisible = true;
      });
    }
  }
}
