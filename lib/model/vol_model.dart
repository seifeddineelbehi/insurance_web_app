class VolModel {
  String? id;
  String? date;
  String? codeClient;
  String? status;
  String? observation;

  VolModel(
      {this.id, this.date, this.codeClient, this.status, this.observation});

  factory VolModel.fromJson(Map<String, dynamic> json) => VolModel(
      id: json["_id"],
      date: json["date"],
      codeClient: json["codeClient"],
      status: json["status"],
      observation: json["observation"]);
}
