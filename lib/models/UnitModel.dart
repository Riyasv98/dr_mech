// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel {
  UnitModel({
    this.unitId,
    this.unitName,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int ?unitId;
  String ?unitName;
  int ?updatedBy;
  int ?createdBy;
  String ?updatedOn;
  String ?createdOn;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    unitId: null!=json["unitId"]?json["unitId"] is int ? json["unitId"]: int.parse(json["unitId"]):-1,
    unitName: json["unitName"],
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "unitId": unitId,
    "unitName": unitName,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
