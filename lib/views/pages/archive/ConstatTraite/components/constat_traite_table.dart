import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../model/constat_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../viewModel/home_view_model.dart';
import '../../../Constats/details_constat_screen.dart';
import '../../../dashboard/components/constat_table.dart';

class ConstatTraiteTable extends StatefulWidget {
  const ConstatTraiteTable({Key? key}) : super(key: key);

  @override
  _ConstatTraiteTableState createState() => _ConstatTraiteTableState();
}

class _ConstatTraiteTableState extends State<ConstatTraiteTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<ConstatModel> constatFiltered = [];
  List<ConstatModel> AllConstats = [];
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
            "Materiels Traités",
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
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<ConstatModel>>(
              initialData: constatFiltered,
              future: context.read<HomeViewModel>().getAllConstatTraite(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    AllConstats = snapshot.data!;
                    constatFiltered = snapshot.data!;
                    return Column(
                      children: [
                        ListTile(
                          title: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: "Search",
                                fillColor: kPageColor,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        defaultPadding * 0.75),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 2),
                                    decoration: const BoxDecoration(
                                      color: const Color(0xFFFFA113),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/Search.svg"),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  log('searche value :' + value);
                                  _searchResult = value;
                                  constatFiltered = constatFiltered
                                      .where((constat) => constat.dateAccident!
                                          .contains(_searchResult))
                                      .toList();
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
                        DataTable2(
                          showCheckboxColumn: false,
                          columnSpacing: defaultPadding,
                          minWidth: 600,
                          columns: [
                            DataColumn(
                              label: Text(
                                "Client 1",
                                style: kMediumTitleWhiteBold.copyWith(
                                  color: bgColor,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Client 2",
                                style: kMediumTitleWhiteBold.copyWith(
                                  color: bgColor,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Date",
                                style: kMediumTitleWhiteBold.copyWith(
                                  color: bgColor,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Etat",
                                style: kMediumTitleWhiteBold.copyWith(
                                  color: bgColor,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            constatFiltered
                                .where((element) => element.dateAccident!
                                    .contains(_searchResult))
                                .toList()
                                .length,
                            (index) => listConstatTraiteDataRow(
                                constatFiltered
                                    .where((element) => element.dateAccident!
                                        .contains(_searchResult))
                                    .toList()[index],
                                context),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "Aucun constat pour le moment",
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

DataRow listConstatTraiteDataRow(ConstatModel constat, BuildContext context) {
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
      DataCell(
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
      ),
    ],
  );
}
