// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PurchaseReturnDetailModel purchaseReturnDetailModelFromJson(String str) => PurchaseReturnDetailModel.fromJson(json.decode(str));

String purchaseReturnDetailModelToJson(PurchaseReturnDetailModel data) => json.encode(data.toJson());


class PurchaseReturnDetailModel {
  PurchaseReturnDetailModel({
    this.purchaseReturnDetailsId,
    this.purchaseReturnMasterId,
    this.productId,
    this.qty,
    this.rate,
    this.unitId,
    this.unitConversionId,
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
    this.purchaseDetailsId,
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

  int? purchaseReturnDetailsId;
  int? purchaseReturnMasterId;
  int? productId;
  double? qty;
  double? rate;
  int? unitId;
  int? unitConversionId;
  double? discount;
  int? taxId;
  int? batchId;
  int? downId;
  int? rackId;
  double? taxAmount;
  double? grossAmount;
  double? netAmount;
  double? amount;
  int? slNo;
  int? purchaseDetailsId;
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

  factory PurchaseReturnDetailModel.fromJson(Map<String, dynamic> json) => PurchaseReturnDetailModel(
    purchaseReturnDetailsId: json["purchaseReturnDetailsId"],
    purchaseReturnMasterId: json["purchaseReturnMasterId"],
    productId: json["productId"],
    qty: json["qty"],
    rate: json["rate"],
    unitId: json["unitId"],
    unitConversionId: json["unitConversionId"],
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
    purchaseDetailsId: json["purchaseDetailsId"],
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
    "purchaseReturnDetailsId": purchaseReturnDetailsId,
    "purchaseReturnMasterId": purchaseReturnMasterId,
    "productId": productId,
    "qty": qty,
    "rate": rate,
    "unitId": unitId,
    "unitConversionId": unitConversionId,
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
    "purchaseDetailsId": purchaseDetailsId,
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


