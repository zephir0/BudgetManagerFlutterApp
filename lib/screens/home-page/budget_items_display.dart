import 'package:budget_manager_flutter/screens/home-page/slide_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../api/json_service.dart';
import '../../model/budget.dart';
import 'budget_editing_menu.dart';
import 'home_screen.dart';

class BudgetItemsDisplayer {
  Padding mostRecentItems(BuildContext context) {
    List<dynamic> historyDays = [];
    // Return a Padding widget that contains a FutureBuilder widget
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FutureBuilder(
          // The FutureBuilder's future is set to the result of calling the
          // getIncomeOrExpense method of a JsonService object. This method
          // returns a Future that will resolve to a list of Budget objects.
          future: JsonService().getIncomeOrExpense(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<Budget>> snapshot) {
            if (snapshot.hasData) {
              List<Budget>? budgets = snapshot.data;
              // Iterate over the budgets list and add each unique value of the
              // historyDayNumber field to the historyDays list
              for (var budgets in budgets!) {
                if (historyDays.contains(budgets.historyDayNumber)) {
                  // The history day number is already in the list, so do nothing
                } else {
                  historyDays.add(budgets.historyDayNumber);
                }
              }
              // Return a Column widget that contains a list of nested Column widgets.
              // Each nested Column widget represents a single "history day".
              return Column(
                children: [
                  // Iterate over the historyDays list in reverse order
                  for (var historyDay in historyDays.reversed)
                    // Return a Column widget for each history day
                    Column(
                      children: [
                        // Return a Padding widget with a Container child widget that
                        // displays the history day number
                        Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 189, 55, 155)),
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                  child: Text(
                                historyDay.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                            )),
                        // Return a Padding widget that contains a FutureBuilder widget
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              // The FutureBuilder's future is set to the result of calling the
                              // getBudgetHistoryByDate method of a JsonService object, passing in
                              // the history day number as an argument. This method returns a Future
                              // that will resolve to a list of Budget objects for the given history day.
                              future: JsonService().getBudgetHistoryByDate(
                                  (historyDay.toString())),
                              builder: (BuildContext buildContext,
                                  AsyncSnapshot<List<Budget>> snapshot) {
                                if (snapshot.hasData) {
                                  List<Budget>? historyBudgetList =
                                      snapshot.data;
                                  // Return a Column widget that contains a list of Padding widgets,
                                  // each of which contains an InkWell widget
                                  return Column(children: [
                                    // Iterate over the historyBudgetList in reverse order and return a Padding
                                    // widget for each Budget object
                                    for (var budget in historyBudgetList!
                                        .reversed
                                        .toList()
                                        .sublist(
                                            0,
                                            budgetListElementsNumber(
                                                historyBudgetList)))
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          // Set the onTap callback of the InkWell widget to a function
                                          // that displays an edit dialog for the current Budget object
                                          onTap: (() {
                                            BudgetEditingMenu().showEditDialog(
                                                context,
                                                incomeOrExpense(budget),
                                                budget);
                                          }),
                                          // Create a SlideBudget widget with a callback function that is called when the widget is swiped.
                                          // The callback function deletes the budget item from the database and navigates to the HomeScreen.
                                          child: SlideBudget(
                                            callback: () {
                                              ApiService()
                                                  .deleteBudget(budget.id);

                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                            child: AnimatedContainer(
                                                // Use a green color for income and a red color for expense.
                                                decoration: BoxDecoration(
                                                    color: budget.expense == 0
                                                        ? Colors.green
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                duration:
                                                    const Duration(seconds: 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      // Display "Income" for income and "Expense" for expense.
                                                      (() {
                                                        if (budget.expense ==
                                                            0) {
                                                          return "Income";
                                                        }
                                                        return "Expense";
                                                      })(),
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      // Display the budget amount with a "+" sign for income and a "-" sign for expense.
                                                      (() {
                                                        if (budget.expense ==
                                                            0) {
                                                          return "+${budget.income}";
                                                        }
                                                        return "-${budget.expense}";
                                                      })(),
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                      )
                                  ]);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  int budgetListElementsNumber(List<Budget> budgetList) {
    if (budgetList.length >= 5) {
      return 5;
    } else
      return budgetList.length;
  }

  String incomeOrExpense(Budget budget) {
    if (budget.income == 0) {
      return "expense";
    } else if (budget.expense == 0) {
      return "income";
    } else
      return "EXCEPTION";
  }
}
