import 'package:flutter/material.dart';

import '../../model/budget.dart';
import '../../model/budget_type.dart';
import 'budget_dialog.dart';
import '../global_variables.dart';

class BudgetCreationWidget {
  Padding createBudget(BuildContext context) {
    Budget budget = new Budget();
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            onPressed: () {
              BudgetDialog().showDialogMenu(
                context,
                budget,
                BudgetType.INCOME,
              );
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
              BudgetDialog()
                  .showDialogMenu(context, budget, BudgetType.EXPENSE);
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
}
