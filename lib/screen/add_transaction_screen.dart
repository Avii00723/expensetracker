import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/models/transaction_model.dart' as model;

import '../controllers/transaction_controller.dart';

class AddTransactionScreen extends StatelessWidget {
  final TransactionController _transactionController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('Building AddTransactionScreen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter category' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter amount' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter date' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Add Transaction button pressed');
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Form validation passed');
                    try {
                      final transaction = model.ExpenseTransaction(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        category: _categoryController.text,
                        amount: double.parse(_amountController.text),
                        date: DateTime.parse(_dateController.text),
                        description: _descriptionController.text,
                      );

                      debugPrint('Transaction created: ${transaction.toMap()}');
                      _transactionController.addTransaction(transaction).then((_) {
                        debugPrint('Transaction added successfully!');
                        Navigator.pop(context, true); // Pass true as a result
                      }).catchError((e) {
                        debugPrint('Error adding transaction: $e');
                      });
                    } catch (e) {
                      debugPrint('Exception while adding transaction: $e');
                    }
                  } else {
                    debugPrint('Form validation failed');
                  }
                },
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
