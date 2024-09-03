import 'package:depense_track/model/categorie.dart';
import 'package:depense_track/model/depense.dart';
import 'package:depense_track/model/revenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> list = <String>['Une dépense', ' Un revenu'];

class AddDepenseScreen extends StatefulWidget {
  const AddDepenseScreen(
      {required this.addnewdepense, required this.addNewRevenu, super.key});
  final Function(DepenseModel) addnewdepense;
  final Function(Revenu) addNewRevenu;

  @override
  State<AddDepenseScreen> createState() => _AddDepenseScreenState();
}

class _AddDepenseScreenState extends State<AddDepenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String titreDepense = '';
  double montantDepense = 0;
  DateTime? datechoisir;
  Color? backIconCouleurSelect;
  String dropdownValue = list.first;
  Categorie? _selectedCategory;
  void activePicker() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2070),
      initialDate: DateTime.now(),
    );
    setState(() {
      datechoisir = date;
    });
  }

  void submit() {
    final validerForm = _formKey.currentState!.validate();

    if (validerForm) {
      //verification de la selection de la categorie de depense
      if (_selectedCategory == null && list[0] != 'Une dépense') {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text(
                  "Erreur",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                content: const Text(
                  'Veulliez selectionnez une categorie de depense !',
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              );
            });
        return;
      }
      if (datechoisir == null) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text(
                  "Date non precisé",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                content: const Text(
                  'Ajouter la date',
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              );
            });
        return;
      }

      _formKey.currentState!.save();
      if (validerForm) {
        if (dropdownValue == list[0]) {
          //ici j'ai fai un contructeur tres compliquer
          widget.addnewdepense(DepenseModel(
              titre: titreDepense,
              montant: montantDepense,
              date: datechoisir!,
              categorie: Categorie(
                  nom: _selectedCategory!.nom,
                  icon: _selectedCategory!.icon,
                  couleurBack: backIconCouleurSelect!)));
        } else if (dropdownValue == list[1]) {
          //Ici c'est la meilleur solution
          widget.addNewRevenu(
            Revenu(
              montant: montantDepense,
              description: titreDepense,
              date: datechoisir!,
              iconRevenu: const Icon(Icons.monetization_on_outlined),
            ),
          );
        }
      }
      Navigator.of(context).pop();
    }
  }

  final List<Categorie> _categories = [
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 6,
              width: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 95, 92, 92),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ajouter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 1,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 0, 140, 255),
                              size: 35,
                            ),
                            underline: Container(),
                            borderRadius: BorderRadius.circular(10),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                print(dropdownValue);
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (dropdownValue == list[0])
                    Center(
                      child: DropdownButtonFormField<Categorie>(
                        value: _selectedCategory,
                        hint: const Text(
                          'Sélectionnez une catégorie',
                          style: TextStyle(
                              color: Color.fromARGB(255, 33, 33, 33),
                              fontSize: 16),
                        ),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.blue, size: 24),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                        isExpanded: true,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        items: _categories.map<DropdownMenuItem<Categorie>>(
                            (Categorie value) {
                          return DropdownMenuItem<Categorie>(
                            value: value,
                            child: Row(
                              children: [
                                value.icon,
                                // You can customize this icon
                                const SizedBox(width: 8),
                                Text(value.nom),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Categorie? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                            backIconCouleurSelect = newValue!.couleurBack;
                          });
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      label: const Text(
                        'Montant',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 220, 166, 39),
                            fontWeight: FontWeight.w600),
                      ),
                      labelStyle: const TextStyle(fontSize: 14),
                      prefixText: "Montant ",
                      prefixStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 220, 166, 39),
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (valeur) {
                      if (valeur == null || valeur.trim().isEmpty) {
                        return 'SVP entrer une somme valide';
                      }
                      return null;
                    },
                    onSaved: (valeur) {
                      if (valeur != null && valeur.isNotEmpty) {
                        try {
                          montantDepense = double.parse(valeur);
                        } catch (e) {
                          print("Erreur de converion : $e");
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      label: const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 220, 166, 39),
                            fontWeight: FontWeight.w600),
                      ),
                      labelStyle: const TextStyle(fontSize: 14),
                      prefixText: "Description ",
                      prefixStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 220, 166, 39),
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (valeur) {
                      if (valeur == null || valeur.trim().isEmpty) {
                        return 'SVP entrer une description valide';
                      }
                      return null;
                    },
                    onSaved: (valeur) {
                      if (valeur != null && valeur.isNotEmpty) {
                        try {
                          titreDepense = valeur.trim();
                        } catch (e) {
                          print("Erreur de converion : $e");
                        }
                      }
                    },
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: activePicker,
                      child: datechoisir != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Date  : ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 244, 144, 14)),
                                ),
                                Text(
                                  DateFormat.yMMMd('fr_FR')
                                      .format(datechoisir!),
                                  style: datechoisir != null
                                      ? const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                        )
                                      : const TextStyle(
                                          color: Colors.red, fontSize: 14),
                                ),
                              ],
                            )
                          : const Text('Ajouter date de la dépense'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              onPressed: submit,
              child: const Text('Valider Maintenants'),
            ),
          ),
        ],
      ),
    );
  }
}
