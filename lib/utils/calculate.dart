import '../models/transaction_model.dart';

double calculateTotal(List<ExpenseTransaction> transactions) {
  return transactions.fold(0.0, (sum, tx) => sum + tx.amount);
}
Map<String, double> calculateTotalsByCategory(List<ExpenseTransaction> transactions) {
  final Map<String, double> totals = {};

  for (var tx in transactions) {
    if (totals.containsKey(tx.category)) {
      totals[tx.category] = totals[tx.category]! + tx.amount;
    } else {
      totals[tx.category] = tx.amount;
    }
  }

  return totals;
}