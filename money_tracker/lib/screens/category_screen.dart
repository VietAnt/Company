import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/category_screen/category_fetcher.dart';
import 'package:money_tracker/widgets/expense_form.dart';

//Todo: CategoryScreen
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen'; // for routes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.red[400],
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
      ),
    );
  }
}
