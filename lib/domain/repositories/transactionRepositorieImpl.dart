import 'package:depense_track/data/dataresources/local_db.dart';
import 'package:depense_track/data/model/transaction_model.dart';
import 'package:depense_track/domain/entities/transation_entite.dart';
import 'package:depense_track/domain/repositories/transaction_repositori.dart';

class Transactionrepositorieimpl implements TransactionRepositori {
  Transactionrepositorieimpl(this.localDb);
  final LocalDb localDb;
  @override
  Future<void> addTransaction(TransactionEntite transaction) async {
    final transactionModel = TransactionModel(
        montant: transaction.montant,
        typeTransaction: transaction.typeTransaction,
        categorieId: transaction.categorieId,
        description: transaction.description,
        date: transaction.date);
    return localDb.insertionTransaction(transactionModel);
  }

  @override
  Future<void> deletedTransaction(var id) async {
    return localDb.deleteTransaction(id);
  }

  @override
  Stream<List<TransactionEntite>> watchTransaction() {
    print('localDB');
    try {
      print(localDb);
      return localDb.watchTransation();
    } catch (e) {
      print("eoooo $e");
      rethrow;
    }
  }

  @override
  Future<void> getTransaction() {
    return localDb.getTransaction();
  }
}
