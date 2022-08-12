import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/Services/shared_service.dart';
import 'package:flutter_template/model/admin_model.dart';

import '../Services/admin_service.dart';
import '../utils/apis.dart';

class AddAdminViewModel with ChangeNotifier {
  AddAdmin(AdminModel admin) async {
    log('dkhal add admin');

    var response = await AdminService.AddAdmin(localURL, admin);
    log('response add admin' + response.toString());
    return response;
  }

  UpdateAdmin(AdminModel admin) async {
    log('dkhal add admin');

    var response = await AdminService.UpdateAdmin(admin);
    log('response update admin ' + response.toString());
    return response;
  }
}
