
import 'dart:convert';

PurchaseDetailModel purchaseDetailModelFromJson(String str) => PurchaseDetailModel.fromJson(json.decode(str));

String purchaseDetailModelToJson(PurchaseDetailModel data) => json.encode(data.toJson());

class PurchaseDetailModel {
  PurchaseDetailModel({
    this.purchaseDetailsId,
    this.purchaseMasterId,
    this.receiptDetailsId,
    this.orderDetailsId,
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
    this.extra2,this.productName,this.unitName,this.cgstAmt,this.sgstAmt,
    this.mrp,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  int? purchaseDetailsId, purchaseMasterId, receiptDetailsId,orderDetailsId,productId,
      unitId,unitConversionId,taxId,batchId,downId,rackId;

  double? qty,rate, discount,taxAmount,grossAmount,netAmount,amount;
  int? slNo;
  String? extraDate;
  String? extra1;
  String? extra2,productName,unitName;
  double? cgstAmt,sgstAmt,mrp;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory PurchaseDetailModel.fromJson(Map<String, dynamic> json) {

    double totalTax=  null!=json["taxAmount"] && json["taxAmount"] is String ? double.parse(json["taxAmount"]):json["taxAmount"];

    return PurchaseDetailModel(
      purchaseDetailsId: null != json["purchaseDetailsId"]
          ? json["purchaseDetailsId"] is String ? int.parse(
          json["purchaseDetailsId"]) : json["purchaseDetailsId"]
          : -1,
      purchaseMasterId: null != json["purchaseMasterId"]
          ? json["purchaseMasterId"] is String ? int.parse(
          json["purchaseMasterId"]) : json["purchaseMasterId"]
          : -1,
      receiptDetailsId: null != json["receiptDetailsId"]
          ? json["receiptDetailsId"] is String ? int.parse(
          json["receiptDetailsId"]) : json["receiptDetailsId"]
          : -1,
      orderDetailsId: null != json["orderDetailsId"]
          ? json["orderDetailsId"] is String
          ? int.parse(json["orderDetailsId"])
          : json["orderDetailsId"]
          : -1,
      productId: null != json["productId"] ? json["productId"] is String ? int
          .parse(json["productId"]) : json["productId"] : -1,
      productName: json["productName"],
      qty: null != json["qty"] && json["qty"] is String ? double.parse(
          json["qty"]) : json["qty"],
      rate: null != json["rate"] && json["rate"] is String ? double.parse(
          json["rate"]) : json["rate"],
      unitId: null != json["unitId"] ? json["unitId"] is String ? int.parse(
          json["unitId"]) : json["unitId"] : -1,
      unitName: json ['unitName'],
      unitConversionId: null != json["unitConversionId"]
          ? json["unitConversionId"] is String ? int.parse(
          json["unitConversionId"]) : json["unitConversionId"]
          : -1,
      discount: null != json["discount"] && json["discount"] is String ? double
          .parse(json["discount"]) : json["discount"],
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
      grossAmount: null != json["grossAmount"] && json["grossAmount"] is String
          ? double.parse(json["grossAmount"])
          : json["grossAmount"],
      netAmount: null != json["netAmount"] && json["netAmount"] is String
          ? double.parse(json["netAmount"])
          : json["netAmount"],
      amount: null != json["amount"] && json["amount"] is String ? double.parse(
          json["amount"]) : json["amount"],
      slNo: null != json["slNo"] ? json["slNo"] is String ? int.parse(
          json["slNo"]) : json["slNo"] : -1,
      extraDate: json["extraDate"],
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
  }


  Map<String, dynamic> toJson() => {
    "purchaseDetailsId": purchaseDetailsId,
    "purchaseMasterId": purchaseMasterId,
    "receiptDetailsId": receiptDetailsId,
    "orderDetailsId": orderDetailsId,
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
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
