
import 'dart:convert';

StockPostingModel stockPostingModelFromJson(String str) => StockPostingModel.fromJson(json.decode(str));

String stockPostingModelToJson(StockPostingModel data) => json.encode(data.toJson());

class StockPostingModel {
  StockPostingModel({
    this.stockPostingId,
    this.date,
    this.voucherTypeId,
    this.voucherNo,
    this.invoiceNo,
    this.productId,
    this.batchId,
    this.unitId,
    this.downId,
    this.rackId,
    this.againstVoucherTypeId,
    this.againstInvoiceNo,
    this.againstVoucherNo,
    this.inwardQty,
    this.outwardQty,
    this.rate,
    this.financialYearId,
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

  String? stockPostingId;
  String? date;
  int? voucherTypeId;
  String? voucherNo;
  String? invoiceNo;
  int? productId;
  int? batchId;
  int? unitId;
  int? downId;
  int? rackId;
  String? againstVoucherTypeId;
  String? againstInvoiceNo;
  String? againstVoucherNo;
  double? inwardQty;
  double? outwardQty;
  double? rate;
  int? financialYearId;
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

  factory StockPostingModel.fromJson(Map<String, dynamic> json) => StockPostingModel(
    stockPostingId: json["stockPostingId"],
    date: json["date"],
    voucherTypeId: json["voucherTypeId"],
    voucherNo: json["voucherNo"],
    invoiceNo: json["invoiceNo"],
    productId: json["productId"],
    batchId: json["batchId"],
    unitId: json["unitId"],
    downId: json["downId"],
    rackId: json["rackId"],
    againstVoucherTypeId: json["againstVoucherTypeId"],
    againstInvoiceNo: json["againstInvoiceNo"],
    againstVoucherNo: json["againstVoucherNo"],
    inwardQty: json["inwardQty"],
    outwardQty: json["outwardQty"],
    rate: json["rate"],
    financialYearId: json["financialYearId"],
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
    "stockPostingId": stockPostingId,
    "date": date,
    "voucherTypeId": voucherTypeId,
    "voucherNo": voucherNo,
    "invoiceNo": invoiceNo,
    "productId": productId,
    "batchId": batchId,
    "unitId": unitId,
    "downId": downId,
    "rackId": rackId,
    "againstVoucherTypeId": againstVoucherTypeId,
    "againstInvoiceNo": againstInvoiceNo,
    "againstVoucherNo": againstVoucherNo,
    "inwardQty": inwardQty,
    "outwardQty": outwardQty,
    "rate": rate,
    "financialYearId": financialYearId,
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
