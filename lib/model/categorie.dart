import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Categorie {
  Categorie({
    required this.nom,
    required this.icon,
    required this.couleurBack,
    id,
  }) : id = uuid.v4();
  final String id;
  final String nom;
  final Icon icon;
  final Color couleurBack;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'icon': icon,
      'couleurBack': couleurBack.toString(),
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id: map['id'],
      nom: map['nom'],
      icon: map['icon'],
      couleurBack: map['couleurBack'],
    );
  }
}

Categorie? getCategorieById(String id, List<Categorie> categories) {
  return categories.firstWhere(
    (categorie) => categorie.id == id,
  );
}
