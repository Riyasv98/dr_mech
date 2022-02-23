// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.productId,
    this.productName,
    this.unitId,
    this.groupId,
    this.salesRate,
    this.mrp,
    this.isActive,
    this.barCode,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
    this.groupName,
    this.unitName,
    this.currentStock,
  });

  int ?productId;
  String ?productName;
  int ?unitId;
  int ?groupId;
  String ?salesRate;
  String ?mrp;
  String ?isActive;
  String ?barCode;
  String ?status;
  int ?brnId;
  int ?cmpId;
  String ?updatedBy;
  String ?createdBy;
  String ?updatedOn;
  String ?createdOn;
  String ?groupName;
  String ?unitName;
  double ?currentStock;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: null!=json["productId"]?json["productId"] is int ? json["productId"]: int.parse(json["productId"]):-1,
    productName: json["productName"],
    unitId: null!=json["unitId"]?json["unitId"] is int ? json["unitId"]: int.parse(json["unitId"]):-1,
    groupId: null!=json["groupId"]?json["groupId"] is int ? json["groupId"]: int.parse(json["groupId"]):-1,
    salesRate: json["salesRate"],
    mrp: json["mrp"],
    isActive: json["isActive"],
    barCode: json["barCode"],
    status: json["status"],
    brnId: null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    cmpId: null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
    groupName: json["groupName"],
    unitName: json["unitName"],
    currentStock: null!=json["currentStock"]?json["currentStock"] is double ? json["currentStock"]: double.parse(json["currentStock"]):-1,
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "unitId": unitId,
    "groupId": groupId,
    "salesRate": salesRate,
    "mrp": mrp,
    "isActive": isActive,
    "barCode": barCode,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
    "groupName": groupName,
    "unitName": unitName,
    "currentStock": currentStock,
  };
}
