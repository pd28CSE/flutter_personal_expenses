import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

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
        // fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              displayMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
              width: 1.5,
            ),
          ),
        ),
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
    Navigator.of(context).pop();
    setState(() {
      _userTransactions.insert(0, newTransaction);
    });
  }

  void startAddNewTranslation() {
    showModalBottomSheet(
      context: context,
      builder: (bcntxt) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            addNewTransaction: addNewTranslation,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
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
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Chart(recentTransactions: _userTransactions),
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



//97 number