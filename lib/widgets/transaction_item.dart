import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTranslationOnPressed,
  });

  final Transaction transaction;
  final Function deleteTranslationOnPressed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTranslationOnPressed(transaction.id);
        }
      },
      background: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 30),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  transaction.price.toStringAsFixed(0),
                ),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(transaction.dateTime),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 560
              ? TextButton.icon(
                  onPressed: () {
                    deleteTranslationOnPressed(transaction.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  label: Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    deleteTranslationOnPressed(transaction.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                ),
        ),
      ),
    );
  }
}
