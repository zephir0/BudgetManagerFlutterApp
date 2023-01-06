import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:budget_manager_flutter/api/json_service.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_adding_menu.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_editing_menu.dart';
import 'package:budget_manager_flutter/screens/home-page/menubar/home_menu_bar.dart';
import 'package:budget_manager_flutter/screens/home-page/slide_widget.dart';
import 'package:flutter/material.dart';
import '../../model/budget.dart';
import '../../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

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
            future: JsonService().getUser(),
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
          future: JsonService().getBalance(),
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
              BudgetAddingMenu().showDialogMenu(context, "income", "INCOME");
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
              BudgetAddingMenu().showDialogMenu(context, "expense", "EXPENSE");
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
                                              setState(() {
                                                ApiService()
                                                    .deleteBudget(budget.id);

                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen()),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              });
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

  String incomeOrExpense(Budget budget) {
    if (budget.income == 0) {
      return "expense";
    } else if (budget.expense == 0) {
      return "income";
    } else
      return "EXCEPTION";
  }

  int budgetListElementsNumber(List<Budget> budgetList) {
    if (budgetList.length >= 5) {
      return 5;
    } else
      return budgetList.length;
  }
}
