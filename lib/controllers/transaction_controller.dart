import 'package:get/get.dart';
import '../models/transaction_model.dart';
import '../services/database_services.dart';

class TransactionController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();

  // RxList to make UI reactive
  final RxList<ExpenseTransaction> transactions = <ExpenseTransaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      final transactionList = await _databaseService.getTransactions();
      transactions.assignAll(transactionList);
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  Future<void> addTransaction(ExpenseTransaction transaction) async {
    try {
      await _databaseService.addTransaction(transaction);
      transactions.add(transaction);
      // await loadTransactions();
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _databaseService.deleteTransaction(id);
      transactions.removeWhere((tx) => tx.id == id); // Reactive removal
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Future<void> updateTransaction(ExpenseTransaction transaction) async {
    try {
      await _databaseService.updateTransaction(transaction);
      final index = transactions.indexWhere((tx) => tx.id == transaction.id);
      if (index != -1) {
        transactions[index] = transaction;
        transactions.refresh();
      }
    } catch (e) {
      print('Error updating transaction: $e');
    }
  }
}
