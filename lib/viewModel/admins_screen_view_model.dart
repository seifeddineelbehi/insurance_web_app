import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/admin_service.dart';

import '../model/admin_model.dart';

class AdminViewModel with ChangeNotifier {
  AdminModel? _admin;
  List<AdminModel> _allAdmins = [];

  setAllAdmins(List<AdminModel> admins) {
    _allAdmins = admins;
    notifyListeners();
  }

// ignore: non_constant_identifier_names
  List<AdminModel> get AllAdmins {
    return [..._allAdmins];
  }

  setUser(AdminModel admin) {
    _admin = admin;

    notifyListeners();
  }

  AdminModel? get getAdmin {
    return _admin;
  }

  Future<List<AdminModel>> getAllAdmins() async {
    var admins = await AdminService.getAllAdmins();
    if (admins is List<AdminModel>) {
      //setAllAdmins(admins);
      return admins;
    } else {
      log('aaaaaaa');
      List<AdminModel> admins = [];
      return admins;
    }
  }
}
