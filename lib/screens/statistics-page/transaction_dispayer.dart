import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:flutter/material.dart';

import '../../model/budget.dart';

class TransactionDisplayer {
  ListView displayTransactions(String title, List<Budget> budget,
      BuildContext context, BudgetType budgetType) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
                  child: Text(
                    "Most recent",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (var element in budget.reversed)
          GestureDetector(
            onTap: () {
              TransactionDisplayer()
                  .showDetailsDialog(context, element, budgetType);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 38, 48, 38),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            budgetType.name == "INCOME"
                                ? "INCOME : "
                                : "EXPENSE: ",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: budgetType.name == "INCOME"
                                    ? Colors.green
                                    : Color.fromARGB(255, 170, 28, 47)),
                          ),
                          Text(
                            budgetType.name == "INCOME"
                                ? "+" " ${element.value}"
                                : " ${element.value}",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: budgetType.name == "INCOME"
                                    ? Colors.green
                                    : Color.fromARGB(255, 170, 28, 47)),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          )
      ],
    );
  }

  Future showDetailsDialog(
      BuildContext context, Budget budget, BudgetType budgetType) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                budgetType.name == "EXPENSE"
                    ? "Expense value : -${budget.value}"
                    : "Income value : +${budget.value}",
                style: textStyleForShowDetailsDialog(),
              ),
              Text(
                "Category : ${budget.expenseCategory.toString().split('.').last}",
                style: textStyleForShowDetailsDialog(),
              ),
              Text(
                "Budget added day : ${budget.historyDayNumber}",
                style: textStyleForShowDetailsDialog(),
              ),
            ]),
          );
        });
  }

  TextStyle textStyleForShowDetailsDialog() {
    return TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
