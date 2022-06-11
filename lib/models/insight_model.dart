enum FilterMonth {
  jan,
  feb,
  mar,
  apr,
  may,
  jun,
  jul,
  aug,
  sept,
  oct,
  nov,
  dec,
}

class IncomeStatement {
  double saleAndService = 0.0;
  ExpenseStatement expenseStatement;
  IncomeStatement(
      {required this.saleAndService, required this.expenseStatement});
}

// month can be less than origin and greather than today
class ExpenseStatementItem {
  String expenseDescription;
  double amount;
  ExpenseStatementItem(
      {required this.amount, required this.expenseDescription});
}

class ExpenseStatement {
  List<ExpenseStatementItem> items;
  ExpenseStatement({required this.items});
}
