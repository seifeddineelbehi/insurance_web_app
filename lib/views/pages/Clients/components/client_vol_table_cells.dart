import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Vols/vol_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../model/vol_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../../viewModel/vol_view_model.dart';
import '../../Constats/details_constat_screen.dart';

DataRow ClientVolDataRow(
    VolModel vol, BuildContext context, List<VolModel> list) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        context.beamToNamed(DetailVol.path + "/" + vol.id!, data: vol);
      }
    },
    cells: [
      DataCell(Text(
        vol.date!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      )),
      DataCell(
        Text(
          'Nouvelle declaration de vol de la part du client ' + vol.codeClient!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      vol.status! == "En cours de traitement"
          ? DataCell(
              Container(
                child: Text(
                  vol.status!,
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
                  color: vol.status! == "En cours de traitement"
                      ? Colors.blue
                      : vol.status! == "Traité"
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
                          context.beamToNamed(DetailVol.path + "/" + vol.id!,
                              data: vol);
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
                                .read<VolViewModel>()
                                .updateVol(vol.id!, "Traité");
                            list.removeAt(list.indexOf(vol));
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Declaration de vol modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Erreur de validation de Vol ! ')),
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
                                .read<VolViewModel>()
                                .updateVol(vol.id!, "Rejeté");
                            list.removeAt(list.indexOf(vol));
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Vol modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Erreur de validation de Vol ! ')),
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
