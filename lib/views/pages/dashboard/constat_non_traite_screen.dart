import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../viewModel/home_view_model.dart';
import 'components/header.dart';

import 'components/my_fields.dart';
import 'components/constat_table.dart';
import '../statestiques/components/constat_stat_widget.dart';

class ConstatNonTraiteScreen extends StatefulWidget {
  static const String id = 'main_screen';
  static const path = '/dashboard';
  const ConstatNonTraiteScreen({Key? key}) : super(key: key);

  @override
  _ConstatNonTraiteScreenState createState() => _ConstatNonTraiteScreenState();
}

class _ConstatNonTraiteScreenState extends State<ConstatNonTraiteScreen> {
  getTokent() async {
    print("*******get tokent*******");
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print('DEVICE TOKEN ' + deviceToken!);
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      await getTokent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: const [
            Header(headerTitle: "Dashboard"),
            SizedBox(height: defaultPadding),
            ConstatTable()
          ],
        ),
      ),
    );
  }
}
