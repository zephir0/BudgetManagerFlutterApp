import 'package:budget_manager_flutter/api/budget_json_service.dart';
import 'package:budget_manager_flutter/model/budget.dart';
import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:budget_manager_flutter/model/expense_category.dart';
import 'package:budget_manager_flutter/model/income_category.dart';
import 'package:budget_manager_flutter/screens/home-screen/home_screen.dart';
import 'package:flutter/material.dart';

class BudgetDialog {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController selectedCategory = TextEditingController();

  Future showDialogMenu(
      BuildContext context, Budget budget, BudgetType budgetType) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: buildDialogForm(context, budget, budgetType),
          );
        });
  }

  Future showEditDialogMenu(
      BuildContext context, Budget budget, BudgetType budgetType) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: buildDialogForm(context, budget, budgetType),
          );
        });
  }

  Form buildDialogForm(
      BuildContext context, Budget budget, BudgetType budgetType) {
    return Form(
      key: formkey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildDialogHeader(budget),
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
              value: budgetType == BudgetType.INCOME
                  ? budget.incomeCategory?.name ?? "OTHERS"
                  : budget.expenseCategory?.name ?? "OTHERS",
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Category',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 28)),
            ),
          );
        }),
        Divider(),
        buildDialogTextField(budget),
        buildDialogButton(context, budget, budgetType),
      ]),
    );
  }

  Padding buildDialogHeader(Budget budget) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Text(
        budget.id == null ? "ADD" : "EDIT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  TextFormField buildDialogTextField(Budget budget) {
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

  ElevatedButton buildDialogButton(
      BuildContext context, Budget budget, BudgetType budgetType) {
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
          if (budget.id == null) {
            BudgetJsonService()
                .addBudget(textEditingController, selectedCategory, budgetType);
          } else {
            BudgetJsonService().editBudget(textEditingController, budget);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (buildContext) => HomeScreen()));
        }
      }),
      child: Text("Save"),
    );
  }
}
