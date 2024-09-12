import 'package:depense_track/domain/entities/transation_entite.dart';
import 'package:depense_track/domain/repositories/transaction_repositori.dart';

class TransactionUsecase {
  //constructeur
  TransactionUsecase({required this.transactionRepositori});

  //argument du constructeur
  final TransactionRepositori transactionRepositori;

  Stream<List<TransactionEntite>> getTransations() {
    return transactionRepositori.watchTransaction();
  }

// new
  Future<void> getTransationsNowath() {
    return transactionRepositori.getTransaction();
  }

  Future<void> addTransaction(TransactionEntite transaction) {
    return transactionRepositori.addTransaction(transaction);
  }

  Future<void> deletedTransaction(int id) {
    return transactionRepositori.deletedTransaction(id);
  }
}
