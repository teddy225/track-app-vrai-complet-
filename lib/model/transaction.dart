import 'package:uuid/uuid.dart';

const uuid = Uuid();

abstract class Transaction {
  final String id;
  final double montant;
  final DateTime date;

  Transaction({
    required this.montant,
    required this.date,
  }) : id = uuid.v4();
}
