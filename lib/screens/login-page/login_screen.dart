import 'dart:convert';

import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/login-page/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class LoginScreen extends StatelessWidget {
  User user = User("", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        // ignore: prefer_const_constructors
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: ListView(children: [
          LoginForms().loginIcon(),
          LoginForms().appName(),
          LoginForms().userLoginForm(user),
          LoginForms().userPasswordForm(user),
          LoginForms().loginButton(context, user),
          LoginForms().ctaRegister(),
          LoginForms().registerButton(context)
        ]),
      ),
    );
  }
}
