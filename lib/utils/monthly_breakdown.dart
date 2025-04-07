// utils/monthly_breakdown.dart
import '../models/transaction_model.dart';

Map<String, double> calculateMonthlySpending(List<ExpenseTransaction> transactions) {
  final Map<String, double> monthlyTotal = {};

  for (var tx in transactions) {
    final date = DateTime.parse(tx.date as String);
    final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';

    monthlyTotal[monthKey] = (monthlyTotal[monthKey] ?? 0) + tx.amount;
  }

  return monthlyTotal;
}
