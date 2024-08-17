import 'package:depense_track/screen/add_depense_screen.dart';
import 'package:depense_track/screen/model/categorie.dart';
import 'package:depense_track/screen/model/depense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _modalbottomShette() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddDepenseScreen(
            addnewdepenseourevenu: addnewDepense_ou_revenu,
          );
        });
  }

  void addnewDepense_ou_revenu(
      {required String titre,
      required double montant,
      required DateTime date,
      required Categorie categorie}) {
    setState(() {
      listdepense.add(
        DepenseModel(
            titre: titre, montant: montant, date: date, categorie: categorie),
      );
    });
  }

  List<DepenseModel> listdepense = [
    DepenseModel(
      titre: 'lol1',
      montant: 100,
      date: DateTime.now(),
      categorie: Categorie(
          nom: 'Shopping',
          icon: const Icon(
            Icons.shopping_bag,
            color: Colors.purple,
          ),
          couleurBack: const Color.fromARGB(255, 245, 206, 252)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: const Text('Salut Teddy'),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 166, 39),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  width: double.infinity,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Total de la balance',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 206, 58),
                        borderRadius: BorderRadius.circular(10)),
                    height: 170,
                    width: 180,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 201, 152, 3),
                        borderRadius: BorderRadius.circular(10)),
                    height: 170,
                    width: 180,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 310,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listdepense.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor:
                              listdepense[index].categorie.couleurBack,
                          child: listdepense[index].categorie.icon,
                        ),
                        title: Text(
                          listdepense[index].titre,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        trailing: Text(
                          '${listdepense[index].montant} Fcafa',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          ' ${listdepense[index].categorie.nom} - ${DateFormat('MMMM d, y').format(listdepense[index].date)}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        shape: const Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _modalbottomShette,
        child: const Icon(Icons.add),
      ),
    );
  }
}
