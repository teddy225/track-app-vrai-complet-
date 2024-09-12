import 'package:flutter/material.dart';

class ContainerTransaction extends StatelessWidget {
  const ContainerTransaction(
      {super.key,
      required this.titreContainer,
      required this.somme,
      required this.couleurContainer});
  final String titreContainer;
  final double somme;
  final Color couleurContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: couleurContainer, borderRadius: BorderRadius.circular(10)),
      height: 100,
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              titreContainer,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              '${somme.toString()} fcfa',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
