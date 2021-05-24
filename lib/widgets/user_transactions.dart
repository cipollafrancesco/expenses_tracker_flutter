import 'package:flutter/material.dart';
import 'package:second_flutter_app/models/transaction.dart';
import 'package:second_flutter_app/widgets/transaction_form.dart';
import 'package:second_flutter_app/widgets/transaction_list.dart';
import 'package:uuid/uuid.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  // FAKE TRANSACTIONS LIST
  final List<Transaction> _transactions = [
    Transaction(
      id: '001',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '002',
      title: 'New Jeans',
      amount: 49.99,
      date: DateTime.now(),
    ),Transaction(
      id: '002',
      title: 'New Jeans',
      amount: 49.99,
      date: DateTime.now(),
    ),Transaction(
      id: '002',
      title: 'New Jeans',
      amount: 49.99,
      date: DateTime.now(),
    ),Transaction(
      id: '002',
      title: 'New Jeans',
      amount: 49.99,
      date: DateTime.now(),
    ),Transaction(
      id: '001',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),Transaction(
      id: '001',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),Transaction(
      id: '001',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),

  ];

  void addTransaction(String title, double amount) {
    print('ADDING TRANSACTION: ' + title + ' --> ' + amount.toString());

    final transaction = Transaction(
      id: Uuid().v1(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // INPUT AREA
        TransactionForm(_transactions, addTransaction),
        // TRANSACTIONS
        TransactionList(_transactions),
      ],
    );
  }
}
