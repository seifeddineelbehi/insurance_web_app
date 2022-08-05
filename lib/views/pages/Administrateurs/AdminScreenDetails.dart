import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Administrateurs/components/AdminTable.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import 'add_admin_screen.dart';

class AdminsDashboard extends StatefulWidget {
  static const String id = 'admins_screen';
  static const path = '/Admins';
  const AdminsDashboard({Key? key}) : super(key: key);

  @override
  _AdminsDashboardState createState() => _AdminsDashboardState();
}

class _AdminsDashboardState extends State<AdminsDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed:
                                  context.read<MenuController>().controlMenu,
                            ),
                          Text(
                            "Liste des Administrateurs",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding /
                                    (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              context.beamToNamed(AddAdmin.path);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add New"),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      const AdminsTable(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
