import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365,
      child: transactions.isEmpty == true
          ? Column(
              children: <Widget>[
                Text(
                  'No Transaction added yet!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (cntxt, index) => TransactionItem(
                item: transactions[index],
              ),
            ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction item;
  const TransactionItem({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: Text(
              'T${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                DateFormat.yMMMd().format(item.dateTime),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
