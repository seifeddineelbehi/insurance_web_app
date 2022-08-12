import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/model/client_data.dart';
import 'package:flutter_template/model/user_model.dart';
import 'package:flutter_template/views/pages/Clients/add_client.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import '../model/client_model.dart';
import 'package:http/http.dart' as http;

import '../utils/apis.dart';

class ClientsService {
  final PrefService _prefService = PrefService();

  static Future<Object?> getAllClients() async {
    var token = "";
    await ClientsService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });

    List<ClientModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + getAllClientsApi);

    try {
      var response = await http.get(uri, headers: requestHeaders);

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        log('response.body getAllClient : ' + response.body);
        log('response.status : ' + response.statusCode.toString());
        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            ClientModel client = ClientModel.fromJson(e);
            data.add(client);
          });
          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        } else {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getClientAssuranceDetail(String refAssurance) async {
    //List<ClientDataModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json"
    };
    Uri uri = Uri.parse(
        "https://apiinsurance.herokuapp.com/assurance/" + refAssurance);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.status getClientAssuranceDetail : ' +
          response.statusCode.toString());
      if (response.statusCode == 203) {
        log('dkhal getClientAssuranceDetail : ');
        Map<String, dynamic> res = json.decode(response.body);
        log('response.body getClientAssuranceDetail : ' +
            res.length.toString());
        if (res.isNotEmpty) {
          ClientDataModel client = ClientDataModel.fromJson(res);
          //data.add(client);
          return client;
        }
      } else {
        return null;
      }
    } catch (exception) {
      return null;
    }
  }

  static Future<Object?> AddClient(String endpoint, ClientModel client) async {
    var token = "";
    await ClientsService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });
    log('admin token add client :' + token);
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token
    };
    var body = {
      "username": client.username,
      "password": client.password,
      "email": client.email,
      "refAssurance": client.refAssurance
    };
    Uri uri = Uri.parse(endpoint + AddNewClient);
    log('add admin uri:' + uri.toString());
    try {
      var response =
          await http.post(uri, headers: requestHeaders, body: jsonEncode(body));
      if (response.statusCode == 201) {
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

  static Future<Object?> getClientDetailsByCodeClient(String codeClient) async {
    var token = "";
    await ClientsService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
      'Authorization': token
    };
    Uri uri = Uri.parse(localURL + getDetailClientsApi + codeClient);
    log('Uri ' + uri.toString());
    try {
      var response = await http.get(uri, headers: requestHeaders);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        if (res['success'].toString() == 'true') {
          log('dkhal dadldzad ' + res['success'].toString());
          ClientModel client = ClientModel.fromJson(res['client']);
          log('message ' + res['client'].toString());
          return client;
        } else {
          return false;
        }
      }
    } catch (exception) {
      return false;
    }
  }
}
