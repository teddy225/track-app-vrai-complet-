import 'package:depense_track/model/depense.dart';
import 'package:depense_track/model/revenu.dart';
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

  Map<String, dynamic> toMap();
  factory Transaction.fromMap(Map<String, dynamic> map) {
    if (map['type'] == ' revenue') {
      return Revenu.fromMap(map);
    } else {
      return DepenseModel.fromMap(map);
    }
  }
}
