import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/viewModel/admins_screen_view_model.dart';
import 'package:flutter_template/views/pages/Administrateurs/AdminScreenDetails.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../login/login_screen.dart';
import '../update_admin_screen.dart';

class AdminsTable extends StatefulWidget {
  const AdminsTable({Key? key}) : super(key: key);

  @override
  _AdminsTableState createState() => _AdminsTableState();
}

class _AdminsTableState extends State<AdminsTable> {
  late Future<List<AdminModel>> fetchedAdmins;
  TextEditingController controller = TextEditingController();
  String _searchResult = "";
  String _searchValue = "";
  bool taped = false;
  bool empty = true;
  List<AdminModel> adminFiltered = [];
  List<AdminModel> AllAdmins = [];
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
                  adminFiltered = AllAdmins;
                });
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<AdminModel>>(
              future: fetchedAdmins,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    empty = false;

                    AllAdmins = snapshot.data!;
                    adminFiltered = snapshot.data!;
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
                        DataColumn(
                          label: Text(
                            "Action",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        adminFiltered
                            .where((element) =>
                                element.username!.contains(_searchResult))
                            .toList()
                            .length,
                        (index) => AdminDetailDataRow(
                            adminFiltered
                                .where((element) =>
                                    element.username!.contains(_searchResult))
                                .toList()[index],
                            context),
                      ),
                    );
                  } else {
                    return Text(
                      "Liste des administrateurs vide!",
                      style: kMediumTitleWhiteBold.copyWith(
                        color: kPrimaryColor,
                      ),
                    );
                  }
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

DataRow AdminDetailDataRow(AdminModel admin, BuildContext context) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${admin.id}');
        context.beamToNamed(UpdateAdmin.path + "/" + admin.id!,
            popToNamed: AdminsDashboard.path, data: admin);
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
      DataCell(
        Container(
          padding: const EdgeInsets.all(defaultPadding * 0.7),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.beamToNamed(UpdateAdmin.path + "/" + admin.id!,
                        popToNamed: AdminsDashboard.path, data: admin);
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
                      Icons.edit,
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
