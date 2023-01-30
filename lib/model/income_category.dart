import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:flutter/material.dart';

enum IncomeCategory {
  SALARY(
    Icons.attach_money,
  ),
  BONUS(
    Icons.card_giftcard,
  ),
  INVESTMENTS(
    Icons.trending_up,
  ),
  OTHERS(
    Icons.more_horiz,
  );

  final IconData icon;

  const IncomeCategory(this.icon);
}
