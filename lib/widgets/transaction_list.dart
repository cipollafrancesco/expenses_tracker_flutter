import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:second_flutter_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  void hadleDeleteTransaction(String id) {
    print('DELETING >>> $id');
    deleteTransaction(id);
  }

  @override
  Widget build(BuildContext context) {
    // IL BUILDER FA TUTTE LE OTTIMIZZAZIONI DI UNA RECYCLE VIEW (da utilizzare per liste lunghe)
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text('No transactions added yet!'),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/box.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 75),
            itemBuilder: (BuildContext context, int index) {
              // CURRENT TRANSACTION
              final transaction = transactions[index];

              return Card(
                elevation: 0.5,
                margin: EdgeInsets.all(1),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('${transaction.amount} €'),
                      ),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    transaction.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing:
                      /*MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () =>
                              hadleDeleteTransaction(transaction.id),
                          icon: Icon(Icons.delete),
                          label: Text('Remove transaction'),
                        )
                      : */
                      IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => hadleDeleteTransaction(transaction.id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
