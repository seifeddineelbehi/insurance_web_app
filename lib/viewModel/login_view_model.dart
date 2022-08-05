import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/admin_service.dart';
import 'package:flutter_template/model/admin_model.dart';

import '../Services/shared_preferences_service.dart';
import '../Services/shared_service.dart';
import '../utils/apis.dart';

abstract class AdminRepository {
  Login(String username, String password);
}

class LoginViewModel with ChangeNotifier implements AdminRepository {
  AdminModel? _admin;
  String? _role;
  bool? _loggedIn;

  setLoggedIn(bool loggedin) {
    _loggedIn = loggedin;
    notifyListeners();
  }

  String? get role {
    return _role;
  }

  setrole(String role) {
    _role = role;
    notifyListeners();
  }

  bool? get loggedin {
    return _loggedIn;
  }

  @override
  Login(String username, String password) async {
    var user = await AdminService.login(username, password);
    log("//////" + user.toString());
    if (user == false) {
      setLoggedIn(false);
      return user;
    } else {
      final PrefService _prefService = PrefService();
      print(user);
      var role = await _prefService.readRole();
      setrole(role!);
      setLoggedIn(true);
      return user;
    }
  }

  getUserInformation() async {
    final userToken = await SharedService.getUserToken() as String;
    var admin = await AdminService.getUserDetails(localURL, userToken);

    setUser(admin as AdminModel);
  }

  setUser(AdminModel admin) {
    _admin = admin;

    notifyListeners();
  }
}
