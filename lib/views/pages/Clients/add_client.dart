import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/viewModel/clients_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../model/client_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';

class AddClient extends StatefulWidget {
  static const String id = 'add_client';
  static const path = '/home/ajout_Client';
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Ajouter Client',
      color: Colors.blue,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth / 8),
          child: const Center(child: AddClientBody()),
        ),
      ),
    );
  }
}

class AddClientBody extends StatefulWidget {
  const AddClientBody({Key? key}) : super(key: key);

  @override
  _AddClientBodyState createState() => _AddClientBodyState();
}

class _AddClientBodyState extends State<AddClientBody> {
  final _formKey = GlobalKey<FormState>();
  final ClientModel _client = ClientModel();
  ClientDataModel _clientData = ClientDataModel();
  late final String _refAssurance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: kPageColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Créer un nouveau Client ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Divider(
              thickness: 5,
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              child: _formAdd(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formAdd(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrer la reference client";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('password : ' + value.toString());
                _refAssurance = value!;
                setState(() {
                  _client.refAssurance = value;
                });
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter la reference client',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrer un email";
              }
              if (!value.contains("@")) {
                return "Please enter a valid Email";
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                log('email : ' + value.toString());
                _client.email = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter un email',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrer un pseude pour le client";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('pseude : ' + value.toString());
                _client.username = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter un pseudo pour le client',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrer un mot de passe pour le client";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('password : ' + value.toString());
                _client.password = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter un mot de passe pour le client',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple[100]!,
                  spreadRadius: 10,
                  blurRadius: 15,
                ),
              ],
            ),
            child: ElevatedButton(
              child: const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Ajouter"))),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _client.refAssurance = _refAssurance;
                  var response =
                      await context.read<ClientsViewModel>().AddClient(_client);
                  if (response == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Client créer avec succés !!')),
                    );
                    context.beamBack();
                  } else {
                    if (response == "User already exist") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Ce client existe deja !')),
                      );
                    }
                    if (response == "username already exist") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Ce client existe deja !')),
                      );
                    }
                    if (response == "code Client already exist") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Ce client existe deja !')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Une erreur s\'est produite!')),
                      );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
