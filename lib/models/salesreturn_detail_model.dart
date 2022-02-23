
import 'dart:convert';

SalesReturnDetailModel salesReturnDetailModelFromJson(String str) => SalesReturnDetailModel.fromJson(json.decode(str));

String salesReturnDetailModelToJson(SalesReturnDetailModel data) => json.encode(data.toJson());



class SalesReturnDetailModel {
  SalesReturnDetailModel({
    this.salesReturnDetailsId,
    this.salesReturnMasterId,
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
    this.salesDetailsId,
    this.slNo,
    this.extraDate,
    this.extra1,
    this.extra2,this.productName,this.unitName,
    this.cgstAmt,this.sgstAmt,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,

  });

  int? salesReturnDetailsId;
  int? salesReturnMasterId;
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
  int? salesDetailsId;
  int? slNo;
  String? extraDate;
  String? extra1;
  String? extra2;
  String? productName,unitName;
  double? cgstAmt,sgstAmt;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory SalesReturnDetailModel.fromJson(Map<String, dynamic> json) {
    double totalTax=  null!=json["taxAmount"] && json["taxAmount"] is String ? double.parse(json["taxAmount"]):json["taxAmount"];
    return SalesReturnDetailModel(
      salesReturnDetailsId: json["salesReturnDetailsId"],
      salesReturnMasterId: json["salesReturnMasterId"],
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
      taxAmount:totalTax,
      cgstAmt: totalTax / 2,
      sgstAmt:totalTax/2,
      grossAmount: json["grossAmount"],
      netAmount: json["netAmount"],
      amount: json["amount"],
      salesDetailsId: json["salesDetailsId"],
      slNo: json["slNo"],
      extraDate:json["extraDate"],
      extra1: json["extra1"],
      extra2: json["extra2"],
      unitName: json["unitName"],
      productName: json["productName"],
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
    "salesReturnDetailsId": salesReturnDetailsId,
    "salesReturnMasterId": salesReturnMasterId,
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
    "salesDetailsId": salesDetailsId,
    "slNo": slNo,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "productName": productName,
    "unitName": unitName,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}


