import 'dart:convert';
import 'dart:math';

import 'package:budget_manager_flutter/auth/user_session.dart';
import 'package:budget_manager_flutter/model/expense_category.dart';
import 'package:budget_manager_flutter/model/income_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/budget.dart';
import '../model/budget_type.dart';
import '../model/user.dart';
import 'api_service.dart';

class BudgetJsonService {
  final UserSession session = UserSession();

  Future<Budget> getBalance() async {
    var url =
        Uri.parse(ApiService().backEndServerUrl + "/api/budget/count/total");
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
    var url = Uri.parse(
        ApiService().backEndServerUrl + "/api/budget/findAll/${dayNumber}");
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

  Future<List<Budget>> getBudgetByCategoryName(
      String budgetType, String categoryName) async {
    var url = Uri.parse(ApiService().backEndServerUrl +
        "/api/budget/${budgetType.toLowerCase()}/findAll/${categoryName}");
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

  Future<List<Budget>> getAllBudget() async {
    var url = Uri.parse(ApiService().backEndServerUrl + "/api/budget/findAll");
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

  Future editBudget(
      TextEditingController textEditingController, Budget budget) async {
    var url =
        Uri.parse(ApiService().backEndServerUrl + "/api/budget/${budget.id}");

    Map<String, dynamic> jsonData;

    if (budget.budgetType == BudgetType.EXPENSE) {
      jsonData = {
        "value": -1 * int.parse(textEditingController.text),
        "budgetType": BudgetType.EXPENSE.toString().split('.').last
      };
    } else {
      jsonData = {
        "value": int.parse(textEditingController.text),
        "budgetType": BudgetType.INCOME.toString().split('.').last
      };
    }

    await http.put(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: json.encode(jsonData));
  }

  void addBudget(TextEditingController textEditingController,
      TextEditingController selectedCategory, BudgetType budgetType) async {
    var url = Uri.parse(ApiService().backEndServerUrl + "/api/budget/");
    String categoryType =
        budgetType == BudgetType.INCOME ? "incomeCategory" : "expenseCategory";

    Map<String, dynamic> jsonData = {
      "value": budgetType == BudgetType.INCOME
          ? int.parse(textEditingController.text)
          : -int.parse(textEditingController.text),
      "budgetType": budgetType.toString().split('.').last,
      categoryType:
          selectedCategory.text.isEmpty ? "OTHERS" : selectedCategory.text,
    };
    await http.post(url,
        headers: {
          'Cookie': 'JSESSIONID=${session.cookies}',
          'Content-type': 'application/json'
        },
        body: json.encode(jsonData));
  }
}
