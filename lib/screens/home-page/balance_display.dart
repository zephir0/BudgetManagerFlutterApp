import 'package:flutter/material.dart';

import '../../api/budget_json_service.dart';
import '../../model/budget.dart';

class BalanceDisplay {
  Padding showBalanceScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: FutureBuilder(
          future: BudgetJsonService().getBalance(),
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
}
