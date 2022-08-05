import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/client_service.dart';
import 'package:flutter_template/model/client_model.dart';

import '../model/client_data.dart';
import '../utils/apis.dart';

class ClientsViewModel with ChangeNotifier {
  ClientDataModel? _clientdata;
  List<ClientModel> _allClients = [];

  List<ClientModel> get allClients => _allClients;

  setallClients(List<ClientModel> allClients) {
    _allClients = allClients;
  }

  List<ClientModel> get AllClients {
    return [..._allClients];
  }

  setClientData(ClientDataModel client) {
    _clientdata = client;

    notifyListeners();
  }

  ClientDataModel? get clientData {
    return _clientdata;
  }

  AddClient(ClientModel client) async {
    log('dkhal add admin');

    var response = await ClientsService.AddClient(localURL, client);
    log('response add client' + response.toString());
    return response;
  }

  Future<List<ClientModel>> getAllClients() async {
    var clients = await ClientsService.getAllClients();
    if (clients is List<ClientModel>) {
      //setAllAdmins(admins);
      return clients;
    } else {
      log('aaaaaaa');
      List<ClientModel> clients = [];
      return clients;
    }
  }

  Future<ClientDataModel?> getClientData(String refAssurance) async {
    var clients = await ClientsService.getClientAssuranceDetail(refAssurance);
    if (clients != null && clients is ClientDataModel) {
      //setClientData(clients);
      log('clients : ' + clients.nomClient!);
      return clients;
    } else {
      log('aaaaaaa');
      return null;
    }
  }
}
