import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var creation = true;
  void creerCompte() {
    setState(() {
      creation = !creation;
    });
  }

  void submit() {
    Navigator.of(context).pushNamed('Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              if (!creation)
                Center(
                  child: Image.asset(
                    'image/intro.jpg',
                    width: 300,
                    height: 300,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (!creation)
                const Text(
                  'Bienvenu a depense Trancking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              const SizedBox(
                height: 10,
              ),
              if (!creation)
                const Text(
                  'Suivez vos depenses et vos revenus en un seul click',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              SizedBox(
                height: !creation ? 0 : 16,
              ),
              Form(
                child: Column(
                  children: [
                    if (creation)
                      const Center(
                        child: Text(
                          'Creation du compte',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),
                    ////////////// Nom Pour Inscription/////
                    if (creation)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          label: const Text('Nom & Prenom'),
                          labelStyle: const TextStyle(fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 229, 172, 0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (valeur) {
                          if (valeur == null ||
                              valeur.trim().isEmpty ||
                              !valeur.contains('@')) {
                            return 'SVP entrer une address valide';
                          }
                          return null;
                        },
                        onSaved: (valeur) {},
                      ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),
                    ////////////// job Pour Inscription/////
                    if (creation)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                            label: const Text('Job'),
                            labelStyle: const TextStyle(fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.work,
                              color: Color.fromARGB(255, 229, 172, 0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (valeur) {
                          if (valeur == null ||
                              valeur.trim().isEmpty ||
                              !valeur.contains('@')) {
                            return 'SVP entrer une address valide';
                          }
                          return null;
                        },
                        onSaved: (valeur) {},
                      ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),
                    ////////////// telephone Pour Inscription/////
                    if (creation)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                            label: const Text('Numero'),
                            labelStyle: const TextStyle(fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Color.fromARGB(255, 229, 172, 0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (valeur) {
                          if (valeur == null ||
                              valeur.trim().isEmpty ||
                              !valeur.contains('@')) {
                            return 'SVP entrer une address valide';
                          }
                          return null;
                        },
                        onSaved: (valeur) {},
                      ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          labelStyle: const TextStyle(fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 229, 172, 0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (valeur) {
                        if (valeur == null ||
                            valeur.trim().isEmpty ||
                            !valeur.contains('@')) {
                          return 'SVP entrer une address valide';
                        }
                        return null;
                      },
                      onSaved: (valeur) {},
                    ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                          label: const Text('Mot de Passe'),
                          labelStyle: const TextStyle(fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 229, 172, 0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (valeur) {
                        if (valeur == null ||
                            valeur.trim().isEmpty ||
                            !valeur.contains('@')) {
                          return 'SVP entrer une address valide';
                        }
                        return null;
                      },
                      onSaved: (valeur) {},
                    ),
                    SizedBox(
                      height: creation ? 20 : 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 200, 147, 0)),
                    child: Text(creation ? 'Mot de passe oublié' : ''),
                  ),
                  TextButton(
                    onPressed: creerCompte,
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 200, 147, 0)),
                    child:
                        Text(creation ? 'j ai un compte' : 'Creer un compte'),
                  )
                ],
              ),
              Center(
                  child: ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 45, right: 45, bottom: 10, top: 10),
                  elevation: 4,
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 240, 177, 2),
                ),
                child: Text(
                  creation ? 'crer un compte ' : 'Se Connecter',
                  style: const TextStyle(fontSize: 14),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
