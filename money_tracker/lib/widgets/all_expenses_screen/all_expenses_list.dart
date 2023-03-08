import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/widgets/expense_screen/expense_card.dart';
import 'package:provider/provider.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.expenses;
        return list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: list.length,
                itemBuilder: (_, i) => ExpenseCard(exp: list[i]),
              )
            : const Center(
                child: Text('No Entries Found'),
              );
      },
    );
  }
}
