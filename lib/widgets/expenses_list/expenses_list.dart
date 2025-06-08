import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expensesList});

  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView.builder(
        itemCount: expensesList.length,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ExpenseItem(expensesList[index]),
            ),
      ),
    );
  }
}
