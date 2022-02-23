
import 'dart:convert';

PurchaseHeaderModel purchaseModelFromJson(String str) => PurchaseHeaderModel.fromJson(json.decode(str));

String purchaseModelToJson(PurchaseHeaderModel data) => json.encode(data.toJson());

class PurchaseHeaderModel {
  PurchaseHeaderModel({
    this.purchaseMasterId,
    this.voucherNo,
    this.invoiceNo,
    this.suffixPrefixId,
    this.voucherTypeId,
    this.date,
    this.ledgerId,
    this.vendorInvoiceNo,
    this.vendorInvoiceDate,
    this.creditPeriod,
    this.exchangeRateId,
    this.narration,
    this.purchaseAccount,
    this.purchaseOrderMasterId,
    this.materialReceiptMasterId,
    this.additionalCost,
    this.totalTax,
    this.billDiscount,
    this.grandTotal,
    this.totalAmount,
    this.userId,
    this.lrNo,
    this.transportationCompany,
    this.financialYearId,
    this.extraDate,
    this.extra1,
    this.extra2,
    this.vendorName,
    this.totalInOtherCurrency,
    this.totalInWordOtherCurrency,this.ledgerName,
    this.status,
    this.brnId,
    this.cmpId,
    this.updatedBy,
    this.createdBy,
    this.updatedOn,
    this.createdOn,
  });

  String? purchaseMasterId;
  String? voucherNo;
  String? invoiceNo;
  String? suffixPrefixId;
  int? voucherTypeId;
  String? date;
  int? ledgerId;
  String? vendorInvoiceNo;
  String? vendorInvoiceDate;
  String? creditPeriod;
  String? exchangeRateId;
  String? narration;
  String? purchaseAccount;
  String? purchaseOrderMasterId;
  String? materialReceiptMasterId;
  String? additionalCost;
  String? ledgerName;
  String? userId,lrNo, transportationCompany,
  financialYearId,extraDate,extra1,extra2,vendorName,totalInOtherCurrency,
      totalInWordOtherCurrency;
  double? billDiscount,grandTotal, totalAmount,totalTax;
  int? status;
  int? brnId;
  int? cmpId;
  int? updatedBy;
  int? createdBy;
  String? updatedOn;
  String? createdOn;

  factory PurchaseHeaderModel.fromJson(Map<String, dynamic> json) => PurchaseHeaderModel(
    purchaseMasterId: json["purchaseMasterId"],
    voucherNo: json["voucherNo"],
    invoiceNo: json["invoiceNo"],
    suffixPrefixId: json["suffixPrefixId"],
    voucherTypeId: null!=json["voucherTypeId"] && json["voucherTypeId"]
    is String ? int.parse(json["voucherTypeId"]):json["voucherTypeId"],
    date: json["date"],
    ledgerId: null!=json["ledgerId"] && json["ledgerId"] is String ?
    int.parse(json["ledgerId"]):json["ledgerId"],

    vendorInvoiceNo: json["vendorInvoiceNo"],
    vendorInvoiceDate: json["vendorInvoiceDate"],
    creditPeriod: json["creditPeriod"],
    exchangeRateId: json["exchangeRateId"],
    narration: json["narration"],
    purchaseAccount: json["purchaseAccount"],
    purchaseOrderMasterId: json["purchaseOrderMasterId"],
    materialReceiptMasterId: json["materialReceiptMasterId"],
    additionalCost: json["additionalCost"],
    totalTax: null!=json["totalTax"] && json["totalTax"] is String ?
    double.parse(json["totalTax"]):json["totalTax"],
    billDiscount: null!=json["billDiscount"] && json["billDiscount"] is String ?
    double.parse(json["billDiscount"]):json["billDiscount"],
    grandTotal: null!=json["grandTotal"] && json["grandTotal"] is String ?
    double.parse(json["grandTotal"]):json["grandTotal"],
    totalAmount: null!=json["totalAmount"] && json["totalAmount"] is String ?
    double.parse(json["totalAmount"]):json["totalAmount"],
    userId: json["userId"],
    lrNo: json["lrNo"],
    transportationCompany: json["transportationCompany"],
    financialYearId: json["financialYearId"],
    extraDate: json["extraDate"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    vendorName: json["vendorName"],
    totalInOtherCurrency: json["TotalInOtherCurrency"],
    totalInWordOtherCurrency: json["TotalInWordOtherCurrency"],
    ledgerName: json["ledgerName"],
    status: json["status"],
    brnId: json["brnId"],
    cmpId: json["cmpId"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    updatedOn: json["updatedOn"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "purchaseMasterId": purchaseMasterId,
    "voucherNo": voucherNo,
    "invoiceNo": invoiceNo,
    "suffixPrefixId": suffixPrefixId,
    "voucherTypeId": voucherTypeId,
    "date": date,
    "ledgerId": ledgerId,
    "vendorInvoiceNo": vendorInvoiceNo,
    "vendorInvoiceDate": vendorInvoiceDate,
    "creditPeriod": creditPeriod,
    "exchangeRateId": exchangeRateId,
    "narration": narration,
    "purchaseAccount": purchaseAccount,
    "purchaseOrderMasterId": purchaseOrderMasterId,
    "materialReceiptMasterId": materialReceiptMasterId,
    "additionalCost": additionalCost,
    "totalTax": totalTax,
    "billDiscount": billDiscount,
    "grandTotal": grandTotal,
    "totalAmount": totalAmount,
    "userId": userId,
    "lrNo": lrNo,
    "transportationCompany": transportationCompany,
    "financialYearId": financialYearId,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "vendorName": vendorName,
    "TotalInOtherCurrency": totalInOtherCurrency,
    "TotalInWordOtherCurrency": totalInWordOtherCurrency,
    "status": status,
    "brnId": brnId,
    "cmpId": cmpId,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "updatedOn": updatedOn,
    "createdOn": createdOn,
  };
}
