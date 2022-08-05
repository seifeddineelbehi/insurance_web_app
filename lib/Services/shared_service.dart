import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:beamer/beamer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/views/pages/login/login_screen.dart';

abstract class SharedServiceRepository {
  isLoggedIn();
  registerUserId(userId);
  logout();
  registerUserDetails();
}

class SharedService {
  static Future<bool> isLoggedIn() async {
    final PrefService _prefService = PrefService();

    var isKeyExist = await _prefService.readCache("token");
    if (isKeyExist) {
      return true;
    } else {
      return false;
    }
  }

  static logout(BuildContext context) async {
    final PrefService _prefService = PrefService();
    await _prefService.removeCache("token");
    context.beamToNamed(LoginPage.path);
  }

  static registerUserDetails(AdminModel user) {
    // TODO: implement registerUserDetails
    throw UnimplementedError();
  }

  static registerUserToken(String token) async {
    final PrefService _prefService = PrefService();
    await _prefService.createCache(token.toString());
  }

  static registerUserRole(String role) async {
    final PrefService _prefService = PrefService();
    await _prefService.createRole(role.toString());
  }

  static Future<String?> getUserToken() async {
    final PrefService _prefService = PrefService();
    var isKeyExist = await _prefService.readCache("token");

    if (isKeyExist) {
      var token = await _prefService.readCache("token");
      return token;
    }
  }
}
