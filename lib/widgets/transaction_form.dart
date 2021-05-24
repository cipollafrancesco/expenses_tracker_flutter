import 'package:flutter/material.dart';
import 'package:second_flutter_app/models/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatelessWidget {
  final List<Transaction> transactions;
  final Function addTransaction;

  TransactionForm(this.transactions, this.addTransaction);

  // MANUALLY CONTROLLED INPUT

  // late String titleInput;
  // late String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void onAddTransactionPress() {
    addTransaction(titleController.text, double.parse(amountController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount', suffixText: '€'),
              controller: amountController,
              // onChanged: (value) => amountInput = value,
            ),
            TextButton(
              onPressed: onAddTransactionPress,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
