import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transaction_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'expense_tracker.db');
      print("Initializing database at path: $path");

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print("Creating 'expenses' table...");
          await db.execute('''
            CREATE TABLE expenses (
              id TEXT PRIMARY KEY,
              category TEXT NOT NULL,
              amount REAL NOT NULL,
              date TEXT NOT NULL,
              description TEXT
            )
          ''');
          print("Table created successfully.");
        },
      );
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }

  Future<void> addTransaction(ExpenseTransaction transaction) async {
    try {
      final db = await database;
      await db.insert(
        'expenses',
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Transaction added: ${transaction.toMap()}");
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  Future<List<ExpenseTransaction>> getTransactions() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('expenses');
      print("Transactions fetched: $maps");

      return List.generate(maps.length, (i) {
        return ExpenseTransaction.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      final db = await database;
      await db.delete(
        'expenses',
        where: 'id = ?',
        whereArgs: [id],
      );
      print("Transaction with ID $id deleted.");
    } catch (e) {
      print("Error deleting transaction: $e");
    }
  }

  Future<void> updateTransaction(ExpenseTransaction transaction) async {
    try {
      final db = await database;
      await db.update(
        'expenses',
        transaction.toMap(),
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
      print("Transaction updated: ${transaction.toMap()}");
    } catch (e) {
      print("Error updating transaction: $e");
    }
  }
}
