import 'dart:developer';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_circonstances.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_croquis.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_vehicule_detail.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart';
import 'dart:convert';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../Constats/components/constat_header.dart';
import '../Constats/components/custom-vehicule_detail.dart';
import 'components/pdf_constat_header.dart';
import 'components/pdf_custom_assure_widget.dart';
import 'components/pdf_custom_degat.dart';
import 'components/pdf_custom_identite_conducteur_widget.dart';
import 'components/pdf_custom_observation.dart';
import 'components/pdf_custom_point_choc.dart';
import 'components/pdf_custom_signature.dart';
import 'components/pdf_identite_vehicule.dart';
import 'components/pdf_societe_assurance_widget.dart';

Future<void> PDFGeneration(ConstatModel constat) async {
  final pdf = Document();
  /*final imagePointChocVehiculeA =
      await networkImage(constat.vehiculeA!.pointChoc!);
  final imagePointChocVehiculeB =
      await networkImage(constat.vehiculeB!.pointChoc!);
  final imageSignatureVehiculeA =
      await networkImage(constat.vehiculeA!.signature!);
  final imageSignatureVehiculeB =
      await networkImage(constat.vehiculeB!.signature!);
  final imageCroquis = await networkImage(constat.croquis!);*/

  pdf.addPage(
    Page(
        theme: ThemeData.withFont(
          base: await PdfGoogleFonts.abhayaLibreRegular(),
          bold: await PdfGoogleFonts.abhayaLibreRegular(),
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        build: (Context context) => Column(children: [
              PDFHeader(constat),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  Container(
                    decoration: BoxDecoration(
                      color: const PdfColor.fromInt(0xFFFFFF54),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: const PdfColor.fromInt(0x8A000000)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Vehicule A',
                              style: TextStyle(
                                  color: const PdfColor.fromInt(0xFF607D8B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Divider(
                            thickness: 4,
                          ),
                          PDFSocieteAssurance(vehicule: constat.vehiculeA!),
                          PDFIdentiteConducteur(vehicule: constat.vehiculeA!),
                          PDFAssure(vehicule: constat.vehiculeA!),
                          PDFIdentiteVehicule(vehicule: constat.vehiculeA!),
                          //PDFCustomPointChoc(image: imagePointChocVehiculeA),
                          PDFCustomDegat(vehicule: constat.vehiculeA!),
                          PDFCustomObservation(vehicule: constat.vehiculeA!)
                        ]),
                  ),
                  /*Column(
                    children: [
                      PDFCustomCirconstances(constat: constat),
                      //PDFCustomCroquis(image: imageCroquis),
                    ],
                  ),*/
                  Container(
                    decoration: BoxDecoration(
                      color: const PdfColor.fromInt(0xFF52CE6E),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: const PdfColor.fromInt(0x8A000000)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Vehicule B',
                              style: TextStyle(
                                color: const PdfColor.fromInt(0xFF607D8B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 4,
                          ),
                          ListView(
                            children: [
                              PDFSocieteAssurance(vehicule: constat.vehiculeB!),
                              PDFIdentiteConducteur(
                                  vehicule: constat.vehiculeB!),
                              PDFAssure(vehicule: constat.vehiculeB!),
                              PDFIdentiteVehicule(vehicule: constat.vehiculeB!),
                              //PDFCustomPointChoc(image: imagePointChocVehiculeB),
                              PDFCustomDegat(vehicule: constat.vehiculeB!),
                              PDFCustomObservation(
                                  vehicule: constat.vehiculeB!),
                              //PDFCustomSignature( image: imageSignatureVehiculeB),
                            ],
                          )
                        ]),
                  ),
                ],
              ),
              //const SizedBox(height: defaultPadding),
            ]),
        pageFormat: PdfPageFormat.a4),
  );
  AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(await pdf.save())}")
    ..setAttribute("download", "example.pdf")
    ..click();

  //final dir = (await getApplicationDocumentsDirectory()).path;
  //final file = File("example.pdf");
  //await file.writeAsBytes(await pdf.save(), flush: true);
  // log('path ' + file.path);
}
