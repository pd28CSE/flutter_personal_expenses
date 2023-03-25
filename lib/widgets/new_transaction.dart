import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  void addNewTransactionValue() {
    String newTitle = titleController.text.trim();
    String newAmount = amountController.text.trim();
    if (newTitle.isNotEmpty &&
        newAmount.isNotEmpty &&
        double.parse(newAmount) > 0) {
      widget.addNewTransaction(
        newTitle,
        double.parse(newAmount),
        DateTime.now(),
      );
    }
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
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextButton(
              onPressed: addNewTransactionValue,
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
