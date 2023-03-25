import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  NewTransaction({super.key, required this.addNewTransaction});
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

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
            TextField(
              focusNode: myFocusNode,
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextButton(
              onPressed: () {
                String newTitle = titleController.text.trim();
                String newAmount = amountController.text.trim();
                if (newTitle.isNotEmpty && newAmount.isNotEmpty) {
                  addNewTransaction(
                    newTitle,
                    double.parse(newAmount),
                    DateTime.now(),
                  );
                }
              },
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
