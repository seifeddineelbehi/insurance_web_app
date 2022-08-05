import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/viewModel/admins_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../login/login_screen.dart';

class AdminsTable extends StatefulWidget {
  const AdminsTable({Key? key}) : super(key: key);

  @override
  _AdminsTableState createState() => _AdminsTableState();
}

class _AdminsTableState extends State<AdminsTable> {
  late Future<List<AdminModel>> fetchedAdmins;

  @override
  void initState() {
    fetchedAdmins = context.read<AdminViewModel>().getAllAdmins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminsViewModel = Provider.of<AdminViewModel>(context, listen: true);
    //List<AdminModel> allAdmins = adminsViewModel.AllAdmins;
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
            "Liste des administrateurs",
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
            child: FutureBuilder<List<AdminModel>>(
              future: fetchedAdmins,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DataTable2(
                    showCheckboxColumn: false,
                    columnSpacing: defaultPadding,
                    minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("Surnom",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            )),
                      ),
                      DataColumn(
                        label: Text(
                          "Status",
                          style: kMediumTitleWhiteBold.copyWith(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Role",
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

DataRow recentFileDataRow(AdminModel admin, BuildContext context) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${admin.id}');
        Beamer.of(context).beamToNamed(LoginPage.path);
      }
    },
    cells: [
      DataCell(
        Text(
          admin.username!,
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
          admin.status!,
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
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              admin.role!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kPageColor,
              ),
            ),
          ),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: admin.role! == "Super admin" ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}
