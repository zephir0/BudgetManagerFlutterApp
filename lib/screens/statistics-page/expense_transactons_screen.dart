// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_manager_flutter/model/expense_category.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/statistics-page/transaction_dispayer.dart';
import 'package:flutter/material.dart';

import 'package:budget_manager_flutter/model/income_category.dart';

import '../../api/budget_json_service.dart';
import '../../model/budget.dart';
import '../../model/budget_type.dart';

class ExpenseTransactionsScreen extends StatefulWidget {
  final ExpenseCategory expenseCategory;
  final BudgetType budgetType;
  const ExpenseTransactionsScreen({
    Key? key,
    required this.expenseCategory,
    required this.budgetType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ExpenseTransactionsScreenState();
}

class ExpenseTransactionsScreenState extends State<ExpenseTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: Container(
          child: Center(
            child: FutureBuilder(
                future: BudgetJsonService().getBudgetByCategoryName(
                    ("${widget.budgetType.name}"),
                    ("${widget.expenseCategory.name}")),
                builder: (BuildContext buildContext,
                    AsyncSnapshot<List<Budget>> snapshot) {
                  if (snapshot.hasData) {
                    List<Budget>? budget = snapshot.data;
                    return TransactionDisplayer().displayTransactions(
                        widget.expenseCategory.name,
                        budget!,
                        context,
                        widget.budgetType);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
