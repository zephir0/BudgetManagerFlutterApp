import 'dart:convert';

import 'package:budget_manager_flutter/auth/user_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/budget.dart';
import '../model/user.dart';

class JsonService {
  // final String backEndServerUrl = "https://serene-reaches-23699.herokuapp.com";
  String backEndServerUrl = "http://192.168.0.14:8080";
  final UserSession session = UserSession();

  Future<User> getUser() async {
    var url = Uri.parse(backEndServerUrl + "/api/user");
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
    var url = Uri.parse(backEndServerUrl + "/api/budget/count/total");
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

  Future<List<Budget>> getBudgetHistoryByDate(String dayNumber) async {
    var url = Uri.parse(backEndServerUrl + "/api/budget/findAll/${dayNumber}");
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

  Future<List<Budget>> getIncomeOrExpense() async {
    var url = Uri.parse(backEndServerUrl + "/api/budget/findAll");
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

  Future editBudget(String expenseOrIncome,
      TextEditingController textEditingController, Budget budget) async {
    var url = Uri.parse(backEndServerUrl + "/api/budget/${budget.id}");
    var body = json.encode({expenseOrIncome: textEditingController.text});

    await http.put(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: body);
  }

  void updateBudget(TextEditingController textEditingController,
      String expenseOrIncome) async {
    var url = Uri.parse(backEndServerUrl + "/api/budget/");
    var body = json.encode({expenseOrIncome: textEditingController.text});

    await http.post(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: body);
  }
}
