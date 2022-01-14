// To parse this JSON data, do
//
//     final imagePickerModel = imagePickerModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  BranchModel({
    this.branchId,
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
    this.userName,
    this.password,
  });

  int? branchId;
  int? companyId;
  String ?name;
  String ?email;
  String? phoneOne;
  String? phoneTwo;
  String ?address;
  String ?status;
  String ?updatedOn;
  String? createdOn;
  String ?createdBy;
  String ?userName;
  String ?password;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    branchId:  null!=json["branchId"]?json["branchId"] is int ? json["branchId"]: int.parse(json["branchId"]):-1,
    companyId: null!=json["companyId"]?json["companyId"] is int ? json["companyId"]: int.parse(json["companyId"]):-1,
    name: json["name"],
    email: json["email"],
    phoneOne:json["phoneOne"],
    phoneTwo: json["phoneTwo"] ,
    address: json["address"],
    status: json["status"],
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
    createdBy: json["createdBy"],
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
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
    "userName": userName,
    "password": password,
  };
}
