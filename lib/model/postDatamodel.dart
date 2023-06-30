// To parse this JSON data, do
//
//     final postDataResponseModel = postDataResponseModelFromJson(jsonString);

import 'dart:convert';

PostDataResponseModel postDataResponseModelFromJson(String str) => PostDataResponseModel.fromJson(json.decode(str));

String postDataResponseModelToJson(PostDataResponseModel data) => json.encode(data.toJson());

class PostDataResponseModel {
  int? status;
  String? message;
  Data? data;

  PostDataResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory PostDataResponseModel.fromJson(Map<String, dynamic> json) => PostDataResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? token;
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? profileImage;
  dynamic country;
  bool? emailVerified;
  bool? phoneVerified;
  bool? isAdminVerified;
  String? isSocialLogin;
  String? userType;
  Store? store;

  Data({
    this.token,
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.profileImage,
    this.country,
    this.emailVerified,
    this.phoneVerified,
    this.isAdminVerified,
    this.isSocialLogin,
    this.userType,
    this.store,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    profileImage: json["profile_image"],
    country: json["country"],
    emailVerified: json["email_verified"],
    phoneVerified: json["phone_verified"],
    isAdminVerified: json["is_admin_verified"],
    isSocialLogin: json["is_social_login"],
    userType: json["user_type"],
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "name": name,
    "email": email,
    "mobile_number": mobileNumber,
    "profile_image": profileImage,
    "country": country,
    "email_verified": emailVerified,
    "phone_verified": phoneVerified,
    "is_admin_verified": isAdminVerified,
    "is_social_login": isSocialLogin,
    "user_type": userType,
    "store": store?.toJson(),
  };
}

class Store {
  int? id;
  String? storeName;
  String? about;
  Address? address;
  Category? category;
  String? mobileNumber;
  String? email;
  dynamic profileImage;
  dynamic coverImage;
  String? instagramHandle;
  DateTime? createdAt;
  DateTime? updatedAt;

  Store({
    this.id,
    this.storeName,
    this.about,
    this.address,
    this.category,
    this.mobileNumber,
    this.email,
    this.profileImage,
    this.coverImage,
    this.instagramHandle,
    this.createdAt,
    this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    storeName: json["store_name"],
    about: json["about"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    mobileNumber: json["mobile_number"],
    email: json["email"],
    profileImage: json["profile_image"],
    coverImage: json["cover_image"],
    instagramHandle: json["instagram_handle"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_name": storeName,
    "about": about,
    "address": address?.toJson(),
    "category": category?.toJson(),
    "mobile_number": mobileNumber,
    "email": email,
    "profile_image": profileImage,
    "cover_image": coverImage,
    "instagram_handle": instagramHandle,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Address {
  int? addressId;
  double? latitude;
  double? longitude;
  String? streetHouse;
  String? area;
  String? address;
  City? city;
  Country? country;

  Address({
    this.addressId,
    this.latitude,
    this.longitude,
    this.streetHouse,
    this.area,
    this.address,
    this.city,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressId: json["address_id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    streetHouse: json["street_house"],
    area: json["area"],
    address: json["address"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId,
    "latitude": latitude,
    "longitude": longitude,
    "street_house": streetHouse,
    "area": area,
    "address": address,
    "city": city?.toJson(),
    "country": country?.toJson(),
  };
}

class City {
  int? cityId;
  String? cityName;
  bool? isActive;

  City({
    this.cityId,
    this.cityName,
    this.isActive,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
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

class Country {
  int? countryId;
  String? name;
  String? code;
  String? flag;

  Country({
    this.countryId,
    this.name,
    this.code,
    this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json["country_id"],
    name: json["name"],
    code: json["code"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "name": name,
    "code": code,
    "flag": flag,
  };
}

class Category {
  int? categoryId;
  String? name;

  Category({
    this.categoryId,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
  };
}