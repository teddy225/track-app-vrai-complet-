//class abstract pour gere les transation de base

abstract class TransactionEntite {
  TransactionEntite({
    required this.montant,
    required this.typeTransaction,
    required this.categorieId,
    this.description,
    required this.date,
  });
  final double montant;
  final String typeTransaction;
  final int categorieId;
  final String? description;
  final DateTime date;
}
