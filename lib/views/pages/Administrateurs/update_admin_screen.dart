import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/viewModel/add_admin_view_model.dart';
import 'package:flutter_template/views/pages/Administrateurs/AdminScreenDetails.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../viewModel/login_view_model.dart';
import '../main/main_screen.dart';
import 'components/custom_radio_button.dart';

class UpdateAdmin extends StatefulWidget {
  static const String id = 'add_admin';
  static const path = '/Admin/modifier_Administrateur';
  final String AdminId;
  final AdminModel admin;

  const UpdateAdmin({Key? key, required this.admin, required this.AdminId})
      : super(key: key);

  @override
  _UpdateAdminState createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateAdmin> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Modifier Administrateur',
      color: Colors.blue,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: UpdateAdminBody(
            admin: widget.admin,
          )),
        ),
      ),
    );
  }
}

class UpdateAdminBody extends StatefulWidget {
  const UpdateAdminBody({Key? key, required this.admin}) : super(key: key);
  final AdminModel admin;
  @override
  _UpdateAdminBodyState createState() => _UpdateAdminBodyState();
}

class _UpdateAdminBodyState extends State<UpdateAdminBody> {
  final _formKey = GlobalKey<FormState>();
  late final AdminModel _admin;
  String? _role = 'Admin';
  String? _status = 'Active';
  @override
  void initState() {
    _admin = widget.admin;
    _role = widget.admin.role!;
    _status = widget.admin.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kPageColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Modifier un Administrateur ",
              style: kBigTitleBlackBold.copyWith(color: Colors.blueGrey)),
          const Divider(
            thickness: 5,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: _formAdd(context, _admin),
          ),
        ],
      ),
    );
  }

  Widget _formAdd(BuildContext context, AdminModel admin) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: _admin.username,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrer un nom";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                log('username : ' + value.toString());
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
            onSaved: (value) {
              if (value != null && value.isNotEmpty) {
                setState(() {
                  log('password : ' + value.toString());
                  _admin.password = value.toString();
                });
              }
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
          Row(
            children: [
              Flexible(
                child: Container(
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
                        child: Center(child: Text("Modifier"))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _admin.status = _status.toString();
                        _admin.role = _role.toString();
                        log('admin value : ' + _admin.password.toString());
                        var response = await context
                            .read<AddAdminViewModel>()
                            .UpdateAdmin(_admin);
                        if (response.toString() == 'true') {
                          await context
                              .read<LoginViewModel>()
                              .getUserInformation();
                          context.beamBack();
                        } else {
                          if (response.toString() == "erreur") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Erreur de modification')),
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
              ),
              Flexible(
                child: Container(
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
                        child: Center(child: Text("Annuler"))),
                    onPressed: () {
                      context.beamBack();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
