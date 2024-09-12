import 'package:flutter/material.dart';

class Categorie {
  Categorie({
    required this.categorieId,
    required this.nom,
    required this.icon,
    required this.couleurBack,
    required this.couleurIcon,
  });
  final int categorieId;
  final String nom;
  final IconData icon;
  final Color couleurBack;
  final Color couleurIcon;

  Map<String, dynamic> toMap() {
    return {
      'id': categorieId,
      'nom': nom,
      'icon': icon.codePoint,
      'couleurBack': couleurBack.value,
      'couleurIcon': couleurIcon,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      categorieId: map['categorieId'],
      nom: map['nom'],
      icon: IconData(map['icon']),
      couleurBack: Color(map['couleurBack']),
      couleurIcon: Color(map['couleurIcon']),
    );
  }
}

Categorie? getCategorieById(int id, List<Categorie> categories) {
  try {
    return categories.firstWhere((categorie) => categorie.categorieId == id);
  } catch (e) {
    return null; // Ou gérer l'erreur d'une autre manière
  }
}
