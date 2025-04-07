// utils/formatter.dart
import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  return formatter.format(amount);
}
