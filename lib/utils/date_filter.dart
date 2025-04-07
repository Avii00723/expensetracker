// utils/date_filter.dart
import '../models/transaction_model.dart';

List<ExpenseTransaction> filterByDateRange(
    List<ExpenseTransaction> transactions,
    DateTime startDate,
    DateTime endDate) {
  return transactions.where((tx) {
    final txDate = DateTime.parse(tx.date as String);
    return txDate.isAfter(startDate.subtract(Duration(days: 1))) &&
        txDate.isBefore(endDate.add(Duration(days: 1)));
  }).toList();
}
