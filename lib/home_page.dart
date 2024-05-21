import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import 'expense_model.dart';
import 'fund_condition_widget.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> options = ["expense", "income"];
List<ExpenseModel> expenses = [];

class _HomePageState extends State<HomePage> {
  final itemController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();

  int amount = 0;
  final dateController = TextEditingController();
  int totalMoney = 0;
  int spentMoney = 0;
  int income = 0;
  DateTime? pickedDate;
  String currentOption = options[0];

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    List<ExpenseModel> filteredExpenses = expenses.where((expense) {
      if (_startDate == null || _endDate == null) {
        return true;
      } else {
        return expense.date.isAfter(_startDate!.subtract(Duration(days: 1))) &&
            expense.date.isBefore(_endDate!.add(Duration(days: 1)));
      }
    }).toList();
    try {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: 35,
          child: FloatingActionButton.large(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Padding(
                      padding: EdgeInsets.only(left: 1.6),
                      child: Text("ADD TRANSACTION"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          amount = int.parse(amountController.text);
                          // adding a new item
                          final expense = ExpenseModel(
                            item: itemController.text,
                            desc: descController.text,
                            amount: amount,
                            isIncome: currentOption == "income",
                            date: pickedDate!,
                          );
                          expenses.add(expense);
                          if (expense.isIncome) {
                            income += expense.amount;
                            totalMoney += expense.amount;
                          } else {
                            spentMoney += expense.amount;
                            totalMoney -= expense.amount;
                          }
                          setState(() {});

                          itemController.clear();
                          descController.clear();
                          amountController.clear();
                          dateController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: const InputDecoration(
                              hintText: "Enter the Item",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: descController,
                            decoration: const InputDecoration(
                              hintText: "Enter Description",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Enter the Amount",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              onTap: () async {
                                // user can pick date
                                pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                String date = DateFormat.yMMMMd().format(pickedDate!);
                                dateController.text = date;
                                setState(() {});
                              },
                              controller: dateController,
                              decoration: const InputDecoration(
                                labelText: "DATE",
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                prefixIconColor: Colors.blue,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListTile(
                            title: const Text("Expense"),
                            leading: Radio(
                              value: options[0],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("Income"),
                            leading: Radio(
                              value: options[1],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add, size: 26),
          ),
        ),
        appBar: AppBar(
          title: const Text("Expense Tracker", style: TextStyle(fontSize: 32, fontFamily: 'Bebas Neue', color: Colors.black)),
          backgroundColor: Colors.greenAccent,
          leading: const Icon(Icons.monetization_on_outlined,color: Colors.black,size: 40,),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ACCOUNT BALANCE : \₹${totalMoney.toString()}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FundConditionExp(
                        type: "EXPENSE",
                        amount: "$spentMoney",
                        icon: "exp",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FundCondition(
                        type: "INCOME",
                        amount: "$income",
                        icon: "income",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: PieChart(
                    PieChartData(
                      sections: showingSections(),
                      centerSpaceRadius: 50,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.blueGrey,
                    ),
                  ],
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                  const Positioned(
                  left: 40,
                  top: 10,
                  child: Text(
                    "Filter Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      initialDateRange: _startDate != null && _endDate != null
                          ? DateTimeRange(start: _startDate!, end: _endDate!)
                          : null,
                    );
                    if (picked != null && (picked.start != _startDate || picked.end != _endDate)) {
                      setState(() {
                        _startDate = picked.start;
                        _endDate = picked.end;
                      });
                    }
                  },
                ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Confirm to Delete the Item?",
                                style: TextStyle(
                                  fontSize: 19.0,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "CANCEL",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final myExpense = expenses[index];
                                    if (myExpense.isIncome) {
                                      income -= myExpense.amount;
                                      totalMoney -= myExpense.amount;
                                    } else {
                                      spentMoney -= myExpense.amount;
                                      totalMoney += myExpense.amount;
                                    }
                                    setState(() {});
                                    expenses.remove(myExpense);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "DELETE",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Item(
                        expense: ExpenseModel(
                          item: expenses[index].item,
                          desc: expenses[index].desc,
                          amount: expenses[index].amount,
                          isIncome: expenses[index].isIncome,
                          date: expenses[index].date,
                        ),
                        onDelete: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Error in build method: $e");
      return Scaffold(
        body: Center(child: Text("An error occurred: $e")),
      );
    }
  }

  List<PieChartSectionData> showingSections() {
    int total = spentMoney + income;
    double expensesPercentage = (spentMoney / total) * 100;
    double incomePercentage = (income / total) * 100;
    return [
      PieChartSectionData(
        color: Colors.red,
        value: spentMoney.toDouble(),
        title: '${expensesPercentage.toStringAsFixed(2)}% \nExpenses ',
        radius: 60,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: income.toDouble(),
        title: '${incomePercentage.toStringAsFixed(2)}% \n Income',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}
