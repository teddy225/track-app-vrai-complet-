import 'package:depense_track/screen/add_depense_screen.dart';
import 'package:depense_track/model/categorie.dart';
import 'package:depense_track/model/depense.dart';
import 'package:depense_track/model/revenu.dart';
import 'package:depense_track/model/transaction.dart';
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
            addnewdepense: addNewdepense,
            addNewRevenu: addnewRevenu,
          );
        });
  }

  void addNewdepense(DepenseModel depense) {
    setState(() {
      transaction.add(depense);
    });
  }

  void addnewRevenu(Revenu revenu) {
    setState(() {
      transaction.add(revenu);
    });
  }

  List<Revenu> listrevenu = [];
  List<Transaction> transaction = [];
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
                  height: 115,
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
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: listdepense.length,
              //       itemBuilder: (ctx, index) {
              //         return ListTile(
              //           dense: true,
              //           leading: CircleAvatar(
              //             backgroundColor:
              //                 listdepense[index].categorie.couleurBack,
              //             child: listdepense[index].categorie.icon,
              //           ),
              //           title: Text(
              //             listdepense[index].titre,
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 14),
              //           ),
              //           trailing: Text(
              //             '${listdepense[index].montant} Fcafa',
              //             style: const TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           subtitle: Text(
              //             ' ${listdepense[index].categorie.nom} - ${DateFormat('MMMM d, y').format(listdepense[index].date)}',
              //             style: const TextStyle(fontSize: 13),
              //           ),
              //           shape: const Border(
              //             bottom: BorderSide(
              //               width: 0.5,
              //               color: Colors.grey,
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //       itemCount: listrevenu.length,
              //       itemBuilder: (ctx, index) {
              //         return ListTile(
              //           dense: true,
              //           leading: CircleAvatar(
              //             backgroundColor: Colors.amber,
              //             child: listrevenu[index].iconRevenu,
              //           ),
              //           title: Text(
              //             listrevenu[index].description,
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 14),
              //           ),
              //           trailing: Text(
              //             '${listrevenu[index].montant} Fcafa',
              //             style: const TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           subtitle: Text(
              //             'Revenu - ${DateFormat('MMMM d, y').format(listrevenu[index].date)}',
              //             style: const TextStyle(fontSize: 13),
              //           ),
              //           shape: const Border(
              //             bottom: BorderSide(
              //               width: 0.5,
              //               color: Colors.grey,
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: transaction.length,
                    itemBuilder: (ctx, index) {
                      var transactionSelect = transaction[index];
                      if (transactionSelect is DepenseModel) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                transactionSelect.categorie.couleurBack,
                            child: transactionSelect.categorie.icon,
                          ),
                          title: Text(
                            transactionSelect.titre,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          trailing: Text(
                            '${transactionSelect.montant} Fcafa',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Depense - ${DateFormat('MMMM d, y').format(transactionSelect.date)}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          shape: const Border(
                            bottom: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      } else if (transactionSelect is Revenu) {
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: transactionSelect.iconRevenu,
                          ),
                          title: Text(
                            transactionSelect.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          trailing: Text(
                            '${transactionSelect.montant} Fcafa',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Revenu - ${DateFormat('MMMM d, y').format(transactionSelect.date)}',
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
                      return Container();
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
