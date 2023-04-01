import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTranslationOnPressed;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTranslationOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty == true
        ? LayoutBuilder(builder: (cntxt, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transaction added yet!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (cntxt, index) => Card(
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
                        transactions[index].price.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].dateTime),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                trailing: MediaQuery.of(context).size.width > 560
                    ? TextButton.icon(
                        onPressed: () {
                          deleteTranslationOnPressed(transactions[index].id);
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
                          deleteTranslationOnPressed(transactions[index].id);
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


// // custom ListTile()
// class TransactionItem extends StatelessWidget {
//   final Transaction item;
//   const TransactionItem({
//     required this.item,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Row(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.symmetric(
//               vertical: 10.0,
//               horizontal: 15.0,
//             ),
//             padding: const EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               border: Border.all(
//                 color: Theme.of(context).primaryColor,
//                 width: 2,
//               ),
//             ),
//             child: Text(
//               'T${item.price.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.purple,
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 item.title,
//                 style: Theme.of(context).textTheme.displayMedium,
//               ),
//               Text(
//                 DateFormat.yMMMd().format(item.dateTime),
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color: Colors.grey,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


// 129 Num...