import '../model/expense_category.dart';
import '../model/income_category.dart';

class BudgetService {
  IncomeCategory stringToIncomeCategory(String category) {
    switch (category) {
      case 'SALARY':
        return IncomeCategory.SALARY;
      case 'INVESTMENTS':
        return IncomeCategory.BONUS;
      case 'RENTAL_INCOME':
        return IncomeCategory.INVESTMENTS;
      default:
        return IncomeCategory.OTHERS;
    }
  }

  ExpenseCategory stringToExpenseCategory(String category) {
    switch (category) {
      case 'FOOD':
        return ExpenseCategory.FOOD;
      case 'TRANSPORT':
        return ExpenseCategory.TRANSPORT;
      case 'HOUSING':
        return ExpenseCategory.HOUSING;
      case 'HEALTHCARE':
        return ExpenseCategory.HEALTHCARE;
      case 'ENTERTAINMENT':
        return ExpenseCategory.ENTERTAINMENT;
      case 'EDUCATION':
        return ExpenseCategory.EDUCATION;
      case 'SHOPPING':
        return ExpenseCategory.SHOPPING;
      case 'INSURANCE':
        return ExpenseCategory.INSURANCE;
      case 'TAXES':
        return ExpenseCategory.TAXES;
      default:
        return ExpenseCategory.OTHERS;
    }
  }
}
