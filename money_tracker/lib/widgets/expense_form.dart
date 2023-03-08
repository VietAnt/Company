import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/constants/icons.dart';
import 'package:money_tracker/models/datase_provider.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:provider/provider.dart';

//Todo: Expense Form: Thêm_Giao_Dịch
class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;
  String _initialValue = 'Other';

  //Todo: _pickDate: Chon Thoi Gian
  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  //Todo: BuilUI
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //!: Title
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title of Expense'),
            ),
            const SizedBox(height: 20),
            //!: Amount
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount of Expense'),
            ),
            const SizedBox(height: 20),
            //!Date picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _date != null
                        ? DateFormat('MMMM dd, yyyy').format(_date!)
                        : 'Select Date',
                  ),
                ),
                IconButton(
                  onPressed: () => _pickDate(),
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //!Category
            Row(
              children: [
                Expanded(child: Text('Category')),
                Expanded(
                  child: DropdownButton(
                    items: icons.keys
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    value: _initialValue,
                    onChanged: (newValue) {
                      setState(() {
                        _initialValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red[400]),
              ),
              onPressed: () {
                if (_title.text != '' && _amount.text != '') {
                  //! tạo một chi phí: add expense
                  final file = Expense(
                    id: 0,
                    title: _title.text,
                    amount: double.parse(_amount.text),
                    date: _date != null ? _date! : DateTime.now(),
                    category: _initialValue,
                  );
                  //! Thêm nó vào cơ sở dữ liệu.
                  provider.addExpense(file);
                  //! // đóng bottomsheet
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
