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
  })  : id = uuid.v4(),
        super(montant: montant, date: date);
  final String id;
  final double montant;
  final String description;
  final DateTime date;
  final Icon iconRevenu;
}
