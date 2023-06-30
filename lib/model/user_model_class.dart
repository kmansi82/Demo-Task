// To parse this JSON data, do
//
//     final userModelClass = userModelClassFromJson(jsonString);

import 'dart:convert';

UserModelClass userModelClassFromJson(String str) => UserModelClass.fromJson(json.decode(str));

String userModelClassToJson(UserModelClass data) => json.encode(data.toJson());

class UserModelClass {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;

  UserModelClass({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory UserModelClass.fromJson(Map<String, dynamic> json) => UserModelClass(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    userName: json["userName"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
  };
}
