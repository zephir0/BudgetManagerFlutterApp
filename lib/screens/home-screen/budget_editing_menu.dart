import 'package:budget_manager_flutter/api/budget_json_service.dart';
import 'package:flutter/material.dart';
import '../../model/budget.dart';

class BudgetEditingMenu {
  Future showEditDialog(BuildContext context, Budget budget) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 31, 30, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: buildEditForm(context, budget),
          );
        });
  }

  Form buildEditForm(BuildContext context, Budget budget) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();
    return Form(
      key: formkey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildEditHeader(),
        buildEditTextField(textEditingController),
        buildEditButton(context, formkey, textEditingController, budget),
      ]),
    );
  }

  Padding buildEditHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "EDIT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  TextFormField buildEditTextField(
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

  ElevatedButton buildEditButton(
      BuildContext context,
      GlobalKey<FormState> formkey,
      TextEditingController textEditingController,
      Budget budget) {
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
          BudgetJsonService().editBudget(textEditingController, budget);
          Navigator.pop(context);
        }
      }),
      child: Text("Save"),
    );
  }
}
