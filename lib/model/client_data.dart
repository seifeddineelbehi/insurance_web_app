import 'package:flutter_template/model/conducteur_model.dart';
import 'package:flutter_template/model/constat_model.dart';

class ClientDataModel {
  String? id;
  String? refClient;
  String? nomClient;
  String? prenomClient;
  String? addresseClient;
  String? telClient;
  String? assureur;
  String? agence;
  String? numContrat;
  String? DBContrat;
  String? DFContrat;
  String? voiture;
  String? immatriculation;
  List<dynamic>? typeContrat;

  DateTime? createdAt;
  DateTime? updatedAt;

  ClientDataModel({
    this.id,
    this.refClient,
    this.nomClient,
    this.prenomClient,
    this.addresseClient,
    this.telClient,
    this.assureur,
    this.agence,
    this.numContrat,
    this.DBContrat,
    this.DFContrat,
    this.voiture,
    this.immatriculation,
    this.typeContrat,
    this.createdAt,
    this.updatedAt,
  });

  factory ClientDataModel.fromJson(Map<String, dynamic> json) =>
      ClientDataModel(
        id: json["_id"],
        refClient: json["refClient"],
        nomClient: json["nomClient"],
        prenomClient: json["prenomClient"],
        addresseClient: json["addresseClient"],
        telClient: json["telClient"],
        assureur: json["assureur"],
        agence: json["agence"],
        numContrat: json["numContrat"],
        DBContrat: json["DBContrat"],
        DFContrat: json["DFContrat"],
        voiture: json["voiture"],
        immatriculation: json["immatriculation"],
        typeContrat: json["typeContrat"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
