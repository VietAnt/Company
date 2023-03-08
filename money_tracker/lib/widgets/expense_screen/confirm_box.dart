import 'package:flutter/material.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:provider/provider.dart';

//Todo: ConfirmBox:
class ConfirmBox extends StatelessWidget {
  final Expense exp;
  const ConfirmBox({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      title: Text('Delete ${exp.title} ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); //Don not delete
            },
            child: const Text('Don\'t delete'),
          ),
          const SizedBox(width: 5.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              provider.deleteExpense(exp.id, exp.category, exp.amount);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
