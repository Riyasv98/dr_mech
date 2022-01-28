// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.subcategoryId,
    this.categoryId,
    this.subcategoryName,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int ?subcategoryId;
  int ?categoryId;
  String ?subcategoryName;
  int ?brnId;
  int ?cmpId;
  String ?updatedBy;
  String ?createdBy;
  DateTime ?updatedOn;
  DateTime ?createdOn;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    subcategoryId: null!=json["subcategoryId"]?json["subcategoryId"] is int ? json["subcategoryId"]: int.parse(json["subcategoryId"]):-1,
    categoryId: json["categoryId"]?json["categoryId"] is int ? json["categoryId"]: int.parse(json["categoryId"]):-1,
    subcategoryName: json["subcategoryName"],
    brnId:null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    cmpId:null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: DateTime.parse(json["updatedOn"]),
    createdOn: DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "subcategoryId": subcategoryId,
    "categoryId": categoryId,
    "subcategoryName": subcategoryName,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
