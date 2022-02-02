// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.productId,
    this.productName,
    this.categoryId,
    this.subCategoryId,
    this.unitId,
    this.salesRate,
    this.mrp,
    this.isActive,
    this.barCode,
    this.status,
    this.updatedOn,
    this.createdOn,
    this.createdBy,
  });

  int ?productId;
  String ?productName;
  int ?categoryId;
  int ?subCategoryId;
  int ?unitId;
  String ?salesRate;
  String ?mrp;
  String ?isActive;
  String ?barCode;
  int ?status;
  String ?updatedOn;
  String ?createdOn;
  String ?createdBy;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId:  null!=json["productId"]?json["productId"] is int ? json["productId"]: int.parse(json["productId"]):-1,
    productName: json["productName"],
    categoryId: null!=json["categoryId"]?json["categoryId"] is int ? json["categoryId"]: int.parse(json["categoryId"]):-1,
    subCategoryId: null!=json["subCategoryId"]?json["subCategoryId"] is int ? json["subCategoryId"]: int.parse(json["subCategoryId"]):-1,
    unitId: null!=json["unitId"]?json["unitId"] is int ? json["unitId"]: int.parse(json["unitId"]):-1,
    salesRate: json["salesRate"],
    mrp: json["mrp"],
    isActive: json["isActive"],
    barCode: json["barCode"],
    status:  null!=json["status"]?json["status"] is int ? json["status"]: int.parse(json["status"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "unitId": unitId,
    "salesRate": salesRate,
    "mrp": mrp,
    "isActive": isActive,
    "barCode": barCode,
    "status": status,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
    "createdBy": createdBy,
  };
}

