import 'package:expenses_tracker/expenses_list.dart';
import 'package:expenses_tracker/modal/expense.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Cinema',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Mc Donals',
      amount: 30.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _addExpenseData(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenseData),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: const Text("Expense Deleted"),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _expenses.insert(expenseIndex, expense);
              });
            },
          ),
        ),
      );
  }

  Widget _buildMainContent() {
    if(_expenses.isEmpty){
      return const Center(child: Text('No expenses found.'));
    }
    return ExpensesList(
      expensesList: _expenses,
      onRemoveExpense: _removeExpense,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          Text('The Chart'),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }
}
