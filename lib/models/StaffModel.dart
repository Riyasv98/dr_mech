// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
  StaffModel({
    this.employeeId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.imgUrl,
    this.status,
    this.updatedOn,
    this.createdOn,
    this.createdBy,
  });

  int? employeeId;
  String? name;
  String? email;
  String ?phone;
  String ?address;
  String ?imgUrl;
  int ?status;
  String ?updatedOn;
  String ?createdOn;
  String ?createdBy;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    employeeId: null!=json["employeeId"]?json["employeeId"] is int ? json["employeeId"]: int.parse(json["employeeId"]):-1,
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    imgUrl: json["imgUrl"],
    status:  null!=json["status"]?json["status"] is int ? json["status"]: int.parse(json["status"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "imgUrl": imgUrl,
    "status": status,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
    "createdBy": createdBy,
  };
}
