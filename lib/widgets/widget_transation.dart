import 'package:flutter/material.dart';

class WidgetTransation extends StatelessWidget {
  const WidgetTransation(
      {super.key,
      required this.couleurBack,
      required this.icon,
      required this.titre,
      required this.montant,
      required this.date});
  final Color couleurBack;
  final Icon icon;
  final String titre;
  final double montant;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundColor: couleurBack,
        child: icon,
      ),
      title: Text(
        titre,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      trailing: Text(
        '$montant Fcafa',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Revenu - $date',
        style: const TextStyle(fontSize: 13),
      ),
      shape: const Border(
        bottom: BorderSide(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
