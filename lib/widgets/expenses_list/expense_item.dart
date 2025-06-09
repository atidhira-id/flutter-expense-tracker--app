import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 203, 203, 203),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.title),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(expense.categoryIcon),
                    SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
            Text('\$${expense.amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
