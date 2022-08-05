import 'package:flutter_template/model/client_data.dart';
import 'package:flutter_template/model/client_model.dart';

class UserModel {
  ClientModel? client;
  ClientDataModel? clientData;
  String? type;

  UserModel({
    required this.client,
    required this.clientData,
    required this.type,
  });
}
