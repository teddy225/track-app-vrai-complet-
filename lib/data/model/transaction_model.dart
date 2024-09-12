import 'package:depense_track/domain/entities/transation_entite.dart';

class TransactionModel extends TransactionEntite {
  TransactionModel(
      {required super.montant,
      required super.typeTransaction,
      required super.categorieId,
      required super.description,
      required super.date});

  Map<String, dynamic> toMap() {
    return {
      'montant': montant,
      'typeTransaction': typeTransaction,
      'categorieId': categorieId,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      montant: map['montant'],
      typeTransaction: map['typeTransaction'],
      categorieId: map['categorieId'],
      description: map['description'],
      date: DateTime.parse(
        map['date'],
      ),
    );
  }
}
