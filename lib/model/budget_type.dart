import 'package:flutter/material.dart';

enum BudgetType {
  INCOME(Icon(Icons.add_box)),
  EXPENSE(Icon(Icons.delete));

  final Icon icon;

  const BudgetType(this.icon);
}
