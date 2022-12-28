class Budget {
  late int? id;
  late int? balance;
  late int? income;
  late int? expense;
  late String? historyDayNumber;
  Budget(
      {this.id,
      this.balance,
      this.income,
      this.expense,
      this.historyDayNumber});

  factory Budget.fromJsonBalance(int balance) {
    return Budget(balance: balance);
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
        id: json['id'],
        income: json['income'],
        expense: json['expense'],
        historyDayNumber: json['historyDayNumber']);
  }

  Map<String, dynamic> incomeToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income'] = this.income;
    return data;
  }
}
