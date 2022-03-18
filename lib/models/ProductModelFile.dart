// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';


/*class Group {
  Group({
    this.data,
    this.errorData,
  });

  List<ItemModel> data;
  List<ErrorDatum> errorData;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    data: List<ItemModel>.from(json["data"].map((x) => ItemModel.fromJson(x))),
    errorData: List<ErrorDatum>.from(json["errorData"].map((x) => ErrorDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errorData": List<dynamic>.from(errorData.map((x) => x.toJson())),
  };
}*/
ProductModel itemModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String itemToJson(ProductModel data) => json.encode(data.toJson());
class ProductModel {
  ProductModel({
    this.productId,
    this.brnId,
    this.cmpId,
    this.productCode,
    this.productName,
    this.groupId,
    this.brandId,
    this.unitId,
    this.sizeId,
    this.modelNoId,
    this.taxId,
    this.rate,
    this.taxapplicableOn,
    this.purchaseRate,
    this.salesRate,
    this.mrp,
    this.minimumStock,
    this.maximumStock,
    this.reorderLevel,
    this.downId,
    this.rackId,
    this.isallowBatch,
    this.ismultipleunit,
    this.isBom,
    this.isopeningstock,
    this.narration,
    this.isActive,
    this.isshowRemember,
    this.barCode,
    this.suppReferenceNo,
    this.extraDate,
    this.partNo,
    this.alternativeName,
    this.plu,
    this.status,
    this.unitName,
    this.groupName,this.focusNode,this.hsnCode,this.currentStock,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? productId;
  int? brnId;
  int? cmpId;
  String? productCode;
  String? productName;
  int? groupId;
  int? brandId;
  int? unitId;
  int? sizeId;
  int? modelNoId;
  int? taxId;
  String? taxapplicableOn;
  double? purchaseRate;
  double? rate;
  double? salesRate;
  double? mrp;
  double? minimumStock;
  double? maximumStock;
  double? reorderLevel;
  int? downId;
  int? rackId;
  bool? isallowBatch;
  bool?  ismultipleunit;
  bool?  isBom;
  bool?  isopeningstock;
  String? narration;
  bool? isActive;
  bool? isshowRemember;
  String? barCode;
  String? suppReferenceNo;
  String? extraDate;
  String? partNo;
  String? alternativeName;
  String? plu;
  int?status;
  String?unitName;
  String?groupName;
  FocusNode? focusNode;
  double ?hsnCode;
  double?currentStock;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;


  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: null!=json["productId"] ? json["productId"] is String ? int.parse(json["productId"]):json["productId"]:-1,
    brnId: null!=json["brnId"] ? json["brnId"] is String ? int.parse(json["brnId"]):json["brnId"]:-1,
    cmpId: null!=json["cmpId"] ? json["cmpId"] is String ? int.parse(json["cmpId"]):json["cmpId"]:-1,
    productCode: json["productCode"],
    productName: json["productName"],
    groupId:  null!=json["groupId"] ? json["groupId"] is String ? int.parse(json["groupId"]):json["groupId"]:-1,
    brandId:  null!=json["brandId"] ? json["brandId"] is String ? int.parse(json["brandId"]):json["brandId"]:-1,
    unitId: null!=json["unitId"] ? json["unitId"] is String ? int.parse(json["unitId"]):json["unitId"]:-1,
    sizeId: null!=json["sizeId"] ? json["sizeId"] is String ? int.parse(json["sizeId"]):json["sizeId"]:-1,
    modelNoId:null!=json["modelNoId"] ? json["modelNoId"] is String ? int.parse(json["modelNoId"]):json["modelNoId"]:-1,
    taxId:null!=json["taxId"] ? json["taxId"] is String ? int.parse(json["taxId"]):json["taxId"]:-1,
    taxapplicableOn: json["taxapplicableOn"],
    purchaseRate:  null!=json["purchaseRate"] ? json["purchaseRate"] is String ? double.parse(json["purchaseRate"]):json["purchaseRate"]:-1,
    rate:  null!=json["rate"] ? json["rate"] is String ? double.parse(json["rate"]):json["rate"]:-1,
    salesRate:null!=json["salesRate"] ? json["salesRate"] is String ? double.parse(json["salesRate"]):json["salesRate"]:-1,
    mrp: null!=json["mrp"] ? json["mrp"] is String ? double.parse(json["mrp"]):json["mrp"]:-1,
    minimumStock: null!=json["minimumStock"] ? json["minimumStock"] is String ? double.parse(json["minimumStock"]):json["minimumStock"]:-1,
    maximumStock: null!=json["maximumStock"] ? json["maximumStock"] is String ? double.parse(json["maximumStock"]):json["maximumStock"]:-1,
    reorderLevel: null!=json["reorderLevel"] ? json["reorderLevel"] is String ? double.parse(json["reorderLevel"]):json["reorderLevel"]:-1,
    downId: null!=json["downId"] ? json["downId"] is String ? int.parse(json["downId"]):json["downId"]:-1,
    rackId: null!=json["rackId"] ? json["rackId"] is String ? int.parse(json["rackId"]):json["rackId"]:-1,
    isallowBatch: json["isallowBatch"]==1,
    ismultipleunit: json["ismultipleunit"]==1,
    isBom: json["isBom"]==1,
    isopeningstock: json["isopeningstock"]==1,
    narration: json["narration"],
    isActive: json["isActive"]==1,
    isshowRemember: json["isshowRemember"]==1,
    barCode: json["barCode"],
    suppReferenceNo: json["SuppReferenceNo"],
    extraDate: json["extraDate"],
    partNo: json["partNo"],
    alternativeName: json["AlternativeName"],
    plu: json["PLU"],
    status: null!=json["status"] ? json["status"] is String ? int.parse(json["status"]):json["status"]:1,
    unitName: json["unitName"],
    groupName: json["groupName"],
    focusNode: new FocusNode(),
    hsnCode: null!=json["HSN"] ? json["HSN"] is String ? double.parse(json["HSN"]):json["HSN"]:-1,
    currentStock:  null!=json["currentStock"] ? json["currentStock"] is String ? double.parse(json["currentStock"]):json["currentStock"]:-1,
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn:json["updatedOn"],
    createdOn:json["createdOn"],


  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productCode": productCode,
    "productName": productName,
    "groupId": groupId,
    "brandId": brandId,
    "unitId": unitId,
    "sizeId": sizeId,
    "modelNoId": modelNoId,
    "taxId": taxId,
    "rate": rate,
    "taxapplicableOn": taxapplicableOn,
    "purchaseRate": purchaseRate,
    "salesRate": salesRate,
    "mrp": mrp,
    "minimumStock": minimumStock,
    "maximumStock": maximumStock,
    "reorderLevel": reorderLevel,
    "downId": downId,
    "rackId": rackId,
    "isallowBatch": isallowBatch,
    "ismultipleunit": ismultipleunit,
    "isBom": isBom,
    "isopeningstock": isopeningstock,
    "narration": narration,
    "isActive": isActive,
    "isshowRemember": isshowRemember,
    "barCode": barCode,
    "SuppReferenceNo": suppReferenceNo,
    "extraDate": extraDate,
    "partNo": partNo,
    "AlternativeName": alternativeName,
    "PLU": plu,
    "status": status,
    "unitName": unitName,
    "groupName": groupName,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };

}