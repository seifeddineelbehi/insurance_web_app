import 'dart:developer';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/admin_service.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/model/agent_model.dart';

import '../Services/shared_preferences_service.dart';
import '../Services/shared_service.dart';
import '../utils/apis.dart';

abstract class AdminRepository {
  Login(String username, String password);
}

class LoginViewModel with ChangeNotifier implements AdminRepository {
  AdminModel? _admin;
  AgentModel? _agent;
  bool? _loading = false;
  AdminModel get admin => _admin!;
  final PrefService _prefService = PrefService();

  setAdmin(AdminModel value) {
    _admin = value;
    notifyListeners();
  }

  setAgent(AgentModel value) {
    _agent = value;
    notifyListeners();
  }

  String? _role;
  bool? _loggedIn;

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  bool get Loading {
    return _loading!;
  }

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
    setLoading(true);
    var user = await AdminService.login(username, password);

    log("//////" + user.toString());
    if (user == false) {
      setLoggedIn(false);
      setLoading(false);
      return user;
    } else {
      final PrefService _prefService = PrefService();
      print(user);
      var role = await _prefService.readRole();
      setrole(role!);
      setLoggedIn(true);
      await getUserInformation();
      setLoading(false);
      return user;
    }
  }

  getUserInformation() async {
    var admin = await AdminService.getUserDetails();

    if (_prefService.readRole().toString() == 'Super Admin') {
      setAdmin(admin as AdminModel);
      log(admin.username! + " getUserInformation set user");
    }
    if (_prefService.readRole().toString() == 'Admin') {
      setAgent(admin as AgentModel);
      log(admin.email! + " getUserInformation set user");
    }
  }
}
