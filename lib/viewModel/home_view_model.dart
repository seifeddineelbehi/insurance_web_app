import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/constat_service.dart';
import 'package:flutter_template/model/constat_model.dart';

import '../Services/shared_preferences_service.dart';

class HomeViewModel with ChangeNotifier {
  List<ConstatModel> _allConstatNontraite = [];
  String? _role;

  String? get role {
    return _role;
  }

  setrole(String role) {
    _role = role;
    notifyListeners();
  }

  getRole() async {
    final PrefService _prefService = PrefService();
    var role = await _prefService.readRole();
    log("roleeeeeee: " + role.toString());
    setrole(role.toString());
    log("roleeeeeeeeafeafaefa: " + _role.toString());
    return role;
  }

  setAllConstatNonTraite(List<ConstatModel> constats) {
    _allConstatNontraite = constats;
  }

// ignore: non_constant_identifier_names
  List<ConstatModel> get AllConstatNonTraite {
    return [..._allConstatNontraite];
  }

  Future<List<ConstatModel>> getAllConstatNonTraite() async {
    var constats = await ConstatService.getAllConstatNonTraite();
    if (constats is List<ConstatModel>) {
      setAllConstatNonTraite(constats);
      return constats;
    } else {
      log('aaaaaaa');
      List<ConstatModel> constat = [];
      return constat;
    }
  }
}
