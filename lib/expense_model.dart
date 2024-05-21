class ExpenseModel {
  String item;
  int amount;
  String desc;
  bool isIncome;
  DateTime date;
  ExpenseModel({
    required this.item,
    required this.amount,
    required this.desc,
    required this.isIncome,
    required this.date,
  });
}
