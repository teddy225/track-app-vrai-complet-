import 'package:depense_track/screen/model/categorie.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DepenseModel {
  DepenseModel({
    required this.titre,
    required this.montant,
    required this.date,
    required this.categorie,
  }) : id = uuid.v4();

  final String id;
  final String titre;
  final double montant;
  final DateTime date;
  final Categorie categorie;
}
