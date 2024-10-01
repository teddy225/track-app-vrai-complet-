import 'package:depense_track/data/model/statistique.dart';
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
    return await openDatabase(
      path,
      version: 1,
      onCreate: _creationDB,
    );
  }

  Future _creationDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuui TEXT,
        montant REAL,
        typeTransaction TEXT,
        categorieId INTEGER,
        description TEXT,
        date TEXT
       
      )
    ''');
    await db.execute('''
      CREATE TABLE statistique(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        totalRevenu REAL NOT NULL DEFAULT 0,
        totalDepense REAL NOT NULL DEFAULT 0,
        balance REAL NOT NULL DEFAULT 0
       
      )
    ''');
    // ici comme se son des calcul je fait l'initialisation a la creation de la table
    await db.insert('statistique', {
      'totalRevenu': 0,
      'totalDepense': 0,
      'balance': 0,
    });
  }

// recuperation des transation sous forme de Stream
  Stream<List<TransactionModel>> watchTransation() async* {
    try {
      final db = await database;

      yield* Stream.periodic(const Duration(seconds: 0), (_) async {
        final List<Map<String, dynamic>> maps =
            await db.query(('transactions'), distinct: true);

        return maps.map((e) {
          return TransactionModel.fromMap(e);
        }).toList();
      }).asyncMap((event) async {
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
  Future<void> insertionTransaction(TransactionModel transaction) async {
    final db = await database;
    try {
      await db.insert(
        'transactions',
        transaction.toMap(),
      );
      await miseAjourStatisque(transaction);
    } catch (e) {
      rethrow;
    }
  }

// suppimer une transaction et actualiser les totaux
  Future<void> deleteTransaction(TransactionModel transaction) async {
    Database db = await database;

    try {
      //permet de supprimer grace a l'id uuid qui viens depuit le home de l'app
      //maiS Qui passe passe Use case et implementProvider
      await db.delete(
        'transactions',
        where: 'uuui = ?',
        whereArgs: [transaction.uuui],
      );
      supprimerFromStatistique(transaction);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> modifierTransaction(TransactionModel transactionAmodier,
      TransactionModel newTransaction) async {
    Database db = await database;
    //modifier les donnees des statisque
    supprimerFromStatistique(transactionAmodier);
    await db.update('transactions', newTransaction.toMap(),
        where: 'uuui = ?', whereArgs: [transactionAmodier.uuui]);
  }

  Future<void> printAllPersonnes() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('statistique');
    print(maps.first);
    print(maps);
  }

  // icic se sont les action pour statistique

  Stream<Statistique> watchStatistique() async* {
    printAllPersonnes();

    try {
      final db = await database;
      yield* Stream.periodic(const Duration(seconds: 0), (_) async {
        final List<Map<String, dynamic>> listeStats =
            await db.query(('statistique'));
        return Statistique.fromMap(listeStats.first);
      }).asyncMap((event) async {
        return await event;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> miseAjourStatisque(TransactionModel transaction) async {
    Database db = await database;

    List<Map<String, dynamic>> listeStatistique = await db.query('statistique');

    if (listeStatistique.isNotEmpty) {
      Map<String, dynamic> stats =
          Map<String, dynamic>.from(listeStatistique.first);
      if (transaction.typeTransaction == 'revenu') {
        stats['totalRevenu'] += transaction.montant;
      } else if (transaction.typeTransaction == 'depense') {
        stats['totalDepense'] += transaction.montant;
      }
      stats['balance'] = stats['totalRevenu'] - stats['totalDepense'];
      await db.update(
        'statistique',
        stats,
        where: 'id = ?',
        whereArgs: [1],
      );
    }
    // calcule de la balance

    // mise a jour de la table statistique
  }

  Future<void> supprimerFromStatistique(TransactionModel transaction) async {
    Database db = await database;

    List<Map<String, dynamic>> listeStatistique = await db.query('statistique');

    if (listeStatistique.isNotEmpty) {
      Map<String, dynamic> stats =
          Map<String, dynamic>.from(listeStatistique.first);
      if (transaction.typeTransaction == 'revenu') {
        stats['totalRevenu'] -= transaction.montant;
      } else if (transaction.typeTransaction == 'depense') {
        stats['totalDepense'] -= transaction.montant;
      }
      stats['balance'] = stats['totalRevenu'] - stats['totalDepense'];
      await db.update(
        'statistique',
        stats,
        where: 'id = ?',
        whereArgs: [1],
      );
    }
  }
}
