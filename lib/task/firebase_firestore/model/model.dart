class DataModel {
  final String? id;
  final String name;
  final String email;
  final String dob;
  final String password;

  DataModel({
    this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.password,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    dob: json["dob"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "dob": dob,
    "password": password,
  };
}
