// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.productId,
    this.brnId,
    this.cmpId,
    this.productName,
    this.groupName,
    this.unitName,
    this.groupId,
    this.unitId,
    this.salesRate,
    this.mrp,
    this.isActive,
    this.barCode,
    this.status,
    this.updatedOn,
    this.updatedBy,
    this.createdOn,
    this.createdBy,
  });

  int? productId;
  int? brnId;
  int? cmpId;
  String? productName;
  String? groupName;
  String? unitName;
  int? groupId;
  int? unitId;
  String? salesRate;
  String? mrp;
  String? isActive;
  String? barCode;
  String? status;
  String? updatedOn;
  String? updatedBy;
  String? createdOn;
  String? createdBy;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId:  null!=json["productId"]?json["productId"] is int ? json["productId"]: int.parse(json["productId"]):-1,
    brnId:  null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    cmpId:  null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    productName: json["productName"],
    groupName: json["groupName"],
    unitName: json["unitName"],
    groupId: null!=json["groupId"]?json["groupId"] is int ? json["groupId"]: int.parse(json["groupId"]):-1,
    unitId: null!=json["unitId"]?json["unitId"] is int ? json["unitId"]: int.parse(json["unitId"]):-1,
    salesRate: json["salesRate"],
    mrp: json["mrp"],
    isActive: json["isActive"],
    barCode: json["barCode"],
    status:  json["status"],
    updatedOn: json["updatedOn"],
    updatedBy: json["updatedBy"],
    createdOn: json["createdOn"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "brnId": brnId,
    "cmpId": cmpId,
    "productName": productName,
    "groupName": groupName,
    "unitName": unitName,
    "groupId": groupId,
    "unitId": unitId,
    "salesRate": salesRate,
    "mrp": mrp,
    "isActive": isActive,
    "barCode": barCode,
    "status": status,
    "updatedOn": updatedOn,
    "updatedBy": updatedBy,
    "createdOn": createdOn,
    "createdBy": createdBy,
  };
}

