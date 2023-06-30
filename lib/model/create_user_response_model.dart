// To parse this JSON data, do
//
//     final createUserResponseModel = createUserResponseModelFromJson(jsonString);

import 'dart:convert';

CreateUserResponseModel createUserResponseModelFromJson(String str) => CreateUserResponseModel.fromJson(json.decode(str));

String createUserResponseModelToJson(CreateUserResponseModel data) => json.encode(data.toJson());

class CreateUserResponseModel {
  String? name;
  String? job;
  String? id;
  DateTime? createdAt;

  CreateUserResponseModel({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) => CreateUserResponseModel(
    name: json["name"],
    job: json["job"],
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
  };
}
