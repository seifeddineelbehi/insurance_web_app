import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../../viewModel/incendie_view_model.dart';
import '../../Constats/details_constat_screen.dart';

DataRow ClientIncendiesDataRow(
    IncendiesModel vol, BuildContext context, List<IncendiesModel> list) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        context.beamToNamed(DetailIncendie.path + "/" + vol.id!, data: vol);
      }
    },
    cells: [
      DataCell(SelectableText(
        vol.date!,
        maxLines: 1,
        //overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      )),
      DataCell(
        Text(
          'Nouvelle declaration d\'incendie de la part du client ' +
              vol.codeClient!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      vol.status! != "En cours de traitement"
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
                          context.beamToNamed(
                              DetailIncendie.path + "/" + vol.id!,
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
                                .read<IncendiesViewModel>()
                                .update(vol.id!, "Traité");
                            list.removeAt(list.indexOf(vol));
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Declaration de l\'incendie modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Erreur de validation de l\'incendie  ! ')),
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
                                .read<IncendiesViewModel>()
                                .update(vol.id!, "Rejeté");
                            list.removeAt(list.indexOf(vol));
                            log("res : " + res.toString());
                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Incendie  modifier avec succés ! ')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Erreur de validation de l\'incendie  ! ')),
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
