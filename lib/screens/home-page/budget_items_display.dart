import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:budget_manager_flutter/screens/home-page/slide_widget.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../api/budget_json_service.dart';
import '../../model/budget.dart';
import 'budget_editing_menu.dart';
import 'home_screen.dart';

class BudgetItemsDisplayer {
  Padding mostRecentItems(BuildContext context) {
    List<dynamic> historyDays = [];
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FutureBuilder(
          future: BudgetJsonService().getAllBudget(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<Budget>> snapshot) {
            if (snapshot.hasData) {
              List<Budget>? budgets = snapshot.data;

              for (var budgets in budgets!) {
                if (historyDays.contains(budgets.historyDayNumber)) {
                } else {
                  historyDays.add(budgets.historyDayNumber);
                }
              }

              return Column(
                children: [
                  for (var historyDay in historyDays.reversed)
                    Column(
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              future: BudgetJsonService()
                                  .getBudgetHistoryByDate(
                                      (historyDay.toString())),
                              builder: (BuildContext buildContext,
                                  AsyncSnapshot<List<Budget>> snapshot) {
                                if (snapshot.hasData) {
                                  List<Budget>? historyBudgetList =
                                      snapshot.data;
                                  return Column(children: [
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
                                          onTap: (() {
                                            BudgetEditingMenu().showEditDialog(
                                                context, budget);
                                          }),
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
                                                decoration: BoxDecoration(
                                                    color: budget.budgetType ==
                                                            BudgetType.INCOME
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
                                                      (() {
                                                        if (budget.budgetType ==
                                                            BudgetType.INCOME) {
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
                                                      (() {
                                                        if (budget.budgetType ==
                                                            BudgetType.INCOME) {
                                                          return "+${budget.value}";
                                                        }
                                                        return "-${budget.value}";
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
}
