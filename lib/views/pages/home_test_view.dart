import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/translations/locale_keys.g.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'home_view';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _iconBool = false;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

  final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
  );
  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
  );
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _iconBool);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.test.tr(),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(
                  const Locale('en'),
                );
                Get.updateLocale(const Locale('en'));
              },
              child: const Text(
                "English",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(
                  const Locale('fr'),
                );
                Get.updateLocale(const Locale('fr'));
              },
              child: const Text(
                "French",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(
                  const Locale('ar'),
                );
                Get.updateLocale(const Locale('ar'));
              },
              child: const Text(
                "Arabic",
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _iconBool = !_iconBool;
                  _saveThemeStatus();
                  if (_iconBool) {
                    Get.changeTheme(_darkTheme);
                  } else {
                    Get.changeTheme(_lightTheme);
                  }
                });
              },
              icon: Icon(_iconBool ? _iconDark : _iconLight),
            ),
          ],
        ),
      ),
    );
  }
}
