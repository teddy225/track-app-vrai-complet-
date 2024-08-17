import 'package:depense_track/model/categorie.dart';
import 'package:depense_track/model/transaction.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DepenseModel extends Transaction {
  DepenseModel({
    required this.titre,
    required super.montant,
    required super.date,
    required this.categorie,
  });

  final String titre;

  final Categorie categorie;
}
