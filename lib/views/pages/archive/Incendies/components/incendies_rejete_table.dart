import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:flutter_template/model/vol_model.dart';
import 'package:flutter_template/viewModel/brise_view_model.dart';
import 'package:flutter_template/viewModel/vol_view_model.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../model/constat_model.dart';
import '../../../../../model/incendies_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../viewModel/home_view_model.dart';
import '../../../../../viewModel/incendie_view_model.dart';
import '../../../Constats/details_constat_screen.dart';
import '../../../dashboard/components/constat_table.dart';
import '../../../main/main_screen.dart';

class IncendiesRejeteTable extends StatefulWidget {
  const IncendiesRejeteTable({Key? key}) : super(key: key);

  @override
  _IncendiesRejeteTableState createState() => _IncendiesRejeteTableState();
}

class _IncendiesRejeteTableState extends State<IncendiesRejeteTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<IncendiesModel> constatFiltered = [];
  List<IncendiesModel> AllConstats = [];

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
            child: FutureBuilder<List<IncendiesModel>>(
              initialData: constatFiltered,
              future: context.read<IncendiesViewModel>().getAllRejete(),
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
                        (index) => listTraiteDataRow(
                            constatFiltered[index], context, constatFiltered),
                      ),
                    );
                  } else {
                    return Text(
                      "Aucun declaration d\'incendies pour le moment",
                      style: kMediumTitleWhiteBold.copyWith(
                        color: kPrimaryColor,
                      ),
                    );
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

DataRow listTraiteDataRow(
    IncendiesModel vol, BuildContext context, List<IncendiesModel> list) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        context.beamToNamed(DetailIncendie.path + "/" + vol.id!, data: vol);
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
      DataCell(
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
      ),
    ],
  );
}
