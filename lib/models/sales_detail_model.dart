// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SalesDetailsModel salesDetailModelFromJson(String str) => SalesDetailsModel.fromJson(json.decode(str));

String salesDetailModelToJson(SalesDetailsModel data) => json.encode(data.toJson());



class SalesDetailsModel {
  SalesDetailsModel({
    this.salesDetailsId,
    this.salesMasterId,
    this.deliveryNoteDetailsId,
    this.orderDetailsId,
    this.quotationDetailsId,
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
    this.extraDate,
    this.extra1,
    this.extra2,
    this.description,
    this.productName,
    this.unitName,
    this.cgstAmt,this.sgstAmt,
    this.mrp,
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
  int? deliveryNoteDetailsId;
  int? orderDetailsId;
  int? quotationDetailsId;
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
  String? extraDate;
  String? extra1;
  String? extra2;
  String? description;
  String? productName;
  String? unitName;
  double? cgstAmt,sgstAmt,mrp;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory SalesDetailsModel.fromJson(Map<String, dynamic> json){
    double totalTax=  null!=json["taxAmount"] && json["taxAmount"] is String ? double.parse(json["taxAmount"]):json["taxAmount"];

    return SalesDetailsModel(
      salesDetailsId: null != json["salesDetailsId"]
          ? json["salesDetailsId"] is String
          ? int.parse(json["salesDetailsId"])
          : json["salesDetailsId"]
          : -1,
      salesMasterId: null != json["salesMasterId"]
          ? json["salesMasterId"] is String
          ? int.parse(json["salesMasterId"])
          : json["salesMasterId"]
          : -1,
      deliveryNoteDetailsId: null != json["deliveryNoteDetailsId"]
          ? json["deliveryNoteDetailsId"] is String ? int.parse(
          json["deliveryNoteDetailsId"]) : json["deliveryNoteDetailsId"]
          : -1,
      orderDetailsId: null != json["orderDetailsId"]
          ? json["orderDetailsId"] is String
          ? int.parse(json["orderDetailsId"])
          : json["orderDetailsId"]
          : -1,
      quotationDetailsId: null != json["quotationDetailsId"]
          ? json["quotationDetailsId"] is String ? int.parse(
          json["quotationDetailsId"]) : json["quotationDetailsId"]
          : -1,
      productId: null != json["productId"] ? json["productId"] is String ? int
          .parse(json["productId"]) : json["productId"] : -1,
      productName: json["productName"],
      qty: null != json["qty"] ? json["qty"] is String ? double.parse(
          json["qty"]) : json["qty"] : -1,
      rate: null != json["rate"] ? json["rate"] is String ? double.parse(
          json["rate"]) : json["rate"] : -1,
      unitId: null != json["unitId"] ? json["unitId"] is String ? int.parse(
          json["unitId"]) : json["unitId"] : -1,
      unitName: json ['unitName'],
      unitConversionId: null != json["unitConversionId"]
          ? json["unitConversionId"] is String ? int.parse(
          json["unitConversionId"]) : json["unitConversionId"]
          : -1,
      discount: null != json["discount"] ? json["discount"] is String ? double
          .parse(json["discount"]) : json["discount"] : -1,
      taxId: null != json["taxId"] ? json["taxId"] is String ? int.parse(
          json["taxId"]) : json["taxId"] : -1,
      batchId: null != json["batchId"] ? json["batchId"] is String ? int.parse(
          json["batchId"]) : json["batchId"] : -1,
      downId: null != json["downId"] ? json["downId"] is String ? int.parse(
          json["downId"]) : json["downId"] : -1,
      rackId: null != json["rackId"] ? json["rackId"] is String ? int.parse(
          json["rackId"]) : json["rackId"] : -1,
      taxAmount:totalTax,
      cgstAmt: totalTax / 2,
      sgstAmt:totalTax/2,
      grossAmount: null != json["grossAmount"] ? json["grossAmount"] is String
          ? double.parse(json["grossAmount"])
          : json["grossAmount"] : -1,
      netAmount: null != json["netAmount"] ? json["netAmount"] is String
          ? double.parse(json["netAmount"])
          : json["netAmount"] : -1,
      amount: null != json["amount"] ? json["amount"] is String ? double.parse(
          json["amount"]) : json["amount"] : -1,
      slNo: null != json["slNo"] ? json["slNo"] is String ? int.parse(
          json["slNo"]) : json["slNo"] : -1,
      extraDate: json["extraDate"],
      extra1: json["extra1"],
      extra2: json["extra2"],
      description: json["Description"],
      status: json["status"],
      brnId: json["brnId"],
      cmpId: json["cmpId"],
      updatedBy: null!=json["updatedBy"]?json["updatedBy"] is int ? json["updatedBy"]: int.parse(json["updatedBy"]):-1,
      createdBy: null!=json["createdBy"]?json["createdBy"] is int ? json["createdBy"]: int.parse(json["createdBy"]):-1,
      updatedOn: json["updatedOn"],
      createdOn: json["createdOn"],
    );
  }

  Map<String, dynamic> toJson() => {
    "salesDetailsId": salesDetailsId,
    "salesMasterId": salesMasterId,
    "deliveryNoteDetailsId": deliveryNoteDetailsId,
    "orderDetailsId": orderDetailsId,
    "quotationDetailsId": quotationDetailsId,
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
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "Description": description,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}

