class VehiculeModel {
  String? id;
  String? codeClient;
  String? assurePar;
  String? agence;
  String? debutValid;
  String? finValid;
  String? nomConducteur;
  String? prenomConducteur;
  String? addresseConducteur;
  String? permisConducteur;
  String? delivrancePermisConducteur;
  String? nomAssure;
  String? prenomAssure;
  String? addresseAssure;
  String? numContratAssurance;
  String? telAssure;
  String? marqueTypeVoiture;
  String? immatriculation;
  String? sensSuivi;
  String? venantDe;
  String? allantA;
  String? pointChoc;
  String? degatApparent;
  List<String>? circonstances;
  String? observation;
  List<String>? images;
  String? signature;
  DateTime? createdAt;
  DateTime? updatedAt;
  VehiculeModel({
    this.id,
    this.codeClient,
    this.assurePar,
    this.agence,
    this.debutValid,
    this.finValid,
    this.nomConducteur,
    this.prenomConducteur,
    this.addresseConducteur,
    this.permisConducteur,
    this.delivrancePermisConducteur,
    this.nomAssure,
    this.addresseAssure,
    this.telAssure,
    this.marqueTypeVoiture,
    this.immatriculation,
    this.sensSuivi,
    this.venantDe,
    this.allantA,
    this.pointChoc,
    this.degatApparent,
    this.circonstances,
    this.observation,
    this.images,
    this.signature,
    this.prenomAssure,
    this.numContratAssurance,
    this.createdAt,
    this.updatedAt,
  });
  factory VehiculeModel.fromJson(Map<String, dynamic> json) => VehiculeModel(
        id: json["_id"],
        codeClient: json["codeClient"],
        assurePar: json["assurePar"],
        agence: json["agence"],
        debutValid: json["debutValid"],
        finValid: json["finValid"],
        numContratAssurance: json["numContratAssurance"],
        nomConducteur: json["nomConducteur"],
        prenomConducteur: json["prenomConducteur"],
        addresseConducteur: json["addresseConducteur"],
        permisConducteur: json["permisConducteur"],
        delivrancePermisConducteur: json["delivrancePermisConducteur"],
        nomAssure: json["nomAssure"],
        prenomAssure: json["prenomAssure"],
        addresseAssure: json["addresseAssure"],
        telAssure: json["telAssure"],
        marqueTypeVoiture: json["marqueTypeVoiture"],
        immatriculation: json["immatriculation"],
        sensSuivi: json["sensSuivi"],
        venantDe: json["venantDe"],
        allantA: json["allantA"],
        pointChoc: json["pointChoc"],
        degatApparent: json["degatApparent"],
        circonstances: List<String>.from(json["circonstances"].map((x) => x)),
        observation: json["observation"],
        images: List<String>.from(json["images"].map((x) => x)),
        signature: json["signature"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
