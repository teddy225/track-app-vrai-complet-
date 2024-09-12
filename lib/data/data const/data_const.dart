import 'package:depense_track/data/model/categorie_model.dart';
import 'package:flutter/material.dart';

final List<Categorie> categories = [
  Categorie(
    categorieId: 0,
    nom: 'revenu',
    icon: Icons.monetization_on_sharp,
    couleurBack: const Color.fromARGB(255, 245, 242, 223),
    couleurIcon: const Color.fromARGB(255, 200, 193, 0),
  ),
  Categorie(
    categorieId: 1,
    nom: 'Shopping',
    icon: Icons.shopping_bag,
    couleurBack: const Color.fromARGB(255, 245, 206, 252),
    couleurIcon: const Color.fromARGB(255, 213, 22, 247),
  ),
  Categorie(
    categorieId: 2,
    nom: 'Transport',
    icon: Icons.car_repair_rounded,
    couleurBack: const Color.fromARGB(255, 215, 244, 217),
    couleurIcon: const Color.fromARGB(255, 4, 144, 8),
  ),
  Categorie(
    categorieId: 3,
    nom: 'Nourriture',
    icon: Icons.food_bank,
    couleurBack: const Color.fromARGB(255, 246, 225, 204),
    couleurIcon: const Color.fromARGB(255, 206, 125, 12),
  ),
  Categorie(
    categorieId: 4,
    nom: 'Imprévu',
    icon: Icons.keyboard_command_key_sharp,
    couleurBack: const Color.fromARGB(255, 242, 200, 200),
    couleurIcon: const Color.fromARGB(255, 246, 36, 36),
  ),
  Categorie(
    categorieId: 6,
    nom: 'Facture de courrant',
    icon: Icons.electric_bolt_rounded,
    couleurBack: const Color.fromARGB(255, 211, 245, 214),
    couleurIcon: const Color.fromARGB(255, 3, 161, 19),
  ),
  Categorie(
    categorieId: 6,
    nom: 'Facture d\'eau',
    icon: Icons.electric_bolt_rounded,
    couleurBack: const Color.fromARGB(255, 215, 243, 249),
    couleurIcon: const Color.fromARGB(255, 4, 122, 181),
  ),
  Categorie(
    categorieId: 7,
    nom: 'Autre',
    icon: Icons.electric_bolt_rounded,
    couleurBack: const Color.fromARGB(255, 248, 213, 231),
    couleurIcon: const Color.fromARGB(255, 201, 14, 148),
  ),
];
