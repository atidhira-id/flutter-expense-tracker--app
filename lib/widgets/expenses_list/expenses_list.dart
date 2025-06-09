import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  final List<Expense> expensesList;
  final Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView.builder(
        itemCount: expensesList.length,
        itemBuilder:
            (context, index) => Column(
              children: [
                Dismissible(
                  key: Key(expensesList[index].id),
                  onDismissed: (direction) {
                    onRemoveExpense(expensesList[index]);
                  },
                  background: Card(
                    color: Theme.of(context).colorScheme.error.withAlpha(150),
                    shape: Theme.of(context).cardTheme.shape,
                  ),
                  child: ExpenseItem(expensesList[index]),
                ),
                SizedBox(height: 10),
              ],
            ),
      ),
    );
  }
}
