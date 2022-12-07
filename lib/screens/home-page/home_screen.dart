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
              print("income");
              ApiService().popDialogMenu(context, "income");
              // ApiService().addIncome();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Color.fromARGB(255, 36, 136, 16),
                minimumSize: GlobalVariables().loginButtonSize),
            // ignore: prefer_const_constructors
            child: Text(
              "INCOME",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            )),
        ElevatedButton(
            onPressed: () {
              ApiService().popDialogMenu(context, "expense");
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Color.fromARGB(255, 128, 33, 26),
                minimumSize: GlobalVariables().loginButtonSize),
            // ignore: prefer_const_constructors
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

  /// IF INCOME = 0 THEN SHOW EXPENSE , IF EXPENSE = 0 THEN SHOW INCOME.

  Padding mostRecentItems(BuildContext context) {
    return Padding(
      //IF BUDGET IS NEGATIVE OR IS AN EXPANSE, THEN COLOR RED, IF NOT THEN BLUE
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FutureBuilder(
          future: ApiService().getIncomeOrExpense(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<Budget>> snapshot) {
            if (snapshot.hasData) {
              List<Budget>? budget = snapshot.data;

              return Column(children: [
                for (var i in budget!.reversed)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: i.expense == 0 ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              (() {
                                if (i.expense == 0) {
                                  return "Income";
                                }
                                return "Expense";
                              })(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              (() {
                                if (i.expense == 0) {
                                  return "+${i?.income}";
                                }
                                return "-${i?.expense}";
                              })(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  )
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
