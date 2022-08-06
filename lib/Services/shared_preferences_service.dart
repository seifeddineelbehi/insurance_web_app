import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String token) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("token", token);
  }

  Future createRole(String role) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("role", role);
  }

  Future readCache(String token) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("token");
    return cache;
  }

  Future readRole() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("role");
    log('cache read role shared prefs : ' + cache!);
    return cache;
  }

  Future removeCache(String token) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove(token);
  }

  Future removeRole(String role) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove(role);
  }
}