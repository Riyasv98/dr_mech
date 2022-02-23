// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SalesHeaderModel salesHeaderModelFromJson(String str) => SalesHeaderModel.fromJson(json.decode(str));

String salesModelToJson(SalesHeaderModel data) => json.encode(data.toJson());



class SalesHeaderModel {
  SalesHeaderModel({
    this.salesMasterId,
    this.voucherNo,
    this.invoiceNo,
    this.voucherTypeId,
    this.suffixPrefixId,
    this.date,
    this.creditPeriod,
    this.ledgerId,
    this.pricinglevelId,
    this.employeeId,
    this.salesAccount,
    this.deliveryNoteMasterId,
    this.orderMasterId,
    this.narration,
    this.customerName,
    this.exchangeRateId,
    this.taxAmount,
    this.additionalCost,
    this.billDiscount,
    this.grandTotal,
    this.totalAmount,
    this.userId,
    this.lrNo,
    this.transportationCompany,
    this.quotationMasterId,
    this.pos,
    this.counterId,
    this.financialYearId,
    this.extraDate,
    this.extra1,
    this.extra2,
    this.dnNumber,
    this.lpo,
    this.totalInOtherCurrency,
    this.totalInWordOtherCurrency,
    this.vendorName,
    this.mrn,
    this.ledgerName,
  });

  int? salesMasterId;
  String? voucherNo;
  String? invoiceNo;
  int? voucherTypeId;
  int? suffixPrefixId;
  String? date;
  int? creditPeriod;
  int? ledgerId;
  int? pricinglevelId;
  int? employeeId;
  int? salesAccount;
  int? deliveryNoteMasterId;
  int? orderMasterId;
  String? narration;
  String? customerName;
  int? exchangeRateId;
  double? taxAmount;
  double? additionalCost;
  double? billDiscount;
  double? grandTotal;
  double? totalAmount;
  int? userId;
  String? lrNo;
  String? transportationCompany;
  int? quotationMasterId;
  int? pos;
  int? counterId;
  int? financialYearId;
  String? extraDate;
  String? extra1;
  String? extra2;
  String? dnNumber;
  String? lpo;
  double? totalInOtherCurrency;
  String? totalInWordOtherCurrency;
  String? vendorName;
  String? mrn;
  String? ledgerName;

