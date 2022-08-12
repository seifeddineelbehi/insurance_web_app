import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/Services/constat_service.dart';
import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/model/vol_model.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/brise_view_model.dart';
import 'package:flutter_template/viewModel/incendie_view_model.dart';
import 'package:flutter_template/viewModel/vol_view_model.dart';
import 'package:flutter_template/views/pages/BriseGlace/brise_glace_screen.dart';
import 'package:flutter_template/views/pages/BriseGlace/detail_brise_screen.dart';
import 'package:flutter_template/views/pages/Constats/details_constat_screen.dart';
import 'package:flutter_template/views/pages/login/login_screen.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../../model/RecentFile.dart';
import '../../../../utils/constants.dart';
import '../../../../viewModel/admins_screen_view_model.dart';
import '../../../../viewModel/home_view_model.dart';

class BriseTable extends StatefulWidget {
  const BriseTable({Key? key}) : super(key: key);

  @override
  _BriseTableState createState() => _BriseTableState();
}

class _BriseTableState extends State<BriseTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<BriseGlaceModel> constatFiltered = [];
  List<BriseGlaceModel> AllConstats = [];

  @override
  Widget build(BuildContext context) {
    //final homeViewModel = Provider.of<HomeViewModel>(context);
    //final List<ConstatModel> allConstatNonTraite = homeViewModel.getAllConstatNonTraite() as List<ConstatModel>;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kPageColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Liste des vols recentes",
            style: kMediumTitleBlackBold.copyWith(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const Divider(
            thickness: 10,
          ),
          ListTile(
            title: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: kPageColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        color: const Color(0xFFFFA113),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset("assets/icons/Search.svg"),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    log('searche value :' + value);
                    _searchResult = value;
                    constatFiltered = AllConstats.where((vol) =>
                        vol.id!.contains(_searchResult) ||
                        vol.codeClient!.contains(_searchResult)).toList();
                    log('constatFiltered length : ' +
                        constatFiltered.length.toString());
                  });
                }),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  controller.clear();
                  _searchResult = '';
                  constatFiltered = AllConstats;
                });
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<BriseGlaceModel>>(
              initialData: constatFiltered,
              future: context.read<BriseViewModel>().getAllNonTraite(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    AllConstats = snapshot.data!;
                    constatFiltered = snapshot.data!;
                    return DataTable2(
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text(
                            "Date",
                            style: kMediumTableColumnWhiteBold.copyWith(
                              color: bgColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Description",
                            style: kMediumTableColumnWhiteBold.copyWith(
                              color: bgColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Actions",
                            style: kMediumTableColumnWhiteBold.copyWith(
                              color: bgColor,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        constatFiltered.length,
                        (index) => listConstatDataRow(
                            constatFiltered[index], context, constatFiltered),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Text(
                      "Aucun declaration de brise glace pour le moment",
                      style: kMediumTitleWhiteBold.copyWith(
                        color: kPrimaryColor,
                      ),
                    ));
                  }
                  log("length data : " + snapshot.data!.length.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow listConstatDataRow(
    BriseGlaceModel vol, BuildContext context, List<BriseGlaceModel> list) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        context.beamToNamed(DetailsBriseGlace.path + "/" + vol.id!, data: vol);
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
          'Nouvelle declaration de Brise glace de la part du client ' +
              vol.codeClient!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.all(defaultPadding * 0.7),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.beamToNamed(DetailsBriseGlace.path + "/" + vol.id!,
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
                    if (await confirm(context,
                      title: const Text(
                          'Marqué constat comme terminé'),
                      content: const Text(
                          'Vous êtes sur de valider ce constat?'),
                      textOK: const Text('Oui'),
                      textCancel: const Text('Annuler'),)) {
                      var res = await context
                          .read<BriseViewModel>()
                          .updateBrise(vol.id!, "Traité");

                      if (res.toString() == 'true') {
                        log('dkhal houni');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Declaration de Brise glace modifier avec succés ! ')),
                        );

                        context.beamToReplacementNamed(BriseGlaceNonTraiteScreen.path);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Erreur de validation de brise glace ! ')),
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
                    if (await confirm(context,
                      title: const Text('Rejet du constat'),
                      content: const Text(
                          'Vous êtes sur de rejeter ce constat?'),
                      textOK: const Text('Oui'),
                      textCancel: const Text('Annuler'),)) {
                      var res = await context
                          .read<BriseViewModel>()
                          .updateBrise(vol.id!, "Rejeté");
                      list.removeAt(list.indexOf(vol));
                      log("res : " + res.toString());
                      if (res.toString() == 'true') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Constat modifier avec succés ! ')),
                        );
                        context.beamToReplacementNamed(BriseGlaceNonTraiteScreen.path);
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
