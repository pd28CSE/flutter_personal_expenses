import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  FocusNode myFocusNode = FocusNode();

  void _addNewTransactionValue() {
    String newTitle = titleController.text.trim();
    String newAmount = _amountController.text.trim();
    if (newTitle.isNotEmpty &&
        newAmount.isNotEmpty &&
        double.parse(newAmount) > 0 &&
        _selectedDate != null) {
      widget.addNewTransaction(
        newTitle,
        double.parse(newAmount),
        _selectedDate,
      );
    }
  }

  void _presentDatePicher() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selectedDateTime) {
      if (selectedDateTime != null) {
        setState(() {
          _selectedDate = selectedDateTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              // autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (value) {
                myFocusNode.requestFocus();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              focusNode: myFocusNode,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                ),
                TextButton(
                  onPressed: _presentDatePicher,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: _addNewTransactionValue,
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
