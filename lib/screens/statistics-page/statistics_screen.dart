import 'dart:math';

import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:budget_manager_flutter/model/expense_category.dart';
import 'package:budget_manager_flutter/model/income_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlobalVariables().backgroundGradient),
      child: ListView(
        children: [
          categoryTitle("Income"),
          incomeCategoryList(BudgetType.INCOME),
          categoryTitle("Expense"),
          incomeCategoryList(BudgetType.EXPENSE),
        ],
      ),
    ));
  }

  Padding categoryTitle(String categoryName) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Center(
          child: Column(
            children: [
              Text(
                categoryName,
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: categoryName.contains("Income")
                        ? Colors.green
                        : Colors.red),
              ),
              Divider(
                height: 20,
                indent: 6,
                endIndent: 6,
                thickness: 1,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }

  Padding incomeCategoryList(BudgetType budgetType) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SizedBox(
          height: 200,
          child: GridView.count(
              crossAxisCount: 3,
              children: budgetType == BudgetType.INCOME
                  ? getIncomeCategoryList()
                  : getExpenseCategoryList()),
        ));
  }

  List<Widget> getIncomeCategoryList() {
    List<Widget> categoryList = [];
    for (var element in IncomeCategory.values) {
      categoryList.add(Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                element.icon,
                size: 45,
                color: Colors.white,
              ),
              Text(
                element.name,
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ));
    }
    return categoryList;
  }

  List<Widget> getExpenseCategoryList() {
    List<Widget> categoryList = [];
    for (var element in ExpenseCategory.values) {
      categoryList.add(Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                element.icon,
                size: 45,
                color: Colors.white,
              ),
              Text(
                element.name,
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ));
    }
    return categoryList;
  }
}
