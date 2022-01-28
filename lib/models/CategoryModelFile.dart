// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.imageName,
    this.cmpId,
    this.brnId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? categoryId;
  String? categoryName;
  String? imageName;
  int? cmpId;
  int? brnId;
  String? updatedBy;
  String? createdBy;
  DateTime? updatedOn;
  DateTime? createdOn;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: null!=json["categoryId"]?json["categoryId"] is int ? json["categoryId"]: int.parse(json["categoryId"]):-1,
    categoryName: json["categoryName"],
    imageName: json["imageName"],
    cmpId: null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    brnId: null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: DateTime.parse(json["updatedOn"]),
    createdOn: DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "imageName": imageName,
    "cmpId": cmpId,
    "brnId": brnId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn
  };
}
