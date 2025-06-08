import 'package:expense_tracker/models/expense.dart';
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

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense((newExpense) => addNewExpense(newExpense)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App'),
        actions: [
          IconButton(onPressed: _openAddExpenseModal, icon: Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('chart'),
            Expanded(child: ExpensesList(expensesList: _registeredExpenses)),
          ],
        ),
      ),
    );
  }
}
