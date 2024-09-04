import 'package:depense_track/model/transaction.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DepenseModel extends Transaction {
  DepenseModel({
    required this.titre,
    required super.montant,
    required super.date,
    required this.categorieId,
    required this.type,
  }) : id = uuid.v4();
  final String id;
  final String titre;
  final String categorieId;
  final String type;

  @override
  //ici il faut maper la liste qui est du json  en vrai

  Map<String, dynamic> toMap() {
    return {
      // DU JSON
      'id': id,
      'montant': montant,
      'description': titre,
      'date': date.toIso8601String(),
      'categorie': categorieId,
      'type': 'depense',
    };
  }

  factory DepenseModel.fromMap(Map<String, dynamic> map) {
    return DepenseModel(
        //voici la map
        montant: map['montant'],
        titre: map['description'],
        date: DateTime.parse(map['date']),
        categorieId: map['categorieId'],
        type: map['type']);
  }
}
