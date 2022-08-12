import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/Services/client_service.dart';
import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/viewModel/brise_view_model.dart';
import 'package:flutter_template/viewModel/clients_screen_view_model.dart';
import 'package:flutter_template/views/pages/BriseGlace/components/custom__detail_brise_widget.dart';
import 'package:flutter_template/views/pages/BriseGlace/components/image_brise_widget.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../Clients/detail_client.dart';

class DetailsBriseGlace extends StatefulWidget {
  static const path = "/brise/detail_brise_glasse";
  const DetailsBriseGlace({Key? key, required this.brise, required this.id})
      : super(key: key);
  final BriseGlaceModel brise;
  final String id;
  @override
  _DetailsBriseGlaceState createState() => _DetailsBriseGlaceState();
}

class _DetailsBriseGlaceState extends State<DetailsBriseGlace> {
  late ClientModel client;

  _fetchClient() async {
    client = await context
        .read<ClientsViewModel>()
        .getClientDetailByCodeClient(widget.brise.codeClient!);

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
                    Text("Déclaration de Brise Glasse ",
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
                                        data: client);
                                  },
                                  child: CustomDetailBriseWidget(
                                      title: "Client : ",
                                      text: widget.brise.codeClient!),
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  flex: 3,
                                  child: CustomDetailBriseWidget(
                                      title: "Date : ",
                                      text: widget.brise.date!),
                                ),
                            ],
                          ),
                          if (Responsive.isMobile(context))
                            const SizedBox(
                              width: defaultPadding,
                            ),
                          if (Responsive.isMobile(context))
                            CustomDetailBriseWidget(
                                title: "Date : ", text: widget.brise.date!),
                          CustomBriseImage(image: widget.brise.image!),
                          if (widget.brise.status! == "En cours de traitement")
                            const SizedBox(height: defaultPadding),
                          if (widget.brise.status! == "En cours de traitement")
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
                                            "Marqué comme terminé",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: kMediumTitleWhiteBold,
                                          ))),
                                      onPressed: () async {
                                        if (await confirm(
                                          context,
                                          title: const Text(
                                              'Marqué constat comme terminé'),
                                          content: const Text(
                                              'Vous êtes sur de valider ce constat?'),
                                          textOK: const Text('Oui'),
                                          textCancel: const Text('Annuler'),
                                        )) {
                                          var res = await context
                                              .read<BriseViewModel>()
                                              .updateBrise(
                                                  widget.brise.id!, "Traité");

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
                                            "Rejeté",
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
                                              .read<BriseViewModel>()
                                              .updateBrise(
                                                  widget.brise.id!, "Rejeté");

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
