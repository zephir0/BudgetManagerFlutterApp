import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:budget_manager_flutter/model/expense_category.dart';
import 'package:budget_manager_flutter/model/income_category.dart';
import 'package:budget_manager_flutter/screens/home-screen/category-screen/income_transactions_screen.dart';
import 'package:flutter/material.dart';

import '../../global_variables.dart';
import 'expense_transactons_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlobalVariables().backgroundGradient),
      child: ListView(
        children: [
          categoryTitle("Income"),
          categoryList(BudgetType.INCOME),
          categoryTitle("Expense"),
          categoryList(BudgetType.EXPENSE),
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

  Padding categoryList(BudgetType budgetType) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SizedBox(
          height: 200,
          child: GridView.count(
              crossAxisCount: 3,
              children: budgetType == BudgetType.INCOME
                  ? getIncomeCategoryList(budgetType)
                  : getExpenseCategoryList(budgetType)),
        ));
  }

  List<Widget> getIncomeCategoryList(BudgetType budgetType) {
    List<Widget> categoryList = [];
    for (var element in IncomeCategory.values) {
      categoryList.add(Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncomeTransactionsScreen(
                    incomeCategory: element,
                    budgetType: budgetType,
                  ),
                ),
              );
            },
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
        ),
      ));
    }
    return categoryList;
  }

  List<Widget> getExpenseCategoryList(BudgetType budgetType) {
    List<Widget> categoryList = [];
    for (var element in ExpenseCategory.values) {
      categoryList.add(Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExpenseTransactionsScreen(
                    expenseCategory: element, budgetType: budgetType),
              ),
            );
          },
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
      )));
    }
    return categoryList;
  }
}
