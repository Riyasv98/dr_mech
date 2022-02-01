// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel {
  UnitModel({
    this.id,
    this.name,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int ?id;
  String ?name;
  String ?updatedBy;
  String ?createdBy;
  String ?updatedOn;
  String ?createdOn;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    id: null!=json["id"]?json["id"] is int ? json["id"]: int.parse(json["id"]):-1,
    name: json["name"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn:json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
