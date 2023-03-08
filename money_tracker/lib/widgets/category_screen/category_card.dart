import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/models/ex_category.dart';
import 'package:money_tracker/screens/expense_screen.dart';

//Todo: CategoryCard: Danh Muc
class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ExpenseScreen.name,
          arguments: category.title, //for expensescreen
        );
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(category.icon),
      ),
      title: Text(category.title),
      subtitle: Text('entries: ${category.entries}'),
      trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: 'euro')
          .format(category.totalAmount)),
    );
  }
}
