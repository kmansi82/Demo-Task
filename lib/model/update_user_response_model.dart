// To parse this JSON data, do
//
//     final updateUserResponseModel = updateUserResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateUserResponseModel updateUserResponseModelFromJson(String str) => UpdateUserResponseModel.fromJson(json.decode(str));

String updateUserResponseModelToJson(UpdateUserResponseModel data) => json.encode(data.toJson());

class UpdateUserResponseModel {
  String? name;
  String? job;
  DateTime? updatedAt;

  UpdateUserResponseModel({
    this.name,
    this.job,
    this.updatedAt,
  });

  factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) => UpdateUserResponseModel(
    name: json["name"],
    job: json["job"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}