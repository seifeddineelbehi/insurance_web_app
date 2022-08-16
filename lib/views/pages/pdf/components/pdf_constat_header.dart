import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Constats/components/custom_constat_header_detail_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/temoin_info_card.dart';
import 'package:printing/printing.dart';
import '../../../../model/MyFiles.dart';
import '../../../../model/temoin_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/responsive.dart';

Widget PDFHeader(ConstatModel constat) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: PDFCustomHeaderDetailWidget(
                  title: 'Date de l\'accident',
                  text: constat.dateAccident.toString()),
            ),
            Expanded(
              flex: 2,
              child: PDFCustomHeaderDetailWidget(
                  title: 'Heure', text: constat.heureAccident.toString()),
            ),
            Expanded(
              flex: 2,
              child: PDFCustomHeaderDetailWidget(
                  title: 'Lieu', text: constat.lieuAccident.toString()),
            ),
            Expanded(
              flex: 2,
              child: PDFCustomHeaderDetailWidget(
                  title: 'Blessés même leger', text: constat.blesse.toString()),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: PDFCustomHeaderDetailWidget(
                  title: 'Dégats materiels',
                  text: constat.degatMateriel.toString()),
            ),
            Expanded(
              flex: 4,
              child: PDFCustomTemoinsHeaderDetailWidget(
                  title: 'Temoins', temoins: constat.temoins!),
            ),
          ],
        )
      ],
    ),
  );
}

Widget PDFCustomHeaderDetailWidget(
    {required String title, required String text}) {
  return Container(
    //width: SizeConfig.safeBlockHorizontal,
    decoration: BoxDecoration(
      color: const PdfColor.fromInt(0xFFFFFFFF), //white
      border: Border.all(
        color: const PdfColor.fromInt(0x8A000000), //black
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            style: TextStyle(
                color: const PdfColor.fromInt(0xFF333333),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          Text(
            text,
            maxLines: 1,
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 11),
          ),
        ],
      ),
    ),
  );
}

Widget PDFCustomTemoinsHeaderDetailWidget(
    {required List<TemoinModel> temoins, required String title}) {
  return Container(
    //width: SizeConfig.safeBlockHorizontal,
    decoration: BoxDecoration(
      color: const PdfColor.fromInt(0xFFFFFFFF),
      border: Border.all(
        color: const PdfColor.fromInt(0x8A000000),
      ),
    ),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  //width: SizeConfig.safeBlockHorizontal * 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: const PdfColor.fromInt(0xFF333333),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      if (temoins.isEmpty)
                        Text(
                          "Pas de temoins",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: const PdfColor.fromInt(0xFF333333),
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        )
                      else
                        for (var item in temoins) itemTemoin(item),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
  );
}

Widget itemTemoin(TemoinModel temoin) {
  return Text(
    temoin.nom.toString() +
        " " +
        temoin.adress.toString() +
        " " +
        temoin.tel.toString() +
        " " +
        temoin.appartenance.toString(),
    style: TextStyle(
      color: const PdfColor.fromInt(0xFFC1C1C1),
      fontWeight: FontWeight.bold,
    ),
  );
}
