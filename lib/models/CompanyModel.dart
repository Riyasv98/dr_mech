// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    this.companyId,
    this.name,
    this.email,
    this.phoneOne,
    this.phoneTwo,
    this.address,
    this.status,
    this.updatedOn,
    this.createdOn,
    this.createdBy,
  });

  int ?companyId;
  String ?name;
  String ?email;
  String ?phoneOne;
  String ?phoneTwo;
  String ?address;
  int ?status;
  String ?updatedOn;
  String ?createdOn;
  String ?createdBy;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    companyId:  null!=json["companyId"]?json["companyId"] is int ? json["companyId"]: int.parse(json["companyId"]):-1,
    name: json["name"],
    email: json["email"],
    phoneOne: json["phoneOne"],
    phoneTwo:  json["phoneTwo"],
    address: json["address"],
    status:  null!=json["status"]?json["status"] is int ? json["status"]: int.parse(json["status"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "name": name,
    "email": email,
    "phoneOne": phoneOne,
    "phoneTwo": phoneTwo,
    "address": address,
    "status": status,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
    "createdBy": createdBy,
  };
}
