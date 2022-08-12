import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/constat_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../../viewModel/home_view_model.dart';
import '../../Constats/details_constat_screen.dart';

DataRow listConstatClientDataRow(ConstatModel constat, BuildContext context) {
  final Nomclient1 = constat.vehiculeA?.nomAssure.toString();
  final Prenomclient1 = constat.vehiculeA?.prenomAssure.toString();
  final Nomclient2 = constat.vehiculeB?.nomAssure.toString();
  final Prenomclient2 = constat.vehiculeB?.prenomAssure.toString();
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${constat.temoins!.isEmpty.toString()}');
        context.beamToNamed(DetailsConstat.path + "/" + constat.id!,
            data: constat);
      }
    },
    cells: [
      DataCell(
        Text(
          '$Nomclient1' + ' ' + '$Prenomclient1',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(
        Text(
          '$Nomclient2' + ' ' + '$Prenomclient2',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(Text(
        constat.dateAccident!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      )),
      constat.status! != "En cours de traitement"
          ? DataCell(
              Container(
                child: Text(
                  constat.status!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPageColor,
                  ),
                ),
                height: 30,
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: constat.status! == "En cours de traitement"
                      ? Colors.blue
                      : constat.status! == "Traité"
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          : DataCell(
              Container(
                padding: const EdgeInsets.all(defaultPadding * 0.7),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.beamToNamed(
                              DetailsConstat.path + "/" + constat.id!,
                              data: constat);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: defaultPadding * 0.4,
                              right: defaultPadding * 0.4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFA113),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(
                            Icons.remove_red_eye,
                            size: defaultPadding * 1.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (await confirm(context)) {
                            var res = await context
                                .read<HomeViewModel>()
                                .updateConstat(constat.id!, "Traité");
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Constat modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Erreur de validation de constat ! ')),
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: defaultPadding * 0.4,
                              right: defaultPadding * 0.4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: const BoxDecoration(
                            color: Color(0xFF66F601),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: defaultPadding * 1.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (await confirm(context)) {
                            var res = await context
                                .read<HomeViewModel>()
                                .updateConstat(constat.id!, "Rejeté");
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Constat modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Erreur de validation de constat ! ')),
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: defaultPadding * 0.4,
                              right: defaultPadding * 0.4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF040C),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: defaultPadding * 1.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ],
  );
}
