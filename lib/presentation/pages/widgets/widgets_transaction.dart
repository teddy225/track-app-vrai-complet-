import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetTransation extends StatelessWidget {
  const WidgetTransation({
    super.key,
    // required this.couleurBack,
    // required this.icon,
    required this.titre,
    required this.montant,
    required this.date,
    required this.type,
    required this.categorieId,
    required this.couleurBack,
    required this.icon,
    required this.couleurIcon,
  });
  // final Color couleurBack;
  // final Icon icon;
  final int categorieId;
  final String? titre;
  final double montant;
  final DateTime date;
  final String type;
  final Color couleurBack;
  final IconData icon;
  final Color couleurIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: type == 'revenu'
            ? const Color.fromARGB(164, 40, 228, 249)
            : const Color.fromARGB(228, 247, 95, 75),
      ),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          backgroundColor: couleurBack,
          child: type == 'revenu'
              ? const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                )
              : Icon(
                  icon,
                  color: couleurIcon,
                ),
        ),
        title: Text(
          titre!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: type == 'revenu'
                  ? const Color.fromARGB(255, 11, 9, 9)
                  : const Color.fromARGB(255, 255, 255, 255)),
        ),
        trailing: Column(
          children: [
            Text(
              '$montant Fcafa',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: type == 'revenu'
                      ? const Color.fromARGB(255, 11, 9, 9)
                      : const Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        subtitle: Text(
          '$type : ${DateFormat.yMMMd('fr_FR').format(date)}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: type == 'revenu' ? 14 : 13.8,
              color: type == 'revenu'
                  ? const Color.fromARGB(255, 11, 9, 9)
                  : const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
