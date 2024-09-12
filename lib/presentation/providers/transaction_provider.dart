import 'package:depense_track/data/dataresources/local_db.dart';
import 'package:depense_track/domain/entities/transation_entite.dart';
import 'package:depense_track/domain/repositories/transactionRepositorieImpl.dart';
import 'package:depense_track/domain/repositories/transaction_repositori.dart';
import 'package:depense_track/domain/transaction_useCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoriProvider = Provider<TransactionRepositori>((ref) {
  var locadatabase = LocalDb();
  return Transactionrepositorieimpl(locadatabase);
});

final transactionUseCaseProvider = Provider((ref) {
  final repositori = ref.watch(transactionRepositoriProvider);
  return TransactionUsecase(transactionRepositori: repositori);
});

final transactionListProvder =
    StreamProvider.autoDispose<List<TransactionEntite>>(
  (ref) {
    final userCase = ref.watch(transactionUseCaseProvider);
    return userCase.getTransations();
  },
);
