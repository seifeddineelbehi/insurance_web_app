class AdminModel {
  String? id;
  String? username;
  String? password;
  String? role;
  String? status;

  AdminModel({this.id, this.username, this.password, this.role, this.status});
  AdminModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    username = json["username"];
    password = json["password"];
    role = json["role"];
    status = json["status"];
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "role": role,
      "status": status,
    };
  }
}
