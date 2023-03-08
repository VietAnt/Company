import 'package:flutter/material.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/widgets/expense_screen/expense_chart.dart';
import 'package:money_tracker/widgets/expense_screen/expense_list.dart';
import 'package:provider/provider.dart';

//Todo: ExpenseFetch: Trình tải chi phí
class ExpenseFetcher extends StatefulWidget {
  final String category;
  const ExpenseFetcher({super.key, required this.category});

  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {
  late Future _expenseList;
  //Get_Expense
  Future _getExpenseList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(widget.category);
  }

  //initState
  @override
  void initState() {
    super.initState();
    _expenseList = _getExpenseList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _expenseList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 250, child: ExpenseChart(widget.category)),
                  const Expanded(child: ExpenseList()),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
