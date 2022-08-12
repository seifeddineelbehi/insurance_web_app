class VolModel {
  String? id;
  String? date;
  String? codeClient;
  String? status;
  String? observation;
  DateTime? createdAt;
  DateTime? updatedAt;

  VolModel(
      {this.id,
      this.date,
      this.codeClient,
      this.status,
      this.observation,
      this.createdAt,
      this.updatedAt});

  factory VolModel.fromJson(Map<String, dynamic> json) => VolModel(
      id: json["_id"],
      date: json["date"],
      codeClient: json["codeClient"],
      status: json["status"],
      observation: json["observation"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]));
}
