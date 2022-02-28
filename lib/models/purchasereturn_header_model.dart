// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PurchaseReturnHeaderModel purchaseReturnHeaderModelFromJson(String str) => PurchaseReturnHeaderModel.fromJson(json.decode(str));

String purchaseReturnHeaderModelToJson(PurchaseReturnHeaderModel data) => json.encode(data.toJson());



class PurchaseReturnHeaderModel {
  PurchaseReturnHeaderModel({
    this.purchaseReturnMasterId,
    this.voucherNo,
    this.invoiceNo,
    this.suffixPrefixId,
    this.voucherTypeId,
    this.date,
    this.purchaseMasterId,
    this.ledgerId,
    this.discount,
    this.narration,
    this.purchaseAccount,
    this.totalTax,
    this.totalAmount,
    this.grandTotal,
    this.userId,
    this.lrNo,
    this.transportationCompany,
    this.financialYearId,
    this.extraDate,
    this.extra1,
    this.extra2,
    this.exchangeRateId,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? purchaseReturnMasterId;
  String? voucherNo;
  String? invoiceNo;
  int? suffixPrefixId;
  int? voucherTypeId;
  String? date;
  int? purchaseMasterId;
  int? ledgerId;
  double? discount;
  String? narration;
  int? purchaseAccount;
  double? totalTax;
  double? totalAmount;
  double? grandTotal;
  int? userId;
  String? lrNo;
  String? transportationCompany;
  int? financialYearId;
  String? extraDate;
  String? extra1;
  String? extra2;
  int? exchangeRateId;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory PurchaseReturnHeaderModel.fromJson(Map<String, dynamic> json) => PurchaseReturnHeaderModel(
    purchaseReturnMasterId: json["purchaseReturnMasterId"],
    voucherNo: json["voucherNo"],
    invoiceNo: json["invoiceNo"],
    suffixPrefixId: json["suffixPrefixId"],
    voucherTypeId: json["voucherTypeId"],
    date: json["date"],
    purchaseMasterId: json["purchaseMasterId"],
    ledgerId: json["ledgerId"],
    discount: json["discount"],
    narration: json["narration"],
    purchaseAccount: json["purchaseAccount"],
    totalTax: json["totalTax"],
    totalAmount: json["totalAmount"],
    grandTotal: json["grandTotal"],
    userId: json["userId"],
    lrNo: json["lrNo"],
    transportationCompany: json["transportationCompany"],
    financialYearId: json["financialYearId"],
    extraDate: json["extraDate"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    exchangeRateId: json["exchangeRateId"],
    status: json["status"],
    brnId: json["brnId"],
    cmpId: json["cmpId"],
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "purchaseReturnMasterId": purchaseReturnMasterId,
    "voucherNo": voucherNo,
    "invoiceNo": invoiceNo,
    "suffixPrefixId": suffixPrefixId,
    "voucherTypeId": voucherTypeId,
    "date": date,
    "purchaseMasterId": purchaseMasterId,
    "ledgerId": ledgerId,
    "discount": discount,
    "narration": narration,
    "purchaseAccount": purchaseAccount,
    "totalTax": totalTax,
    "totalAmount": totalAmount,
    "grandTotal": grandTotal,
    "userId": userId,
    "lrNo": lrNo,
    "transportationCompany": transportationCompany,
    "financialYearId": financialYearId,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "exchangeRateId": exchangeRateId,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}


