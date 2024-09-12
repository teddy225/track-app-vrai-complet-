import 'package:depense_track/domain/entities/transation_entite.dart';

abstract class TransactionRepositori {
  Stream<List<TransactionEntite>> watchTransaction();
  Future<void> getTransaction();
  //ajouter une transation
  Future<void> addTransaction(TransactionEntite transaction);
  //supprimer une transation
  Future<void> deletedTransaction(var id);
}
