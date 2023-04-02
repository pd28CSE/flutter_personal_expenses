import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
  bool _isChartVisible = true;
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
            // Navigator.of(context).pop();
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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final AppBar appBar = AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: startAddNewTranslation,
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final transactionList = SizedBox(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.75,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTranslationOnPressed: _deleteTranslation,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_isChartVisible == true ? 'Hide Chart' : 'Show Chart'),
                  Transform.scale(
                    scale: 1.2,
                    child: Switch.adaptive(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveTrackColor: Colors.amber,
                        value: _isChartVisible,
                        onChanged: (value) {
                          setState(() {
                            _isChartVisible = value;
                          });
                        }),
                  ),
                ],
              ),
            if (isLandscape == false)
              SizedBox(
                height: (mediaQuery.size.height -
                        mediaQuery.padding.top -
                        appBar.preferredSize.height) *
                    0.25,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (isLandscape == false) transactionList,
            if (isLandscape == true)
              _isChartVisible == true
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              appBar.preferredSize.height) *
                          0.6,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : transactionList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS == true
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: startAddNewTranslation,
              child: const Icon(Icons.add),
            ),
    );
  }
}
