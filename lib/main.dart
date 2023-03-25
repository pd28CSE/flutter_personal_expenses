import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './model/transactions.dart';

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ...transactions.map((Transaction item) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 70,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Tk ${item.price.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.title),
                          Text(item.dateTime.toString())
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}





// ListTile(
//                     leading: CircleAvatar(
//                         child: Text(item.price.toStringAsFixed(2))),
//                     title: Text(item.title),
//                     subtitle: Text('${item.dateTime.day}'),
//                     trailing: Text('${item.dateTime.day}'),
//                   )
