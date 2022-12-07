import 'dart:convert';

import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/registration-page/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_manager_flutter/model/user.dart';
import 'package:budget_manager_flutter/screens/home-page/home_screen.dart';
import 'package:http/http.dart' as http;
import '../../auth/session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  User user = User("", "");
  bool failLoginMessageVisibility = false;
  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        // ignore: prefer_const_constructors
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: ListView(children: [
          loginIcon(),
          appName(),
          failToLoginMessage(),
          userLoginForm(user, loginKey),
          userPasswordForm(user, passwordKey),
          loginButton(context, user, loginKey, passwordKey),
          ctaRegister(),
          registerButton(context),
        ]),
      ),
    );
  }

  Padding loginIcon() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Image(
          color: Color.fromARGB(255, 39, 34, 63),
          height: 200,
          width: 200,
          image: NetworkImage(
              "https://www.shareicon.net/data/2015/09/20/104303_wallet_512x512.png")),
    );
  }

  Padding appName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              "BUDGET MANAGER",
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontFamily: 'Racing Sans One',
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  Padding userLoginForm(User user, var loginKey) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Form(
        key: loginKey,
        child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This field cannot be empty";
              } else {
                return null;
              }
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

  Padding userPasswordForm(User user, var passwordKey) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Form(
          key: passwordKey,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "This field cannot be empty";
              } else {
                return null;
              }
            },
            style: TextStyle(
                color: GlobalVariables().userInputTextColor,
                fontSize: GlobalVariables().textSize),
            controller: TextEditingController(text: user.password),
            onChanged: (value) {
              user.password = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(
                  Icons.lock,
                  size: 35,
                ),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              fillColor: GlobalVariables().secondaryColor,
              filled: true,
              hintText: "Password",
              contentPadding: const EdgeInsets.fromLTRB(0, 20, 50, 20),
              hintStyle: TextStyle(color: GlobalVariables().hintTextColor),
            ),
          ),
        ));
  }

  Padding loginButton(
      BuildContext context, User user, var loginKey, var passwordKey) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 20, 110, 10),
      child: ElevatedButton(
          onPressed: () {
            if (loginKey.currentState!.validate() &
                passwordKey.currentState!.validate()) {
              login(user, context);
            }
          },
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: GlobalVariables().loginButtonColor,
              minimumSize: GlobalVariables().loginButtonSize),
          // ignore: prefer_const_constructors
          child: Text(
            "SIGN IN",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }

  Padding ctaRegister() {
    // ignore: prefer_const_constructors
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: const Center(
        child: Text(
          "DON'T HAVE ACCOUNT?",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding registerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 0, 110, 10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) => RegistrationScreen()));
          },
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: GlobalVariables().registerButtonColor,
              minimumSize: GlobalVariables().loginButtonSize),
          // ignore: prefer_const_constructors
          child: Text(
            "SIGN UP",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }

  Visibility failToLoginMessage() {
    return Visibility(
        visible: failLoginMessageVisibility,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Text(
            "Wrong password or username",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
          )),
        ));
  }

  Future login(User user, BuildContext buildContext) async {
    String url = "http://192.168.0.14:9999/auth/api/login";
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'login': user.login, 'password': user.password}));

    if (response.statusCode == 200) {
      Session().getCookie(response);
      var session = Session();
      session.cookies = Session().getCookie(response);
      Navigator.push(buildContext,
          MaterialPageRoute(builder: (buildContext) => HomeScreen()));
      setState(() {
        failLoginMessageVisibility = false;
      });
    } else {
      setState(() {
        failLoginMessageVisibility = true;
      });
    }
  }
}
