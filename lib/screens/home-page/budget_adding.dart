import 'package:flutter/material.dart';
import '../global_variables.dart';
import 'budget_adding_menu.dart';

class BudgetAdder {
  Padding incomeOrExpense(BuildContext context) {
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
}
