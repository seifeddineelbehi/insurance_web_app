import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/viewModel/add_admin_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../viewModel/login_view_model.dart';
import '../main/main_screen.dart';
import 'components/custom_radio_button.dart';

class AddAdmin extends StatefulWidget {
  static const String id = 'add_admin';
  static const path = '/home/ajout_Administrateur';

  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Ajouter Administrateur',
      color: Colors.blue,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth / 8),
          child: const Center(child: AddAdminBody()),
        ),
      ),
    );
  }
}

class AddAdminBody extends StatefulWidget {
  const AddAdminBody({Key? key}) : super(key: key);

  @override
  _AddAdminBodyState createState() => _AddAdminBodyState();
}

class _AddAdminBodyState extends State<AddAdminBody> {
  final _formKey = GlobalKey<FormState>();
  final AdminModel _admin = AdminModel();
  String? _role = '';
  String? _status = '';

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
              "Créer un nouveau Administrateur ",
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
                return "Entrer un nom";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('password : ' + value.toString());
                _admin.username = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter un nom',
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
                return "Entrer un mot de passe";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('password : ' + value.toString());
                _admin.password = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter un mot de passe',
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
          if (!Responsive.isMobile(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choisir le role de l'administrateur",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: ListTile(
                    title: const Text(
                      'Super administrateur',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio(
                      value: 'Super admin',
                      groupValue: _role,
                      onChanged: (value) {
                        setState(() {
                          log('role : ' + value.toString());
                          _role = value as String?;
                          _admin.role = "Super admin";
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: ListTile(
                    title: const Text(
                      'Administrateur',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio(
                      value: 'Admin',
                      groupValue: _role,
                      onChanged: (value) {
                        setState(() {
                          log('role : ' + value.toString());
                          _role = value as String?;
                          _admin.role = "Admin";
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          if (Responsive.isMobile(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choisir le role de l'administrateur",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  child: ListTile(
                    title: const Expanded(
                      child: Text(
                        'Super administrateur',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: Radio(
                      value: 'Super admin',
                      groupValue: _role,
                      onChanged: (value) {
                        setState(() {
                          _role = value as String?;
                          _admin.role = "Super admin";
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  child: ListTile(
                    title: const Expanded(
                      child: Text(
                        'Administrateur',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: Radio(
                      value: 'Admin',
                      groupValue: _role,
                      onChanged: (value) {
                        setState(() {
                          _role = value as String?;
                          _admin.role = "Admin";
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 30),
          if (!Responsive.isMobile(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choisir le t'etat de compte de l'administrateur",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: ListTile(
                    title: const Text(
                      'Activé',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio(
                      value: 'Active',
                      groupValue: _status,
                      onChanged: (value) {
                        setState(() {
                          log('status value : ' + value.toString());
                          _status = value as String?;
                          _admin.status = 'Active';
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  child: ListTile(
                    title: const Text(
                      'Désactivé',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio(
                      value: 'Unactive',
                      groupValue: _status,
                      onChanged: (value) {
                        setState(() {
                          log('status value : ' + value.toString());
                          _status = value as String?;
                          _admin.status = 'Unactivé';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          if (Responsive.isMobile(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choisir le t'etat de compte de l'administrateur",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  child: ListTile(
                    title: const Text(
                      'Activé',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio<String>(
                      value: 'Active',
                      groupValue: _status,
                      onChanged: (value) {
                        setState(() {
                          log('status value : ' + value.toString());
                          _status = value;
                          _admin.status = 'Active';
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  child: ListTile(
                    title: const Text(
                      'Désactivé',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Radio(
                      value: 'Unactive',
                      groupValue: _status,
                      onChanged: (value) {
                        setState(() {
                          log('status value : ' + value.toString());
                          _status = value as String?;
                          _admin.status = 'Unactivé';
                        });
                      },
                    ),
                  ),
                ),
              ],
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
                  _admin.status = _status.toString();
                  _admin.role = _role.toString();
                  log('admin value : ' + _admin.status.toString());
                  var response =
                      await context.read<AddAdminViewModel>().AddAdmin(_admin);
                  if (response == true) {
                    context.beamBack();
                  } else {
                    if (response == "Admin existe") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cet utilisateur existe deja')),
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
