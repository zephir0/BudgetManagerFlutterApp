import 'dart:convert';

import 'package:budget_manager_flutter/model/user.dart';
import 'package:budget_manager_flutter/auth/session.dart';
import 'package:budget_manager_flutter/screens/home-page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../model/budget.dart';

class ApiService {
  Future<User> getUser() async {
    var session = Session();
    var url = Uri.parse("http://192.168.0.14:9999/api/user");

    var request = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );
    if (request.statusCode == 200) {
      return User.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Failed to show user details");
    }
  }

  Future<Budget> getBalance() async {
    var session = Session();
    var url = Uri.parse("http://192.168.0.14:9999/api/budget/count/total");

    var request = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );

    if (request.statusCode == 200) {
      return Budget.fromJsonBalance(jsonDecode(request.body));
    } else {
      throw Exception("Failed to get a balance.");
    }
  }

  Future<List<Budget>> getIncomeOrExpense() async {
    var session = Session();
    var url = Uri.parse("http://192.168.0.14:9999/api/budget/findAll");

    var request = await http.get(
      url,
      headers: {'Cookie': 'JSESSIONID=${session.cookies}'},
    );

    if (request.statusCode == 200) {
      List<Budget> budgetList = (json.decode(request.body) as List)
          .map((data) => Budget.fromJson(data))
          .toList();
      return budgetList;
    } else {
      throw Exception("Failed to get a balance.");
    }
  }

  Future popDialogMenu(
      BuildContext context, String expenseOrIncome, String dialogText) async {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Color.fromARGB(255, 31, 30, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Form(
                key: formkey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      dialogText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "...",
                        hintStyle:
                            TextStyle(fontSize: 15, color: Colors.white)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field cannot be empty";
                      } else
                        return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: textEditingController,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 53, 219, 197),
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                      ),
                      onPressed: (() async {
                        if (formkey.currentState!.validate()) {
                          var session = Session();
                          var url =
                              Uri.parse("http://192.168.0.14:9999/api/budget/");
                          var body = json.encode(
                              {expenseOrIncome: textEditingController.text});

                          await http.post(url,
                              headers: {
                                'Cookie': 'JSESSIONID=${session.cookies}',
                                'Content-type': 'application/json'
                              },
                              body: body);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      }),
                      child: Text("Save"))
                ]),
              ),
            );
          });
        });
  }
}