  factory SalesHeaderModel.fromJson(Map<String, dynamic> json) => SalesHeaderModel(
    salesMasterId: null!=json["salesMasterId"] ? json["salesMasterId"] is String ? int.parse(json["salesMasterId"]):json["salesMasterId"]:-1,
    voucherNo: json["voucherNo"],
    invoiceNo: json["invoiceNo"],
    voucherTypeId: null!=json["voucherTypeId"] ? json["voucherTypeId"] is String ? int.parse(json["voucherTypeId"]):json["voucherTypeId"]:-1,
    suffixPrefixId: null!=json["suffixPrefixId"] ? json["suffixPrefixId"] is String ? int.parse(json["suffixPrefixId"]):json["suffixPrefixId"]:-1,
    date: json["date"],
    creditPeriod: null!=json["creditPeriod"] ? json["creditPeriod"] is String ? int.parse(json["creditPeriod"]):json["creditPeriod"]:-1,

    pricinglevelId:  null!=json["pricinglevelId"] ? json["pricinglevelId"] is String ? int.parse(json["pricinglevelId"]):json["pricinglevelId"]:-1,
    employeeId: null!=json["employeeId"] ? json["employeeId"] is String ? int.parse(json["employeeId"]):json["employeeId"]:-1,
    salesAccount: null!=json["salesAccount"] ? json["salesAccount"] is String ? int.parse(json["salesAccount"]):json["salesAccount"]:-1,
    deliveryNoteMasterId: null!=json["deliveryNoteMasterId"] ? json["deliveryNoteMasterId"] is String ? int.parse(json["deliveryNoteMasterId"]):json["deliveryNoteMasterId"]:-1,
    orderMasterId: null!=json["orderMasterId"] ? json["orderMasterId"] is String ? int.parse(json["orderMasterId"]):json["orderMasterId"]:-1,
    narration: json["narration"],
    customerName: json["customerName"],
    exchangeRateId: null!=json["exchangeRateId"] ? json["exchangeRateId"] is String ? int.parse(json["exchangeRateId"]):json["exchangeRateId"]:-1,
    taxAmount: null!=json["taxAmount"] ? json["taxAmount"] is String ? double.parse(json["taxAmount"]):json["taxAmount"]:-1,
    billDiscount:null!=json["billDiscount"] ? json["billDiscount"] is String ? double.parse(json["billDiscount"]):json["billDiscount"]:-1,
    grandTotal: null!=json["grandTotal"] ? json["grandTotal"] is String ? double.parse(json["grandTotal"]):json["grandTotal"]:-1,
    totalAmount: null!=json["totalAmount"] ? json["totalAmount"] is String ? double.parse(json["totalAmount"]):json["totalAmount"]:-1,
    userId: null!=json["userId"] ? json["userId"] is String ? int.parse(json["userId"]):json["userId"]:-1,
    lrNo: json["lrNo"],
    transportationCompany: json["transportationCompany"],
    quotationMasterId: null!=json["quotationMasterId"] ? json["quotationMasterId"] is String ? int.parse(json["quotationMasterId"]):json["quotationMasterId"]:-1,
    pos: null!=json["pos"] ? json["pos"] is String ? int.parse(json["pos"]):json["pos"]:-1,
    counterId: null!=json["counterId"] ? json["counterId"] is String ? int.parse(json["counterId"]):json["counterId"]:-1,
    financialYearId: null!=json["financialYearId"] ? json["financialYearId"] is String ? int.parse(json["financialYearId"]):json["financialYearId"]:-1,
    extraDate: json["extraDate"],
    extra1: json["extra1"],
    extra2: json["extra2"],
    dnNumber: json["DnNumber"],
    lpo: json["Lpo"],
    totalInOtherCurrency: null!=json["totalInOtherCurrency"] ? json["totalInOtherCurrency"] is String ? double.parse(json["totalInOtherCurrency"]):json["totalInOtherCurrency"]:-1,
    totalInWordOtherCurrency: json["TotalInWordOtherCurrency"],
    vendorName: json["VendorName"],
    mrn: json["MRN"],
    ledgerId: null!=json["ledgerId"] && json["ledgerId"] is String ?
    int.parse(json["ledgerId"]):json["ledgerId"],
    ledgerName: json["ledgerName"],
  );

  Map<String, dynamic> toJson() => {
    "salesMasterId": salesMasterId,
    "voucherNo": voucherNo,
    "invoiceNo": invoiceNo,
    "voucherTypeId": voucherTypeId,
    "suffixPrefixId": suffixPrefixId,
    "date": date,
    "creditPeriod": creditPeriod,
    "ledgerId": ledgerId,
    "pricinglevelId": pricinglevelId,
    "employeeId": employeeId,
    "salesAccount": salesAccount,
    "deliveryNoteMasterId": deliveryNoteMasterId,
    "orderMasterId": orderMasterId,
    "narration": narration,
    "customerName": customerName,
    "exchangeRateId": exchangeRateId,
    "taxAmount": taxAmount,
    "additionalCost": additionalCost,
    "billDiscount": billDiscount,
    "grandTotal": grandTotal,
    "totalAmount": totalAmount,
    "userId": userId,
    "lrNo": lrNo,
    "transportationCompany": transportationCompany,
    "quotationMasterId": quotationMasterId,
    "POS": pos,
    "counterId": counterId,
    "financialYearId": financialYearId,
    "extraDate": extraDate,
    "extra1": extra1,
    "extra2": extra2,
    "DnNumber": dnNumber,
    "Lpo": lpo,
    "TotalInOtherCurrency": totalInOtherCurrency,
    "TotalInWordOtherCurrency": totalInWordOtherCurrency,
    "VendorName": vendorName,
    "MRN": mrn,
    "ledgerName": ledgerName,
  };
}