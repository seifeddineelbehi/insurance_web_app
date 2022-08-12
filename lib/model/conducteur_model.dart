class ConducteurModel {
  String? id;
  String? nom;
  String? prenom;
  String? address;
  String? delivreancePermis;
  String? idClient;
  String? etat;
  int? numPermis;
  DateTime? createdAt;
  DateTime? updatedAt;

  ConducteurModel({
    this.id,
    required this.nom,
    required this.prenom,
    required this.address,
    required this.delivreancePermis,
    this.idClient,
    required this.etat,
    required this.numPermis,
    this.createdAt,
    this.updatedAt,
  });

  factory ConducteurModel.fromJson(Map<String, dynamic> json) =>
      ConducteurModel(
        id: json["_id"],
        nom: json["nom"],
        prenom: json["prenom"],
        address: json["address"],
        delivreancePermis: json["delivreancePermis"],
        idClient: json["idClient"],
        etat: json["etat"],
        numPermis: json["numPermis"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
