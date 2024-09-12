import 'package:depense_track/data/model/transaction_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDb {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transaction_app_.db');
    return await openDatabase(path, version: 1, onCreate: _creationDB);
  }

  Future _creationDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        montant REAL,
        typeTransaction TEXT,
        categorieId INTEGER,
        description TEXT,
        date TEXT
       
      )
    ''');
  }

// recuperation des transation sous forme de Stream
  Stream<List<TransactionModel>> watchTransation() async* {
    printAllPersonnes();
    try {
      final db = await database;

      yield* Stream.periodic(const Duration(seconds: 0), (_) async {
        final List<Map<String, dynamic>> maps =
            await db.query(('transactions'));

        return maps.map((e) {
          return TransactionModel.fromMap(e);
        }).toList();
      }).distinct().asyncMap((event) async {
        return await event;
      });
    } catch (e) {
      yield [];

      rethrow;
    }
  }

// récuperation de toutes les donnees
  Future<List<TransactionModel>> getTransaction() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> map = await db.query('transactions');
      return map.map((transation) {
        return TransactionModel.fromMap(transation);
      }).toList();
    } catch (e) {
      print('erreru $e');
      rethrow;
    }
  }

// Insertion d'une nouvelle Transation
  Future<void> insertionTransaction(TransactionModel transation) async {
    try {
      await _database!
          .insert(
        'transactions',
        transation.toMap(),
      )
          .then((value) {
        return;
      }).catchError((onError) {
        return;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(var date) async {
    try {
      await _database!.delete(
        'transactions',
        where: 'date = ?',
        whereArgs: [date],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> printAllPersonnes() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    for (var map in maps) {
      print(
        'ID: ${map['id']}, montant: ${map['montant']}, typeTransation: ${map['typeTransation']}',
      );
    }
  }
}
