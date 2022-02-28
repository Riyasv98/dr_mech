// To parse this JSON data, do
//
//     final ledgerPostingModel = ledgerPostingModelFromJson(jsonString);

import 'dart:convert';

LedgerPostingModel ledgerPostingModelFromJson(String str) => LedgerPostingModel.fromJson(json.decode(str));

String ledgerPostingModelToJson(LedgerPostingModel data) => json.encode(data.toJson());

class LedgerPostingModel {
  LedgerPostingModel({
    this.ledgerPostingId,
    this.date,
    this.voucherTypeId,
    this.voucherNo,
    this.ledgerId,
    this.debit,
    this.credit,
    this.detailsId,
    this.yearId,
    this.invoiceNo,
    this.chequeNo,
    this.chequeDate,
    this.extraDate,
    this.extra1,
    this.extra2,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  String? ledgerPostingId;
  String? date;
  int? voucherTypeId;
  String? voucherNo;
  int? ledgerId;
  double? debit;
  double? credit;
  int? detailsId;
  int? yearId;
  String? invoiceNo;
  String? chequeNo;
  String? chequeDate;
  String? extraDate;
  String? extra1;
  String? extra2;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory LedgerPostingModel.fromJson(Map<String, dynamic> json) => LedgerPostingModel(
    ledgerPostingId: json["ledgerPostingId"],
    date: json["date"],
    voucherTypeId: json["voucherTypeId"],
    voucherNo: json["voucherNo"],
    ledgerId: json["ledgerId"],
    debit: json["debit"],
    credit: json["credit"],
    detailsId: json["detailsId"],
    yearId: json["yearId"],
    invoiceNo: json["invoiceNo"],
    chequeNo: json["chequeNo"],
    chequeDate: json["chequeDate"],
    extraDate: json["extraDate"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    status: json["status"],
    brnId: json["brnId"],
    cmpId: json["cmpId"],
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "ledgerPostingId": ledgerPostingId,
    "date": date,
    "voucherTypeId": voucherTypeId,
    "voucherNo": voucherNo,
    "ledgerId": ledgerId,
    "debit": debit,
    "credit": credit,
    "detailsId": detailsId,
    "yearId": yearId,
    "invoiceNo": invoiceNo,
    "chequeNo": chequeNo,
    "chequeDate": chequeDate,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
