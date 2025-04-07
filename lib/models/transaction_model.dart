// transaction_model.dart
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ExpenseTransaction {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String description;

  ExpenseTransaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.description,
  });

  // Convert ExpenseTransaction to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),  // Convert DateTime to ISO string
      'description': description,
    };
  }

  factory ExpenseTransaction.fromMap(Map<String, dynamic> map) {
    return ExpenseTransaction(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),  // Parse from ISO string
      description: map['description'],
    );
  }
  double calculateTotal(List<ExpenseTransaction> transactions) {
    return transactions.fold(0.0, (sum, tx) => sum + tx.amount);
  }
  List<ExpenseTransaction> sortByAmount(List<ExpenseTransaction> transactions, {bool descending = false}) {
    transactions.sort((a, b) => descending ? b.amount.compareTo(a.amount) : a.amount.compareTo(b.amount));
    return transactions;
  }

  List<ExpenseTransaction> sortByDate(List<ExpenseTransaction> transactions, {bool descending = false}) {
    transactions.sort((a, b) {
      final dateA = DateTime.parse(a.date as String);
      final dateB = DateTime.parse(b.date as String);
      return descending ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
    return transactions;
  }

}