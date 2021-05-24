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

  void handleSubmit() {
    // SIMPLE VALUES VALIDATION
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    addTransaction(title, amount);
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
              onSubmitted: (_) => handleSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount', suffixText: '€'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => handleSubmit(),
            ),
            TextButton(
              onPressed: handleSubmit,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
