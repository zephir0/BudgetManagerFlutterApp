import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalVariables {
  //GlobalColors
  final secondaryColor = const Color.fromRGBO(168, 218, 220, 1);
  final userInputTextColor = Colors.black;

  //HintText
  final hintTextColor = Color.fromARGB(99, 52, 53, 52);
  final double textSize = 17;

  //LOGIN BUTTON
  final loginButtonColor = const Color.fromRGBO(92, 219, 149, 160);
  final loginButtonSize = const Size(100, 60);

  //REGISTER BUTTON
  final registerButtonColor = Color.fromARGB(172, 155, 1, 16);

  var backgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromARGB(255, 15, 95, 160),
        Color.fromARGB(255, 34, 23, 23)
      ]);
}
