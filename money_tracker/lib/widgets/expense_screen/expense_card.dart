import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/constants/icons.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/widgets/expense_screen/confirm_box.dart';

//Todo: ExpenseCard:
class ExpenseCard extends StatelessWidget {
  final Expense exp;
  const ExpenseCard({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(exp.id),
      confirmDismiss: (_) async {
        showDialog(
          context: context,
          builder: (_) => ConfirmBox(exp: exp),
        );
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icons[exp.category]),
        ),
        title: Text(exp.title),
        subtitle: Text(DateFormat('MMMM dd, yyyy').format(exp.date)),
        trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: 'd')
            .format(exp.amount)),
      ),
    );
  }
}
