import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_flutter_app/models/transaction.dart';
import 'package:second_flutter_app/widgets/transaction_form.dart';
import 'package:second_flutter_app/widgets/transaction_list.dart';
import 'package:second_flutter_app/widgets/user_transactions.dart';

import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CHART
            Chart(),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
