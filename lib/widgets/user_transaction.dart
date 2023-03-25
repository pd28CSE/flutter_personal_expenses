import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'p1',
      title: 'Python Book',
      price: 25.2,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'p2',
      title: 'Dart Book',
      price: 25.2,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'p3',
      title: 'Flutter Book',
      price: 2552424.2,
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 'p4',
      title: 'Java Book',
      price: 25.2,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'p5',
      title: 'Java Book',
      price: 25.2,
      dateTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  void addNewTranslation(
    String newTitle,
    double newPrice,
    DateTime newDateTime,
  ) {
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: newTitle,
      price: newPrice,
      dateTime: newDateTime,
    );

    setState(() {
      _userTransactions.insert(0, newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(addNewTransaction: addNewTranslation),
        TransactionList(transactions: _userTransactions),
      ],
    );
  }
}
