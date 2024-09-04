import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/transaction.dart' as model;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(path, version: 1, onCreate: _creationDB);
  }

  Future _creationDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        montant REAL,
        description TEXT,
        date TEXT,
        categorieId TEXT,
        type TEXT
      )
    ''');
  }

// Fonction d'insertion
// a cause du conflit j'ai fais un as pour specifier sa provenace
  Future<int> insertTransaction(model.Transaction transaction) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

//Fonction de récupération
  Future<List<model.Transaction>> getAllTransactions() async {
    Database db = await DatabaseHelper.instance.database;
    var transactions = await db.query('transactions');
    List<model.Transaction> transactionList = transactions.isNotEmpty
        ? transactions.map((c) => model.Transaction.fromMap(c)).toList()
        : [];
    return transactionList;
  }

// Fonction de mise à jour
  Future<int> updateTransaction(model.Transaction transaction) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

// Fonction de suppression
  Future<int> deleteTransaction(String id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
