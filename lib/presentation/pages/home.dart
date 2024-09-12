import 'package:depense_track/data/data%20const/data_const.dart';
import 'package:depense_track/data/model/categorie_model.dart';
import 'package:depense_track/data/model/transaction_model.dart';
import 'package:depense_track/presentation/pages/add_transaction.dart';
import 'package:depense_track/presentation/pages/widgets/ContainerBalance.dart';
import 'package:depense_track/presentation/pages/widgets/container_transaction.dart';
import 'package:depense_track/presentation/pages/widgets/widgets_transaction.dart';
import 'package:depense_track/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    Future<void> supprimerTansaction(String id) async {
      return transactionAction.deletedTransaction(id);
    }

    Future<void> add() async {
      return setState(() {
        transactionAction.addTransaction(
          TransactionModel(
            montant: 2,
            categorieId: 0,
            description: 'dksks',
            date: DateTime.now(),
            typeTransaction: 'z',
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
          onPressed: modalbottomShette,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const ContainerBalance(sommebalace: 0.0),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContainerTransaction(
                        titreContainer: ' Total des revenus',
                        somme: 0.0,
                        couleurContainer:
                            const Color.fromARGB(255, 27, 132, 158),
                      ),
                      ContainerTransaction(
                        titreContainer: ' Total des depenses',
                        somme: 0.0,
                        couleurContainer:
                            const Color.fromARGB(255, 248, 75, 62),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 600,
                    child: transactionListAsyncvalue.when(data: (transaction) {
                      if (transaction.isEmpty) {
                        return const Center(
                          child: Text('Pasd'),
                        );
                      }
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transaction.length,
                          itemBuilder: (ctx, index) {
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
                                                transaction[index]
                                                    .date
                                                    .toIso8601String());
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
                        child: CircularProgressIndicator(),
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
