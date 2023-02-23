import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuccessMessageAfterSubmit {
  successMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0);
  }
}
