import 'dart:developer';
import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/viewModel/incendie_view_model.dart';
import 'package:flutter_template/views/pages/Incendies/components/custom__detail_incendie_widget.dart';
import 'package:flutter_template/views/pages/Incendies/components/image_incendie_widget.dart';
import 'package:provider/provider.dart';

import '../../../model/client_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../viewModel/clients_screen_view_model.dart';
import '../Clients/detail_client.dart';

class DetailIncendie extends StatefulWidget {
  static const path = "/incendie/detail_incendie";
  const DetailIncendie({Key? key, required this.incendie, required this.id})
      : super(key: key);
  final IncendiesModel incendie;
  final String id;
  @override
  _DetailIncendieState createState() => _DetailIncendieState();
}

class _DetailIncendieState extends State<DetailIncendie> {
  late ClientModel client;

  _fetchClient() async {
    client = await context
        .read<ClientsViewModel>()
        .getClientDetailByCodeClient(widget.incendie.codeClient!);

    log('client ref assurance = ' + client.refAssurance!);
  }

  @override
  void initState() {
    //_fetchClient();
    log('message');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: Responsive.isMobile(context)
              ? const EdgeInsets.fromLTRB(defaultPadding * 2, defaultPadding,
                  defaultPadding * 2, defaultPadding)
              : const EdgeInsets.fromLTRB(defaultPadding * 12,
                  defaultPadding * 7, defaultPadding * 12, defaultPadding * 7),
          child: Container(
              padding: const EdgeInsets.all(defaultPadding * 6),
              decoration: const BoxDecoration(
                color: kPageColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Déclaration de Vols ",
                        style: kBigTitleBlackBold.copyWith(
                            color: Colors.blueGrey)),
                    const Divider(
                      thickness: 5,
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.7,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () async {
                                    await _fetchClient();
                                    log('GestureDetector :  ' +
                                        client.refAssurance!);
                                    context.beamToNamed(
                                        DetailClient.path + "/" + client.id!,
                                        data: client,
                                        beamBackOnPop: true,
                                        popBeamLocationOnPop: true,
                                        replaceRouteInformation: true);
                                  },
                                  child: CustomDetailIncendieWidget(
                                      title: "Client : ",
                                      text: widget.incendie.codeClient!),
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  flex: 3,
                                  child: CustomDetailIncendieWidget(
                                      title: "Date : ",
                                      text: widget.incendie.date!),
                                ),
                            ],
                          ),
                          if (Responsive.isMobile(context))
                            const SizedBox(
                              width: defaultPadding,
                            ),
                          if (Responsive.isMobile(context))
                            CustomDetailIncendieWidget(
                                title: "Date : ", text: widget.incendie.date!),
                          CustomDetailIncendieWidget(
                              title: "Observation : ",
                              text: widget.incendie.observation!),
                          CustomIncendieImage(image: widget.incendie.image!),
                          if (widget.incendie.status! ==
                              "En cours de traitement")
                            const SizedBox(height: defaultPadding),
                          if (widget.incendie.status! ==
                              "En cours de traitement")
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
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "Marquer comme terminé",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: kMediumTitleWhiteBold,
                                          ))),
                                      onPressed: () async {
                                        if (await confirm(
                                          context,
                                          title: const Text(
                                              'Marquer constat comme terminé'),
                                          content: const Text(
                                              'Vous êtes sur de valider ce constat?'),
                                          textOK: const Text('Oui'),
                                          textCancel: const Text('Annuler'),
                                        )) {
                                          var res = await context
                                              .read<IncendiesViewModel>()
                                              .update(widget.incendie.id!,
                                                  "Traité");

                                          log("res : " + res.toString());
                                          if (res == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Constat modifier avec succés ! ')),
                                            );
                                            context.beamBack();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Erreur de validation de constat ! ')),
                                            );
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: kTraiteColor,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: defaultPadding),
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
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "Rejeter",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: kMediumTitleWhiteBold,
                                          ))),
                                      onPressed: () async {
                                        if (await confirm(
                                          context,
                                          title: const Text('Rejet du constat'),
                                          content: const Text(
                                              'Vous êtes sur de rejeter ce constat?'),
                                          textOK: const Text('Oui'),
                                          textCancel: const Text('Annuler'),
                                        )) {
                                          var res = await context
                                              .read<IncendiesViewModel>()
                                              .update(widget.incendie.id!,
                                                  "Rejeté");

                                          log("res : " + res.toString());
                                          if (res == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Constat modifier avec succés ! ')),
                                            );
                                            context.beamBack();
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: kRejeteColor,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
