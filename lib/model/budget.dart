import '../utils/budget_category_classifier.dart';
import 'budget_type.dart';
import 'expense_category.dart';
import 'income_category.dart';

class Budget {
  late int? id;
  late int? balance;
  late int? value;
  late BudgetType? budgetType;
  late IncomeCategory? incomeCategory;
  late ExpenseCategory? expenseCategory;
  late String? historyDayNumber;

  Budget({
    this.id,
    this.balance,
    this.value,
    this.budgetType,
    this.incomeCategory,
    this.expenseCategory,
    this.historyDayNumber,
  });

  factory Budget.fromJsonBalance(int balance) {
    return Budget(
      balance: balance,
    );
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
        id: json['id'],
        value: json['value'],
        budgetType: json['budgetType'] == 'INCOME'
            ? BudgetType.INCOME
            : BudgetType.EXPENSE,
        incomeCategory: json['incomeCategory'] != null
            ? BudgetCategoryUtils()
                .stringToIncomeCategory(json['incomeCategory'])
            : null,
        expenseCategory: json['expenseCategory'] != null
            ? BudgetCategoryUtils()
                .stringToExpenseCategory(json['expenseCategory'])
            : null,
        historyDayNumber: json['historyDayNumber']);
  }
}
