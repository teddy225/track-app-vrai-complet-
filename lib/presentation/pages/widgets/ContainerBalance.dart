import 'package:flutter/material.dart';

class ContainerBalance extends StatelessWidget {
  const ContainerBalance({super.key, required this.sommebalace});
  final double sommebalace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 151, 39),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 100,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Total de la balance',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                '${sommebalace.toString()} fcfa',
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
