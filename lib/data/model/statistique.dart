import 'package:depense_track/domain/entities/statistique_entitie.dart';

class Statistique extends StatistiqueEntitie {
  Statistique({
    required super.totalRevenu,
    required super.totalDepense,
    required super.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalRevenu': totalRevenu,
      'totalDepense': totalDepense,
      'balance': balance,
    };
  }

  factory Statistique.fromMap(Map<String, dynamic> map) {
    return Statistique(
      totalRevenu: map['totalRevenu'],
      totalDepense: map['totalDepense'],
      balance: map['balance'],
    );
  }
}
