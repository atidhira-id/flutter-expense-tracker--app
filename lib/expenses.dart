import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/barchart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategoty.work,
    ),
    Expense(
      title: 'Trip to Jakarta',
      amount: 29.00,
      date: DateTime.now(),
      category: ExpenseCategoty.travel,
    ),
    Expense(
      title: 'Cinema',
      amount: 9.99,
      date: DateTime.now(),
      category: ExpenseCategoty.leisure,
    ),
  ];

  void addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense((newExpense) => addNewExpense(newExpense)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense'),
        actions: [
          IconButton(onPressed: _openAddExpenseModal, icon: Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child:
            _registeredExpenses.isEmpty
                ? Center(
                  child: Text(
                    "No Expense",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
                : width < 600
                ? Column(
                  children: [
                    Barchart(data: _registeredExpenses),
                    Expanded(
                      child: ExpensesList(
                        expensesList: _registeredExpenses,
                        onRemoveExpense: (expense) => removeExpense(expense),
                      ),
                    ),
                  ],
                )
                : Row(
                  children: [
                    Expanded(child: Barchart(data: _registeredExpenses)),
                    Expanded(
                      child: ExpensesList(
                        expensesList: _registeredExpenses,
                        onRemoveExpense: (expense) => removeExpense(expense),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
