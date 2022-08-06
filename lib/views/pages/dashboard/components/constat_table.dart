import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/Services/constat_service.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Constats/details_constat_screen.dart';
import 'package:flutter_template/views/pages/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../../model/RecentFile.dart';
import '../../../../utils/constants.dart';
import '../../../../viewModel/admins_screen_view_model.dart';
import '../../../../viewModel/home_view_model.dart';

class ConstatTable extends StatefulWidget {
  const ConstatTable({Key? key}) : super(key: key);

  @override
  _ConstatTableState createState() => _ConstatTableState();
}

class _ConstatTableState extends State<ConstatTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<ConstatModel> constatFiltered = [];
  List<ConstatModel> AllConstats = [];

  _getConstat() async {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    var Response =
        await ConstatService.getAllConstatNonTraite() as List<ConstatModel>;
    if (Response.isNotEmpty) {
      homeViewModel.setAllConstatNonTraite(Response);
      setState(() {
        AllConstats = homeViewModel.AllConstatNonTraite;
        constatFiltered = AllConstats;
      });
    }
  }

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
            "Constat recents",
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
          Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      log('searche value :' + value);
                      _searchResult = value;
                      constatFiltered = AllConstats.where((constat) =>
                              constat.id!.contains(_searchResult) ||
                              constat.vehiculeA!.nomAssure!
                                  .contains(_searchResult) ||
                              constat.vehiculeA!.prenomAssure!
                                  .contains(_searchResult) ||
                              constat.vehiculeA!.numContratAssurance!
                                  .contains(_searchResult) ||
                              constat.vehiculeB!.nomAssure!
                                  .contains(_searchResult) ||
                              constat.vehiculeB!.prenomAssure!
                                  .contains(_searchResult) ||
                              constat.vehiculeB!.numContratAssurance!
                                  .contains(_searchResult) ||
                              constat.dateAccident!.contains(_searchResult))
                          .toList();
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
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<ConstatModel>>(
              future: context.read<HomeViewModel>().getAllConstatNonTraite(),
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
                            "Client 1",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Client 2",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Date",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Etat",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        constatFiltered.length,
                        (index) =>
                            listConstatDataRow(constatFiltered[index], context),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Text(
                      "Aucun constat pour le moment",
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

DataRow listConstatDataRow(ConstatModel constat, BuildContext context) {
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
