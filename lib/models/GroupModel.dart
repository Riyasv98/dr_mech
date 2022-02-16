// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  GroupModel({
    this.groupId,
    this.groupName,
    this.groupUnder,
    this.narration,
    this.extra1,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? groupId;
  String? groupName;
  int? groupUnder;
  String? narration;
  String? extra1;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    groupId: json["groupId"] is String ? int.parse(json["groupId"]):json["groupId"],
    groupName: json["groupName"],
    groupUnder: json["groupUnder"] is String ? int.parse(json["groupUnder"]):json["groupUnder"],
    narration: json["narration"],
    extra1: json["extra1"],
    brnId: null!=json["brnId"]?json["brnId"] is int ? json["brnId"]: int.parse(json["brnId"]):-1,
    cmpId: null!=json["cmpId"]?json["cmpId"] is int ? json["cmpId"]: int.parse(json["cmpId"]):-1,
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "groupUnder": groupUnder,
    "narration": narration,
    "extra1": extra1,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
