import 'package:depense_track/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Revenu extends Transaction {
  Revenu({
    required this.montant,
    required this.description,
    required this.date,
    required this.iconRevenu,
    required this.type,
  })  : id = uuid.v4(),
        super(montant: montant, date: date);
  final String id;
  final double montant;
  final String description;
  final DateTime date;
  final Icon iconRevenu;
  final String type;

  @override
  // il faut toujour maper la liste donc c'est du json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'description': description,
      'date': date,
      'icon': iconRevenu,
      'type': 'revenue',
    };
  }

  factory Revenu.fromMap(Map<String, dynamic> map) {
    return Revenu(
        montant: map['montant'],
        description: map['description'],
        date: map['date'],
        iconRevenu: map['iconRevenu'],
        type: map['type']);
  }
}
