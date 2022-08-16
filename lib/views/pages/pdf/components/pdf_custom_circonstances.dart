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
      decoration: BoxDecoration(
        color: const PdfColor.fromInt(0xFFFFFFFF),
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
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 0.5,
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
                            Icon(
                              IconData(mt.Icons.check_box.codePoint),
                              color: const PdfColor.fromInt(0xFFFFFF54),
                            ),
                          Expanded(
                            child: Center(
                              child: Text(
                                (Circonstances.indexOf(item) + 1).toString() +
                                    "-" +
                                    item.toString(),
                                style: TextStyle(
                                  color: const PdfColor.fromInt(0xFF333333),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (constat.vehiculeB!.circonstances!
                              .contains(item.toString()))
                            Icon(
                              IconData(mt.Icons.check_box.codePoint),
                              color: const PdfColor.fromInt(0xFF52CE6E),
                            ),
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
