import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_flutter_app/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final List<Transaction> transactions;
  final Function addTransaction;

  TransactionForm(this.transactions, this.addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // FORM CONTROLLERS
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _handleSubmit() {
    // SIMPLE VALUES VALIDATION
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    // ACCEDI ALLE PROPRIETA DEL WIDGET STATELESS COLLEGATO A QUESTO STATEFUL
    widget.addTransaction(title, amount, _selectedDate);

    // CHIUDE IL LIVELLO PIU' ALTO APERTO IN QUEL MOMENTO
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // AVOID OVERLAPPING COMPONENTS WITH SingleChildScrollView
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            // viewInsets == quando spazio è già occupato sul display
            bottom: MediaQuery.of(context).viewInsets.bottom + 25,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _handleSubmit(),
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Amount', suffixText: '€'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _handleSubmit(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? 'Selected date: ${DateFormat.yMMMd().format(_selectedDate!)}'
                        : 'No date selected',
                  ),
                  // SHOW DATE PICKER BUTTON
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
