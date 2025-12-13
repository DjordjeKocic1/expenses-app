import 'package:expenses_tracker/expenses_list_item.dart';
import 'package:expenses_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        background: Container(color: Colors.red, margin: Theme.of(context).cardTheme.margin,),
        onDismissed: (direction) => onRemoveExpense(expensesList[index]),
        child: ExpensesListItem(expensesList[index]),
      ),
    );
  }
}
