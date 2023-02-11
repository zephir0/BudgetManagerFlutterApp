// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/statistics-screen/transaction_dispayer.dart';
import 'package:flutter/material.dart';

import 'package:budget_manager_flutter/model/income_category.dart';

import '../../api/budget_json_service.dart';
import '../../model/budget.dart';
import '../../model/budget_type.dart';

class IncomeTransactionsScreen extends StatefulWidget {
  final IncomeCategory incomeCategory;
  final BudgetType budgetType;
  const IncomeTransactionsScreen({
    Key? key,
    required this.incomeCategory,
    required this.budgetType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => IncomeTransactionsScreenState();
}

class IncomeTransactionsScreenState extends State<IncomeTransactionsScreen> {
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
                    ("${widget.incomeCategory.name}")),
                builder: (BuildContext buildContext,
                    AsyncSnapshot<List<Budget>> snapshot) {
                  if (snapshot.hasData) {
                    List<Budget>? budget = snapshot.data;
                    return TransactionDisplayer().displayTransactions(
                        widget.incomeCategory.name,
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
