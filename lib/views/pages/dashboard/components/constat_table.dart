import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/model/constat_model.dart';
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
  @override
  Widget build(BuildContext context) {
    //final homeViewModel = Provider.of<HomeViewModel>(context);
    //final List<ConstatModel> allConstatNonTraite = homeViewModel.AllConstatNonTraite;
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
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<ConstatModel>>(
              future: context.read<HomeViewModel>().getAllConstatNonTraite(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
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
                        snapshot.data!.length,
                        (index) =>
                            recentFileDataRow(snapshot.data![index], context),
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

DataRow recentFileDataRow(ConstatModel constat, BuildContext context) {
  final Nomclient1 = constat.vehiculeA?.nomAssure.toString();
  final Prenomclient1 = constat.vehiculeA?.prenomAssure.toString();
  final Nomclient2 = constat.vehiculeB?.nomAssure.toString();
  final Prenomclient2 = constat.vehiculeB?.prenomAssure.toString();
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${constat.id}');
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
