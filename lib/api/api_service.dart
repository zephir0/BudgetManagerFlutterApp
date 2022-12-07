import 'dart:convert';

import 'package:budget_manager_flutter/model/user.dart';
import 'package:budget_manager_flutter/auth/session.dart';
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
      print(budgetList);
      return budgetList;
    } else {
      throw Exception("Failed to get a balance.");
    }
  }

  Future popDialogMenu(BuildContext context, String expenseOrIncome) async {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: formkey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: textEditingController,
                  ),
                  ElevatedButton(
                      onPressed: (() async {
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
                        Navigator.pop(context);
                      }),
                      child: Text("Save"))
                ]),
              ),
            );
          });
        });
  }
}
