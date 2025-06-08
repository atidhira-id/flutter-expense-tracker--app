import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum ExpenseCategoty { food, travel, work, leisure }

const categoryIcons = {
  ExpenseCategoty.food: Icons.lunch_dining,
  ExpenseCategoty.travel: Icons.flight_takeoff,
  ExpenseCategoty.work: Icons.work,
  ExpenseCategoty.leisure: Icons.movie,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategoty category;

  String get formattedDate {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  IconData get categoryIcon {
    return categoryIcons[category] ?? Icons.help_outline;
  }
}
