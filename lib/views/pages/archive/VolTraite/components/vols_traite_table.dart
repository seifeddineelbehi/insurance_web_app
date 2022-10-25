import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/model/vol_model.dart';
import 'package:flutter_template/viewModel/vol_view_model.dart';
import 'package:flutter_template/views/pages/Vols/vol_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../model/constat_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../viewModel/home_view_model.dart';
import '../../../Constats/details_constat_screen.dart';
import '../../../dashboard/components/constat_table.dart';
import '../../../main/main_screen.dart';

class VolsTraiteTable extends StatefulWidget {
  const VolsTraiteTable({Key? key}) : super(key: key);

  @override
  _VolsTraiteTableState createState() => _VolsTraiteTableState();
}

class _VolsTraiteTableState extends State<VolsTraiteTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = "";
  String _searchValue = "";
  bool taped = false;
  bool empty = true;
  List<VolModel> constatFiltered = [];
  List<VolModel> AllConstats = [];
  @override
  Widget build(BuildContext context) {
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
            "Vols traités",
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
                  onTap: () {
                    setState(() {
                      taped = true;
                      _searchResult = _searchValue;
                    });
                  },
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
                log('searche value :' + value);
                _searchValue = value;
              },
            ),
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
            child: FutureBuilder<List<VolModel>>(
              initialData: constatFiltered,
              future: context.read<VolViewModel>().getAllVolsTraite(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    empty = false;

                    AllConstats = snapshot.data!;
                    constatFiltered = snapshot.data!;
                    return Column(
                      children: [
                        DataTable2(
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
                                "Etat",
                                style: kMediumTableColumnWhiteBold.copyWith(
                                  color: bgColor,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            constatFiltered
                                .where((element) =>
                                    element.date!.contains(_searchResult))
                                .toList()
                                .length,
                            (index) => listTraiteDataRow(
                                constatFiltered
                                    .where((element) =>
                                        element.date!.contains(_searchResult))
                                    .toList()[index],
                                context,
                                constatFiltered),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "Aucune déclaration de vol pour le moment",
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
