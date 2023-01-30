import 'package:flutter/material.dart';

enum ExpenseCategory {
  FOOD(Icons.fastfood),
  TRANSPORT(Icons.directions_car),
  HOUSING(Icons.home),
  HEALTHCARE(Icons.local_hospital),
  ENTERTAINMENT(Icons.local_movies),
  EDUCATION(Icons.school),
  SHOPPING(Icons.shopping_cart),
  INSURANCE(Icons.security),
  TAXES(Icons.attach_money),
  OTHERS(Icons.more_horiz);

  final IconData icon;
  const ExpenseCategory(this.icon);
}
