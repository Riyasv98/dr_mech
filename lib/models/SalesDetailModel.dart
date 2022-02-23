// To parse this JSON data, do
//
//     final salesDetailModel = salesDetailModelFromJson(jsonString);

import 'dart:convert';

SalesDetailModel salesDetailModelFromJson(String str) => SalesDetailModel.fromJson(json.decode(str));

String salesDetailModelToJson(SalesDetailModel data) => json.encode(data.toJson());

class SalesDetailModel {
  SalesDetailModel({
    this.salesDetailsId,
    this.salesMasterId,
    this.productId,
    this.qty,
    this.rate,
    this.unitId,
    this.discount,
    this.taxId,
    this.batchId,
    this.downId,
    this.rackId,
    this.taxAmount,
    this.grossAmount,
    this.netAmount,
    this.amount,
    this.slNo,
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

  int? salesDetailsId;
  int? salesMasterId;
  String? productId;
  double? qty;
  double? rate;
  int? unitId;
  double? discount;
  int? taxId;
  int? batchId;
  int? downId;
  int? rackId;
  double? taxAmount;
  double? grossAmount;
  double? netAmount;
  double? amount;
  String? slNo;
  String? extra1;
  String? extra2;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory SalesDetailModel.fromJson(Map<String, dynamic> json) => SalesDetailModel(
    salesDetailsId: json["salesDetailsId"],
    salesMasterId: json["salesMasterId"],
    productId: json["productId"],
    qty: json["qty"],
    rate: json["rate"],
    unitId: json["unitId"],
    discount: json["discount"],
    taxId: json["taxId"],
    batchId: json["batchId"],
    downId: json["downId"],
    rackId: json["rackId"],
    taxAmount: json["taxAmount"],
    grossAmount: json["grossAmount"],
    netAmount: json["netAmount"],
    amount: json["amount"],
    slNo: json["slNo"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    status: json["status"],
    brnId: json["brnId"],
    cmpId: json["cmpId"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "salesDetailsId": salesDetailsId,
    "salesMasterId": salesMasterId,
    "productId": productId,
    "qty": qty,
    "rate": rate,
    "unitId": unitId,
    "discount": discount,
    "taxId": taxId,
    "batchId": batchId,
    "downId": downId,
    "rackId": rackId,
    "taxAmount": taxAmount,
    "grossAmount": grossAmount,
    "netAmount": netAmount,
    "amount": amount,
    "slNo": slNo,
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
