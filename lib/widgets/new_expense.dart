import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewExpense, {super.key});

  final Function(Expense) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  ExpenseCategoty _selectedCategory = ExpenseCategoty.leisure;

  void _showDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate ?? now;
    });
  }

  String? _titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expense cannot be empty';
    }
    return null;
  }

  String? _amountValidator(String? value) {
    if (value != null) {
      final amount = double.tryParse(value);
      if (amount == null || amount <= 0) {
        return 'Please enter a valid amount';
      }
    } else {
      return 'Expense amount cannot be empty';
    }
    return null;
  }

  void _submitExpanseData() {
    if (_formKey.currentState!.validate()) {
      Expense newExpense = Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
        category: _selectedCategory,
      );

      widget.addNewExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    Widget titleTextField() {
      return TextFormField(
        controller: _titleController,
        maxLength: 50,
        decoration: InputDecoration(labelText: 'Expense Title'),
        validator: (value) => _titleValidator(value),
      );
    }

    Widget amountTextField() {
      return TextFormField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(prefixText: '\$', labelText: 'Amount'),
        validator: (value) => _amountValidator(value),
      );
    }

    Widget datePicker() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _selectedDate == null
                ? 'No date selected'
                : DateFormat('dd MMMM yyyy').format(_selectedDate!),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          IconButton(
            onPressed: _showDatePicker,
            icon: Icon(Icons.calendar_month),
          ),
        ],
      );
    }

    Widget categoriesDropdown() {
      return DropdownButton(
        value: _selectedCategory,
        items:
            ExpenseCategoty.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            if (value == null) return;
            _selectedCategory = value;
          });
        },
      );
    }

    Widget buttons() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _submitExpanseData,
            child: const Text('Save'),
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (ctx, constrain) {
        final width = constrain.maxWidth;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, keyboardSpace + 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Expense",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (width >= 600)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: titleTextField()),
                            SizedBox(width: 16),
                            Expanded(child: amountTextField()),
                          ],
                        )
                      else
                        titleTextField(),
                      if (width >= 600)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [categoriesDropdown(), datePicker()],
                        )
                      else
                        Row(
                          children: [
                            Expanded(child: amountTextField()),
                            SizedBox(width: 12),
                            datePicker(),
                          ],
                        ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            width >= 600
                                ? [Spacer(), buttons()]
                                : [categoriesDropdown(), buttons()],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
