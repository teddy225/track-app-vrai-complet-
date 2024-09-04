import 'package:depense_track/database/db_local.dart';
import 'package:depense_track/model/categorie.dart';
import 'package:depense_track/screen/add_depense_screen.dart';
import 'package:depense_track/model/depense.dart';
import 'package:depense_track/model/revenu.dart';
import 'package:depense_track/model/transaction.dart';
import 'package:depense_track/widgets/containerDepense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart' as sqflite;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//mauvaise pratique j'aurai besoin d'un riverpod
  final List<Categorie> categories = [
    Categorie(
        nom: 'Shopping',
        icon: const Icon(
          Icons.shopping_bag,
          color: Colors.purple,
        ),
        couleurBack: const Color.fromARGB(255, 245, 206, 252)),
    Categorie(
      nom: 'Transport',
      icon: const Icon(
        Icons.car_repair_rounded,
        color: Colors.green,
      ),
      couleurBack: const Color.fromARGB(255, 205, 251, 207),
    ),
    Categorie(
      nom: 'Nourriture',
      icon: const Icon(
        Icons.food_bank,
        color: Colors.orange,
      ),
      couleurBack: const Color.fromARGB(255, 247, 217, 174),
    ),
    Categorie(
      nom: 'Imprevu',
      icon: const Icon(
        Icons.keyboard_command_key_sharp,
        color: Color.fromARGB(255, 255, 8, 8),
      ),
      couleurBack: const Color.fromARGB(255, 248, 161, 161),
    ),
    Categorie(
      nom: 'Facture',
      icon: const Icon(
        Icons.electric_bolt_rounded,
        color: Color.fromARGB(255, 2, 132, 0),
      ),
      couleurBack: const Color.fromARGB(255, 103, 255, 118),
    ),
  ];
  void chargerTransactions() async {
    List<Transaction> allTransactions =
        await DatabaseHelper.instance.getAllTransactions();
    setState(() {
      transactions = allTransactions; // Remplace ta liste locale
    });
  }

  List<Transaction> transactions = [];
  void _modalbottomShette() {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddDepenseScreen(
            addnewdepense: addNewdepense,
            addNewRevenu: addnewRevenu,
          );
        });
  }

  void addNewdepense(DepenseModel depense) async {
    await DatabaseHelper.instance.insertTransaction(depense);
    setState(() {
      transactions.insert(0, depense);
      calculeSomme();
    });
  }

  void addnewRevenu(Revenu revenu) async {
    await DatabaseHelper.instance.insertTransaction(revenu);
    setState(() {
      transactions.insert(
        0,
        revenu,
      );
      calculeSomme();
    });
  }

  void supprimer(Transaction transaction) async {
    await DatabaseHelper.instance.deleteTransaction(transaction.id);

    setState(() {
      transactions
          .removeWhere((transactions) => transactions.id == transaction.id);
    });
  }

  double totalRevenu = 0;
  double totalDepense = 0;
  double sommebalace = 0;

  @override
  void initState() {
    super.initState();
    calculeSomme();
    chargerTransactions();
  }

  void calculeSomme() {
    totalRevenu = transactions.whereType<Revenu>().fold<double>(totalRevenu,
        (previousValue, element) => previousValue + element.montant);
    ;

    totalDepense = transactions.whereType<DepenseModel>().fold(
        totalDepense, (somme, transaction) => somme + transaction.montant);
    sommebalace = totalRevenu - totalDepense;
    if (totalRevenu <= totalDepense) {}
  }

  // creation de la ba de donner de sans riverpod jesper que sa va passer
  Future<void> _creationDb(sqflite.Database db, int version) async {
    // je veux cree une la table de de transaction
  }

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
              const SizedBox(
                height: 5,
              ),
              Center(
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
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
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
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Containerdepense(
                    titreContainer: ' Total des revenus',
                    somme: totalRevenu,
                    couleurContainer: const Color.fromARGB(255, 27, 132, 158),
                  ),
                  Containerdepense(
                    titreContainer: ' Total des depenses',
                    somme: totalDepense,
                    couleurContainer: const Color.fromARGB(255, 248, 75, 62),
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
                height: 380,
                child: ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (ctx, index) {
                      var transactionSelect = transactions[index];
                      if (transactionSelect is DepenseModel) {
                        Categorie? categorie = getCategorieById(
                            transactionSelect.categorieId, categories);

                        return Dismissible(
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(54, 152, 244, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.edit_sharp,
                              color: Colors.white,
                            ),
                          ),
                          secondaryBackground: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          key: Key(transactionSelect.id),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              supprimer(transactionSelect);
                            } else {
                              _modalbottomShette();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(149, 255, 1, 1),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: categorie?.couleurBack,
                                child: categorie?.icon,
                              ),
                              title: Text(
                                transactionSelect.titre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              trailing: Text(
                                '${transactionSelect.montant} Fcafa',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                'Depense - ${DateFormat.yMMMd('fr_FR').format(transactionSelect.date)}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      } else if (transactionSelect is Revenu) {
                        return Dismissible(
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(54, 152, 244, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.delete),
                          ),
                          secondaryBackground: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.delete),
                          ),
                          key: Key(transactionSelect.id),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              supprimer(transactionSelect);
                            } else {
                              _modalbottomShette();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(147, 30, 233, 255),
                            ),
                            child: ListTile(
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
