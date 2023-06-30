// To parse this JSON data, do
//
//     final dataResponseModel = dataResponseModelFromJson(jsonString);

import 'dart:convert';

DataResponseModel dataResponseModelFromJson(String str) => DataResponseModel.fromJson(json.decode(str));

String dataResponseModelToJson(DataResponseModel data) => json.encode(data.toJson());

class DataResponseModel {
  int? status;
  String? message;
  List<Datum>? data;
  Meta? meta;

  DataResponseModel({
    this.status,
    this.message,
    this.data,
    this.meta,
  });

  factory DataResponseModel.fromJson(Map<String, dynamic> json) => DataResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Datum {
  int? cityId;
  String? cityName;
  bool? isActive;

  Datum({
    this.cityId,
    this.cityName,
    this.isActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cityId: json["city_id"],
    cityName: json["city_name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city_name": cityName,
    "is_active": isActive,
  };
}

class Meta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}