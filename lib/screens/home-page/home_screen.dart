import 'dart:ffi';

import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/home-page/menubar/home_menu_bar.dart';
import 'package:flutter/material.dart';
import '../../model/budget.dart';
import '../../model/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlobalVariables().backgroundGradient),
      child: ListView(
        children: [
          userWelcomeMessage(context),
          balanceScreen(context),
          incomeOrExpenseAdd(context),
          HomeMenuBar().menuBar(context),
          mostRecent(context),
          mostRecentItems(context)
        ],
      ),
    ));
  }

  Padding userWelcomeMessage(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
        child: FutureBuilder(
            future: ApiService().getUser(),
            builder: (BuildContext buildContext, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                User? user = snapshot.data;
                return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromARGB(255, 53, 125, 184),
                                Color.fromRGBO(59, 59, 90, 1)
                              ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Welcome, ${user?.login}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Padding balanceScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: FutureBuilder(
          future: ApiService().getBalance(),
          builder: (BuildContext buildContext, AsyncSnapshot<Budget> snapshot) {
            if (snapshot.hasData) {
              Budget? budget = snapshot.data;
              return SizedBox(
                child: Container(
                    child: Column(children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Text(
                          "Balance",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          "£" "${budget?.balance}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ]),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromARGB(1, 168, 218, 220),
                              Color.fromARGB(255, 34, 23, 23)
                            ]))),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Padding incomeOrExpenseAdd(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            onPressed: () {
              ApiService().popDialogMenu(context, "income", "INCOME");
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Color.fromARGB(255, 36, 136, 16),
                minimumSize: GlobalVariables().loginButtonSize),
            child: Text(
              "INCOME",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            )),
        ElevatedButton(
            onPressed: () {
              ApiService().popDialogMenu(context, "expense", "EXPENSE");
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Color.fromARGB(255, 128, 33, 26),
                minimumSize: GlobalVariables().loginButtonSize),
            child: Text(
              "EXPENSE",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            )),
      ]),
    );
  }

  Padding mostRecent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 10, 10),
      child: Text(
        "Most recent",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

//TO DO!!! SPLIT TO SMALLER PARTS
//TO DO!!! SPLIT TO SMALLER PARTS
//TO DO!!! SPLIT TO SMALLER PARTS
//TO DO!!! SPLIT TO SMALLER PARTS
//TO DO!!! SPLIT TO SMALLER PARTS
//TO DO!!! SPLIT TO SMALLER PARTS

  Padding mostRecentItems(BuildContext context) {
    List<dynamic> historyDays = [];
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FutureBuilder(
          future: ApiService().getIncomeOrExpense(),
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
                              future: ApiService()
                                  .getBudgetByDate((historyDay.toString())),
                              builder: (BuildContext buildContext,
                                  AsyncSnapshot<List<Budget>> snapshot) {
                                if (snapshot.hasData) {
                                  List<Budget>? historyBudgetList =
                                      snapshot.data;

                                  return Column(children: [
                                    for (var budget
                                        in historyBudgetList!.reversed)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: budget.expense == 0
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  (() {
                                                    if (budget.expense == 0) {
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
                                                    if (budget.expense == 0) {
                                                      return "+${budget?.income}";
                                                    }
                                                    return "-${budget?.expense}";
                                                  })(),
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            )),
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
}
