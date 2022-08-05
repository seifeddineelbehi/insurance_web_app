import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/Services/shared_service.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:http/http.dart' as http;

import '../utils/apis.dart';

class AdminService {
  final PrefService _prefService = PrefService();

  static Future<Object?> login(String username, String password) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
    };
    Uri uri = Uri.parse(localURL + LoginAdmin);
    var body = {
      "username": username,
      "password": password,
    };
    try {
      log("dhaaaal1");
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));
      log('login response.body : ' + response.body);
      log('login response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("dhaaaal1");

        var res = json.decode(response.body);
        // log("api" + res["user"].toString());
        if (res["token"] != null) {
          log("dhaaaal1");
          await SharedService.registerUserToken(res["token"]);
          await SharedService.registerUserRole(res["role"]);

          return true;
        }
      } else {
        return false;
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getUserDetails(
      String endpoint, String userToken) async {
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': userToken
    };
    Uri uri = Uri.http(endpoint, DetailAdmin);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      //  log("user infod " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        if (res != null) {
          AdminModel admin = AdminModel.fromJson(res['Admin']);

          return admin;
        }
      }
    } catch (exception) {}
  }

  static Future<Object?> AddAdmin(String endpoint, AdminModel admin) async {
    var token = "";
    await AdminService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });
    log('admin token add admin :' + token);
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token
    };
    var body = {
      "username": admin.username,
      "password": admin.password,
      "status": admin.status,
      "role": admin.role
    };
    Uri uri = Uri.parse(endpoint + AddNewAdmin);
    log('add admin uri:' + uri.toString());
    try {
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        return res['success'];
      }
      if (response.body == 'Unauthorized') {
        return false;
      }
      if (response.statusCode != 200) {
        var res = json.decode(response.body);
        return res['message'];
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getAllAdmins() async {
    var token = "";
    await AdminService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });

    List<AdminModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllAdmins);

    try {
      var response = await http.get(uri, headers: requestHeaders);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        log('response.body : ' + response.body);
        log('response.status : ' + response.statusCode.toString());
        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            AdminModel admin = AdminModel.fromJson(e);
            data.add(admin);
          });
          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }
}
