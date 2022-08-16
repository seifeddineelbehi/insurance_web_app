import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/views/pages/Constats/components/constat_header.dart';
import 'package:flutter_template/views/pages/Constats/components/croquis_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/custom-vehicule_detail.dart';
import 'package:flutter_template/views/pages/Constats/components/custom_circonstances.dart';
import 'package:flutter_template/views/pages/pdf/pdf_generation.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../viewModel/home_view_model.dart';

class DetailsConstat extends StatefulWidget {
  static const path = "/home/detailConstat";
  final String ConstatId;
  final ConstatModel constat;
  const DetailsConstat(
      {Key? key, required this.ConstatId, required this.constat})
      : super(key: key);

  @override
  _DetailsConstatState createState() => _DetailsConstatState();
}

class _DetailsConstatState extends State<DetailsConstat> {
  @override
  void initState() {
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
            child: Column(
              children: [
                if (widget.constat.status! == "En cours de traitement")
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
                              PDFGeneration(widget.constat);
                              if (await confirm(
                                context,
                                title:
                                    const Text('Marquer constat comme terminé'),
                                content: const Text(
                                    'Vous êtes sur de valider ce constat?'),
                                textOK: const Text('Oui'),
                                textCancel: const Text('Annuler'),
                              )) {
                                var res = await context
                                    .read<HomeViewModel>()
                                    .updateConstat(
                                        widget.constat.id!, "Traité");

                                log("res : " + res.toString());
                                if (res == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Constat modifier avec succés ! ')),
                                  );
                                  context.beamBack();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                borderRadius: BorderRadius.circular(15),
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
                                    .read<HomeViewModel>()
                                    .updateConstat(
                                        widget.constat.id!, "Rejeté");

                                log("res : " + res.toString());
                                if (res == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget.constat.status! == "En cours de traitement")
                  const SizedBox(height: defaultPadding),
                constatHeader(constat: widget.constat),
                //const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          //const MyFiles(),
                          const SizedBox(height: defaultPadding),
                          CustumVehiculedetails(
                            vehicule: widget.constat.vehiculeA!,
                            nomVehicule: 'Vehicule A',
                            color: kVehiculeAColor,
                          ),
                          if (!Responsive.isDesktop(context))
                            const SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context))
                            Container(
                              padding: const EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: cardDetailConstatBorderThikness,
                                    color: Colors.grey),
                              ),
                              child: Column(
                                children: [
                                  CustomCirconstance(
                                      vehiculeA: widget.constat.vehiculeA!,
                                      vehiculeB: widget.constat.vehiculeB!),
                                  CustomCroquis(
                                      croquis:
                                          widget.constat.croquis.toString()),
                                ],
                              ),
                            ),
                          if (!Responsive.isDesktop(context))
                            const SizedBox(height: defaultPadding),
                          if (!Responsive.isDesktop(context))
                            CustumVehiculedetails(
                              vehicule: widget.constat.vehiculeB!,
                              nomVehicule: 'Vehicule B',
                              color: kVehiculeBColor,
                            ),
                        ],
                      ),
                    ),
                    if (Responsive.isDesktop(context))
                      const SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    if (Responsive.isDesktop(context))
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                width: cardDetailConstatBorderThikness,
                                color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              CustomCirconstance(
                                  vehiculeA: widget.constat.vehiculeA!,
                                  vehiculeB: widget.constat.vehiculeB!),
                              CustomCroquis(
                                  croquis: widget.constat.croquis.toString()),
                            ],
                          ),
                        ),
                      ),
                    if (Responsive.isDesktop(context))
                      const SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    if (Responsive.isDesktop(context))
                      Flexible(
                        child: CustumVehiculedetails(
                          vehicule: widget.constat.vehiculeB!,
                          nomVehicule: 'Vehicule B',
                          color: kVehiculeBColor,
                        ),
                      ),
                  ],
                ),
                if (widget.constat.status! == "En cours de traitement")
                  const SizedBox(height: defaultPadding),
                if (widget.constat.status! == "En cours de traitement")
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
                                title:
                                    const Text('Marquer constat comme terminé'),
                                content: const Text(
                                    'Vous êtes sur de valider ce constat?'),
                                textOK: const Text('Oui'),
                                textCancel: const Text('Annuler'),
                              )) {
                                var res = await context
                                    .read<HomeViewModel>()
                                    .updateConstat(
                                        widget.constat.id!, "Traité");

                                log("res : " + res.toString());
                                if (res == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Constat modifier avec succés ! ')),
                                  );
                                  context.beamBack();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                borderRadius: BorderRadius.circular(15),
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
                                    .read<HomeViewModel>()
                                    .updateConstat(
                                        widget.constat.id!, "Rejeté");

                                log("res : " + res.toString());
                                if (res == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
          ),
        ),
      ),
    );
  }
}

Widget body(ConstatModel constat) {
  return Column(children: [
    ConstatInfoCardGridView(
      childAspectRatio: SizeConfig.screenWidth < 1400 ? 1.1 : 1.4,
      constat: constat,
    ),
    //const SizedBox(height: defaultPadding),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: CustumVehiculedetails(
            vehicule: constat.vehiculeA!,
            nomVehicule: 'Vehicule A',
            color: kVehiculeAColor,
          ),
        ),
        // On Mobile means if the screen is less than 850 we dont want to show it
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CustomCirconstance(
                  vehiculeA: constat.vehiculeA!, vehiculeB: constat.vehiculeB!),
              CustomCroquis(croquis: constat.croquis.toString()),
            ],
          ),
        ),
        // On Mobile means if the screen is less than 850 we dont want to show it
        Expanded(
          flex: 2,
          child: CustumVehiculedetails(
            vehicule: constat.vehiculeB!,
            nomVehicule: 'Vehicule B',
            color: kVehiculeBColor,
          ),
        ),
      ],
    ),
  ]);
}
