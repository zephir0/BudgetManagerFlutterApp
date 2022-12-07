class Budget {
  late int? balance;
  late int? income;
  late int? expense;
  Budget({this.balance, this.income, this.expense});

  factory Budget.fromJsonBalance(int balance) {
    return Budget(balance: balance);
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(income: json['income'], expense: json['expense']);
  }

  Map<String, dynamic> incomeToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income'] = this.income;
    return data;
  }
}
