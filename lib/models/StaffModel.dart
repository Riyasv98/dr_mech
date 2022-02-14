// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

import 'dart:convert';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
  StaffModel({
    this.brnId,
    this.branchName,
    this.companyName,
    this.employeeId,
    this.imgUrl,
    this.userName,
    this.password,
    this.cmpId,
    this.isAdmin,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int ?brnId;
  int ?cmpId;
  int ?employeeId;
  String ?name;
  String ?branchName;
  String ?companyName;
  String ?imgUrl;
  String ?userName;
  String ?password;
  bool ?isAdmin;
  String ?email;
  String ?phone;
  String ?address;
  String ?status;
  String ?updatedBy;
  String ?createdBy;
  String ?updatedOn;
  String ?createdOn;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    brnId: null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    cmpId: null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    employeeId: null!=json["employeeId"]?json["employeeId"] is int ? json["employeeId"]: int.parse(json["employeeId"]):-1,
    name: json["name"],
    branchName: json["branchName"],
    companyName: json["companyName"],
    isAdmin: json["isAdmin"]=="0",
    userName: json["userName"],
    password: json["password"],
    email: json["email"],
    phone: json["phone"],
    imgUrl: json["imgUrl"],
    address: json["address"],
    status: json["status"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "brnId": brnId,
    "employeeId": employeeId,
    "cmpId": cmpId,
    "name": name,
    "companyName": companyName,
    "branchName": branchName,
    "isAdmin": isAdmin,
    "userName": userName,
    "password": password,
    "email": email,
    "imgUrl": imgUrl,
    "phone": phone,
    "address": address,
    "status": status,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
