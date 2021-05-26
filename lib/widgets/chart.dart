import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_flutter_app/models/transaction.dart';
import 'package:second_flutter_app/widgets/cart_bar.dart';

// TODO CAPIRE SE È NECESSARIO CREARE QUESTI TIPI
class GroupedTransactionValue {
  String day;
  double amount;

  GroupedTransactionValue({required this.day, required this.amount});
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<GroupedTransactionValue> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      if (index <= recentTransactions.length) {
        totalSum = recentTransactions
            .sublist(0, index)
            .fold(0.0, (aggregator, element) => aggregator + element.amount);
      }

      return GroupedTransactionValue(
        day: DateFormat.E().format(weekDay),
        amount: totalSum,
      );
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0.0, (aggregator, transaction) => aggregator + transaction.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionValues.map(
              (transaction) => Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: transaction.day,
                  spendingAmount: transaction.amount,
                  spendingPctOfTotal: maxSpending == 0.0
                      ? 0.0
                      : transaction.amount / maxSpending,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
