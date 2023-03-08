import 'package:flutter/material.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/widgets/expense_screen/expense_card.dart';
import 'package:provider/provider.dart';

//Todo: ExpenseList
class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var exList = db.expenses;
        return exList.isNotEmpty
            ? ListView.builder(
                itemCount: exList.length,
                itemBuilder: (_, i) => ExpenseCard(exp: exList[i]),
              )
            : const Center(
                child: Text('No Expenses Added'),
              );
      },
    );
  }
}
