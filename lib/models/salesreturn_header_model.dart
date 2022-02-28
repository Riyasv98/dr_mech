// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SalesReturnHeaderModel welcomeFromJson(String str) => SalesReturnHeaderModel.fromJson(json.decode(str));

String salesReturnModelToJson(SalesReturnHeaderModel data) => json.encode(data.toJson());



class SalesReturnHeaderModel {
  SalesReturnHeaderModel({
    this.salesReturnMasterId,
    this.voucherNo,
    this.invoiceNo,
    this.voucherTypeId,
    this.suffixPrefixId,
    this.salesMasterId,
    this.ledgerId,
    this.salesAccount,
    this.pricinglevelId,
    this.employeeId,
    this.narration,
    this.exchangeRateId,
    this.taxAmount,
    this.userId,
    this.lrNo,
    this.transportationCompany,
    this.date,
    this.totalAmount,
    this.discount,
    this.grandTotal,
    this.financialYearId,
    this.extraDate,
    this.extra1,
    this.extra2,this.ledgerName,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? salesReturnMasterId;
  String? voucherNo;
  String? invoiceNo;
  int? voucherTypeId;
  int? suffixPrefixId;
  int? salesMasterId;
  int? ledgerId;
  int? salesAccount;
  int? pricinglevelId;
  int? employeeId;
  String? narration;
  int? exchangeRateId;
  double? taxAmount;
  int? userId;
  String? lrNo;
  String? transportationCompany;
  String? date;
  double? totalAmount;
  double? discount;
  double? grandTotal;
  int? financialYearId;
  String? extraDate;
  String? extra1;
  String? extra2;
  String? ledgerName;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory SalesReturnHeaderModel.fromJson(Map<String, dynamic> json) => SalesReturnHeaderModel(
    salesReturnMasterId: json["salesReturnMasterId"],
    voucherNo: json["voucherNo"],
    invoiceNo: json["invoiceNo"],
    voucherTypeId: json["voucherTypeId"],
    suffixPrefixId: json["suffixPrefixId"],
    salesMasterId: json["salesMasterId"],
    ledgerId: json["ledgerId"],
    salesAccount: json["salesAccount"],
    pricinglevelId: json["pricinglevelId"],
    employeeId: json["employeeId"],
    narration: json["narration"],
    exchangeRateId: json["exchangeRateId"],
    taxAmount: json["taxAmount"],
    userId: json["userId"],
    lrNo: json["lrNo"],
    transportationCompany: json["transportationCompany"],
    date: json["date"],
    totalAmount: json["totalAmount"],
    discount: json["discount"],
    grandTotal: json["grandTotal"],
    financialYearId: json["financialYearId"],
    extraDate: json["extraDate"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    ledgerName: json["ledgerName"],
    status: json["status"],
    brnId: json["brnId"],
    cmpId: json["cmpId"],
    updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
    createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "salesReturnMasterId": salesReturnMasterId,
    "voucherNo": voucherNo,
    "invoiceNo": invoiceNo,
    "voucherTypeId": voucherTypeId,
    "suffixPrefixId": suffixPrefixId,
    "salesMasterId": salesMasterId,
    "ledgerId": ledgerId,
    "salesAccount": salesAccount,
    "pricinglevelId": pricinglevelId,
    "employeeId": employeeId,
    "narration": narration,
    "exchangeRateId": exchangeRateId,
    "taxAmount": taxAmount,
    "userId": userId,
    "lrNo": lrNo,
    "transportationCompany": transportationCompany,
    "date": date,
    "totalAmount": totalAmount,
    "discount": discount,
    "grandTotal": grandTotal,
    "financialYearId": financialYearId,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "ledgerName": ledgerName,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}


