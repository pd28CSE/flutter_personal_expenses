import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void startAddNewTranslation() {
    showModalBottomSheet(
      context: context,
      builder: (bcntxt) {
        return NewTransaction(
          addNewTransaction: addNewTranslation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: startAddNewTranslation,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: const Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('CHART'),
                ),
              ),
            ),
            TransactionList(transactions: _userTransactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: startAddNewTranslation,
        child: const Icon(Icons.add),
      ),
    );
  }
}
