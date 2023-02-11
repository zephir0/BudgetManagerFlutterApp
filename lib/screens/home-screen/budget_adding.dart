// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_manager_flutter/model/income_category.dart';
import 'package:budget_manager_flutter/screens/home-screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:budget_manager_flutter/model/budget_type.dart';

import '../../api/budget_json_service.dart';
import '../../model/expense_category.dart';
import '../global_variables.dart';

class BudgetAdder {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController selectedCategory = TextEditingController();
  final Function(String, TextEditingController) categoryName;
  BudgetAdder({Key? key, required this.categoryName});

  Padding incomeOrExpense(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            onPressed: () {
              showDialogMenu(context, BudgetType.INCOME, "INCOME");
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
              showDialogMenu(context, BudgetType.EXPENSE, "EXPENSE");
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

  Future showDialogMenu(
      BuildContext context, BudgetType budgetType, String dialogText) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: buildDialogForm(context, budgetType, dialogText),
          );
        });
  }

// do zmiany pobieranie wartosci enumow ze wzgledu na typ budgetu
  Form buildDialogForm(
      BuildContext context, BudgetType budgetType, String dialogText) {
    return Form(
      key: formkey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildDialogHeader(dialogText),
        Divider(),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: DropdownButtonFormField(
              alignment: Alignment.center,
              items: dropDownMenuList(budgetType),
              onChanged: (value) {
                setState(() {
                  selectedCategory.text = value!;
                });
              },
              value: "OTHERS",
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Category',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 28)),
            ),
          );
        }),
        Divider(),
        buildDialogTextField(textEditingController),
        buildDialogButton(context, formkey, textEditingController,
            selectedCategory, budgetType),
      ]),
    );
  }

  List<DropdownMenuItem<String>> dropDownMenuList(BudgetType budgetType) {
    List<DropdownMenuItem<String>> dropDownMenuList = [];
    for (var category in budgetType == BudgetType.INCOME
        ? IncomeCategory.values
        : ExpenseCategory.values) {
      dropDownMenuList.add(DropdownMenuItem(
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              color:
                  budgetType == BudgetType.INCOME ? Colors.green : Colors.red),
        ),
        value: category.name,
      ));
    }
    return dropDownMenuList;
  }

  Padding buildDialogHeader(String dialogText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Text(
        dialogText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  TextFormField buildDialogTextField(
      TextEditingController textEditingController) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 50),
      decoration: InputDecoration(
          hintText: "...",
          hintStyle: TextStyle(fontSize: 20, color: Colors.white)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field cannot be empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      controller: textEditingController,
    );
  }

  ElevatedButton buildDialogButton(
      BuildContext context,
      GlobalKey<FormState> formkey,
      TextEditingController textEditingController,
      TextEditingController selectedCategory,
      BudgetType budgetType) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 53, 219, 197),
        minimumSize: Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
      ),
      onPressed: (() async {
        if (formkey.currentState!.validate()) {
          BudgetJsonService()
              .addBudget(textEditingController, selectedCategory, budgetType);

          Navigator.push(context,
              MaterialPageRoute(builder: (buildContext) => HomeScreen()));
        }
      }),
      child: Text("Save"),
    );
  }
}
