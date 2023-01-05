import 'package:budget_manager_flutter/api/json_service.dart';
import 'package:flutter/material.dart';

class BudgetAddingMenu {
  Future showDialogMenu(
      BuildContext context, String expenseOrIncome, String dialogText) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: buildDialogForm(context, expenseOrIncome, dialogText),
          );
        });
  }

  Form buildDialogForm(
      BuildContext context, String expenseOrIncome, String dialogText) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();

    return Form(
      key: formkey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildDialogHeader(dialogText),
        buildDialogTextField(textEditingController),
        buildDialogButton(
            context, formkey, textEditingController, expenseOrIncome),
      ]),
    );
  }

  Padding buildDialogHeader(String dialogText) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "...",
          hintStyle: TextStyle(fontSize: 15, color: Colors.white)),
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
      String expenseOrIncome) {
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
          JsonService().updateBudget(textEditingController, expenseOrIncome);
          Navigator.pop(context);
        }
      }),
      child: Text("Save"),
    );
  }
}
