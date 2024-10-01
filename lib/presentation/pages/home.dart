import 'package:depense_track/data/data%20const/data_const.dart';
import 'package:depense_track/data/model/categorie_model.dart';
import 'package:depense_track/data/model/transaction_model.dart';
import 'package:depense_track/domain/entities/transation_entite.dart';
import 'package:depense_track/presentation/pages/add_transaction.dart';
import 'package:depense_track/presentation/pages/widgets/ContainerBalance.dart';
import 'package:depense_track/presentation/pages/widgets/container_transaction.dart';
import 'package:depense_track/presentation/pages/widgets/widgets_transaction.dart';
import 'package:depense_track/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final transactionListAsyncvalue = ref.watch(transactionListProvder);
    final transactionAction = ref.read(transactionRepositoriProvider);
    final statistiqueasync = ref.watch(statisiqueProvdier);

    Future<void> supprimerTansaction(TransactionEntite uuui) async {
      return transactionAction.deletedTransaction(uuui);
    }

    Future<void> add() async {
      return setState(() {
        transactionAction.addTransaction(
          TransactionModel(
            montant: 2000,
            categorieId: 0,
            description: 'dksks',
            date: DateTime.now(),
            typeTransaction: 'revenu',
            uuui: uuid.v4(),
          ),
        );
      });
    }

    void modalbottomShette() {
      showModalBottomSheet(
          useRootNavigator: true,
          isScrollControlled: true,
          context: context,
          builder: (ctx) {
            return const FormAddTransaction();
          });
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            modalbottomShette();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Salut Teddy Bienvenue'),
        ),
        drawer: SafeArea(child: const Drawer()),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      statistiqueasync.when(
                          data: ((stats) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                ContainerBalance(sommebalace: stats.balance),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ContainerTransaction(
                                      titreContainer: ' Total des revenus',
                                      somme: stats.totalRevenu,
                                      couleurContainer: const Color.fromARGB(
                                          255, 27, 132, 158),
                                    ),
                                    ContainerTransaction(
                                      titreContainer: ' Total des depenses',
                                      somme: stats.totalDepense,
                                      couleurContainer: const Color.fromARGB(
                                          255, 248, 75, 62),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                          error: (e, _) => const Text('data'),
                          loading: () => const CircularProgressIndicator())
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Historique',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 470,
                    child: transactionListAsyncvalue.when(data: (transaction) {
                      if (transaction.isEmpty) {
                        return const Center(
                          child: Text(
                            'Pas De Depense & Revenu pour l\'instant',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transaction.length,
                          itemBuilder: (ctx, index) {
                            print(transaction[index].date);
                            print(transaction[index].uuui);
                            Categorie? categorie = getCategorieById(
                                transaction[index].categorieId, categories);
                            return InkWell(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Suppimer cette Transaction',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              'type: ${transaction[index].typeTransaction} '),
                                          Text(
                                            'description : ${transaction[index].description}',
                                          ),
                                          Text(
                                              ' montant: ${transaction[index].montant}')
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            supprimerTansaction(
                                                transaction[index]);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Supprimer'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Annuler'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: WidgetTransation(
                                titre: transaction[index].description,
                                montant: transaction[index].montant,
                                date: transaction[index].date,
                                type: transaction[index].typeTransaction,
                                categorieId: transaction[index].categorieId,
                                couleurBack: categorie!.couleurBack,
                                icon: categorie.icon,
                                couleurIcon: categorie.couleurIcon,
                              ),
                            );
                          });
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      );
                    }, error: (error, stack) {
                      return Center(
                        child: Text("erreur $error $stack "),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
