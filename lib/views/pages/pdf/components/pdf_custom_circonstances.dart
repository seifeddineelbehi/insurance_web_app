import 'package:flutter_template/model/constat_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;
import '../../../../data/circonstance.dart';
import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

Widget PDFCustomCirconstances({required ConstatModel constat}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Observation',
            style: TextStyle(
                color: const PdfColor.fromInt(0xFF333333),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          ListView(
            children: [
              for (var item in Circonstances)
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (constat.vehiculeA!.circonstances!
                              .contains(item.toString()))
                            Icon(IconData(mt.Icons.check_box.codePoint),
                                color: const PdfColor.fromInt(0xFFFFFF54),
                                font: Font.helvetica()),
                          Expanded(
                            child: Center(
                              child: Text(
                                (Circonstances.indexOf(item) + 1).toString() +
                                    "-" +
                                    item.toString(),
                                style: TextStyle(
                                    color: const PdfColor.fromInt(0xFF333333),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          if (constat.vehiculeB!.circonstances!
                              .contains(item.toString()))
                            Icon(IconData(mt.Icons.check_box.codePoint),
                                color: const PdfColor.fromInt(0xFF52CE6E),
                                font: Font.helvetica()),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    ),
  );
}
