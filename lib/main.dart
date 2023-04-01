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
        primarySwatch: Colors.purple,
        splashColor:
            Colors.yellow, // Icon button long-Press effect "Delete Button"
        accentColor: Colors.amber,
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
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.dateTime.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'p2',
      title: 'Dart Book',
      price: 24285.2,
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 'p3',
      title: 'Flutter Book',
      price: 15424.2,
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 'p4',
      title: 'Java Book',
      price: 252.2,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'p5',
      title: 'Java Book',
      price: 25545.2,
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

  void _deleteTranslation(String id) {
    _userTransactions.removeWhere((element) => element.id == id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
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
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                  0.25,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                  0.75,
              child: TransactionList(
                transactions: _userTransactions,
                deleteTranslationOnPressed: _deleteTranslation,
              ),
            )
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
