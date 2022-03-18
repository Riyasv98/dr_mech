
import 'package:dr_mech/models/ProductModelFile.dart';
import 'package:dr_mech/models/purchase_detail_model.dart';
import 'package:dr_mech/models/sales_detail_model.dart';
import 'package:dr_mech/models/salesreturn_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductProvider extends ChangeNotifier{
  List<PurchaseDetailModel> purchaseCartList=[];
  List<SalesDetailsModel> salesCartList=[];
  List<SalesReturnDetailModel> salesReturnCartList=[];
  List<ProductModel> allItemList=[];
  List<ProductModel> filteredItemList=[];
  int currentItemIndex=-1;


  setCurrentItemIndex(int index){
    this.currentItemIndex=index;
    notifyListeners();
  }
  incrementDecrementCurrentItemIndex(bool isIncrement,AutoScrollController controller){
    if(isIncrement){
      if( this.currentItemIndex==-1 ){
        this.currentItemIndex=0;
      }else if(currentItemIndex<filteredItemList.length-1){
        this.currentItemIndex = currentItemIndex + 1 ;
      }
    }else if(currentItemIndex>0){
      if(currentItemIndex<filteredItemList.length){
        this.currentItemIndex = currentItemIndex - 1;
      }
    }
    controller.scrollToIndex(currentItemIndex+2,preferPosition: AutoScrollPosition.end);
    notifyListeners();
  }
  clearPurchaseCart(){
    this.purchaseCartList=[];
    this.salesCartList = [];
    notifyListeners();
  }
  clearSalesReturnCart(){
    this.salesReturnCartList=[];
    notifyListeners();
  }
  reloadItems(List<ProductModel> items){
    this.allItemList=items;
    notifyListeners();
  }

  filterItems(String text){
    filteredItemList = allItemList
        .where((item) => item.productName!
        .toLowerCase()
        .contains(text.toLowerCase()))
        .toList();
    if (text.isEmpty) {
      filteredItemList = [];
    }
    notifyListeners();
  }
  // Original Cost – (Original Cost * (100 / (100 + GST% ) ) )
  // 100 – (100 * (100 / (100 + 18 ) ) )


  double getTaxAmtInclusive(double price,double taxPercent){
    double taxWithoutPrice=price - (price * (100 / (100 + taxPercent )));

    return taxWithoutPrice;
  }

  PurchaseDetailModel calculateValues(PurchaseDetailModel purchaseDetailModel){


    double gstTotalP=18;
    double sgstP=gstTotalP/2;
    double cgstP=gstTotalP/2;

    double cgstF=0;
    double sgstF=0;
    double amount=0;


    if(GetStorage().read("isInclusive")){

      cgstF=getTaxAmtInclusive(purchaseDetailModel.rate!,cgstP);
      sgstF=getTaxAmtInclusive(purchaseDetailModel.rate!,sgstP);
      amount = purchaseDetailModel.qty!*purchaseDetailModel.rate!;


    }else{
      cgstF=purchaseDetailModel.rate!*(cgstP/100);
      sgstF=purchaseDetailModel.rate!*(sgstP/100);
      amount =
          purchaseDetailModel.qty!*(
              purchaseDetailModel.rate!+(cgstF+sgstF));
    }
    purchaseDetailModel.cgstAmt=cgstF;
    purchaseDetailModel.sgstAmt=sgstF;
    purchaseDetailModel.amount=amount;
    purchaseDetailModel.grossAmount=amount;
    purchaseDetailModel.netAmount=amount;
    purchaseDetailModel.taxAmount=cgstF+sgstF;

    return purchaseDetailModel;
  }

  void addToPurchaseCart(ProductModel itemModel,double qty){
    if(null!= purchaseCartList && purchaseCartList.length>0){
      final index= purchaseCartList.indexWhere((data) =>
      data.productId.toString()==itemModel.productId.toString());
      if(index> -1  ){
        purchaseCartList[index].qty=qty;
        purchaseCartList[index].rate=itemModel.purchaseRate;
        purchaseCartList[index]=calculateValues(purchaseCartList[index]);

      }else{

        PurchaseDetailModel purchaseDetailModel=new PurchaseDetailModel();
        purchaseDetailModel.qty=qty;
        purchaseDetailModel.rate=itemModel.purchaseRate;
        purchaseDetailModel.productName=itemModel.productName.toString();
        purchaseDetailModel.productId=itemModel.productId;
        purchaseDetailModel.unitId=itemModel.unitId;
        purchaseDetailModel.taxId=itemModel.taxId;
        purchaseDetailModel.downId=itemModel.downId;
        purchaseDetailModel.rackId=itemModel.rackId;
        purchaseDetailModel.unitName=itemModel.unitName;
        purchaseDetailModel.mrp=itemModel.mrp;
        purchaseDetailModel=calculateValues(purchaseDetailModel);


        purchaseCartList.add(purchaseDetailModel);


      }

    } else {
      PurchaseDetailModel purchaseDetailModel=new PurchaseDetailModel();
      purchaseDetailModel.qty=qty;
      purchaseDetailModel.rate=itemModel.purchaseRate;
      purchaseDetailModel.productName=itemModel.productName.toString();
      purchaseDetailModel.productId=itemModel.productId;
      purchaseDetailModel.unitId=itemModel.unitId;
      purchaseDetailModel.taxId=itemModel.taxId;
      purchaseDetailModel.downId=itemModel.downId;
      purchaseDetailModel.rackId=itemModel.rackId;
      purchaseDetailModel.unitName=itemModel.unitName;
      purchaseDetailModel.mrp=itemModel.mrp;
      purchaseDetailModel =calculateValues(purchaseDetailModel);

      purchaseCartList.add(purchaseDetailModel);

    }

    notifyListeners();
  }
  SalesDetailsModel calculateSalesValues(SalesDetailsModel salesDetailModel){
    double gstTotalP=18;
    double sgstP=gstTotalP/2;
    double cgstP=gstTotalP/2;

    double cgstF=0;
    double sgstF=0;
    double amount=0;


    if(GetStorage().read("isInclusive")){

      cgstF=getTaxAmtInclusive(salesDetailModel.rate!,cgstP);
      sgstF=getTaxAmtInclusive(salesDetailModel.rate!,sgstP);
      amount = salesDetailModel.qty!*salesDetailModel.rate!;


    }else{
      cgstF=salesDetailModel.rate!*(cgstP/100);
      sgstF=salesDetailModel.rate!*(sgstP/100);
      amount =
          salesDetailModel.qty!*(
              salesDetailModel.rate!+(cgstF+sgstF));
    }
    salesDetailModel.cgstAmt=cgstF;
    salesDetailModel.sgstAmt=sgstF;
    salesDetailModel.amount=amount;
    salesDetailModel.grossAmount=amount;
    salesDetailModel.netAmount=amount;
    salesDetailModel.taxAmount=cgstF+sgstF;

    return salesDetailModel;
  }
  SalesReturnDetailModel calculateSalesReturnValues(SalesReturnDetailModel salesReturnDetailModel){
    double gstTotalP=18;
    double sgstP=gstTotalP/2;
    double cgstP=gstTotalP/2;

    double cgstF=0;
    double sgstF=0;
    double amount=0;


    if(GetStorage().read("isInclusive")){

      cgstF=getTaxAmtInclusive(salesReturnDetailModel.rate!,cgstP);
      sgstF=getTaxAmtInclusive(salesReturnDetailModel.rate!,sgstP);
      amount = salesReturnDetailModel.qty!*salesReturnDetailModel.rate!;


    }else{
      cgstF=salesReturnDetailModel.rate!*(cgstP/100);
      sgstF=salesReturnDetailModel.rate!*(sgstP/100);
      amount =
          salesReturnDetailModel.qty!*(
              salesReturnDetailModel.rate!+(cgstF+sgstF));
    }
    salesReturnDetailModel.cgstAmt=cgstF;
    salesReturnDetailModel.sgstAmt=sgstF;
    salesReturnDetailModel.amount=amount;
    salesReturnDetailModel.grossAmount=amount;
    salesReturnDetailModel.netAmount=amount;
    salesReturnDetailModel.taxAmount=cgstF+sgstF;

    return salesReturnDetailModel;
  }
  void reloadSalesCart(List<SalesDetailsModel> items){
    this.salesCartList=items;
    notifyListeners();
  }
  void reloadSalesReturnCart(List<SalesReturnDetailModel> items){
    this.salesReturnCartList=items;
    notifyListeners();
  }
  void reloadPurchaseCart(List<PurchaseDetailModel> items){
    this.purchaseCartList=items;
    notifyListeners();
  }
  void removeFromSalesCart(int position){
    salesCartList.removeAt(position);
    notifyListeners();
  }
  void removeFromSalesReturnCart(int position){
    salesReturnCartList.removeAt(position);
    notifyListeners();
  }
  void removeFromPurhaseCart(int position){
    purchaseCartList.removeAt(position);
    notifyListeners();
  }
  void addToSalesCart(ProductModel itemModel,double qty){
    if(null!= salesCartList && salesCartList.length>0){
      final index= salesCartList.indexWhere((data) =>
      data.productId.toString()==itemModel.productId.toString());
      if(index> -1  ){
        salesCartList[index].qty= qty;
        salesCartList[index].rate=itemModel.salesRate;

        salesCartList[index]=calculateSalesValues(salesCartList[index]);

      }else{

        SalesDetailsModel salesDetailModel=new SalesDetailsModel();
        salesDetailModel.qty=qty;
        salesDetailModel.rate=itemModel.salesRate;
        salesDetailModel.productName=itemModel.productName.toString();
        salesDetailModel.productId=itemModel.productId;
        salesDetailModel.unitId=itemModel.unitId;
        salesDetailModel.taxId=itemModel.taxId;
        salesDetailModel.downId=itemModel.downId;
        salesDetailModel.rackId=itemModel.rackId;
        salesDetailModel.unitName=itemModel.unitName;
        salesDetailModel.mrp=itemModel.mrp;
        salesDetailModel=calculateSalesValues(salesDetailModel);


        salesCartList.add(salesDetailModel);


      }

    } else {
      SalesDetailsModel salesDetailModel=new SalesDetailsModel();
      salesDetailModel.qty=qty;
      salesDetailModel.rate=itemModel.salesRate;
      salesDetailModel.productName=itemModel.productName.toString();
      salesDetailModel.productId=itemModel.productId;
      salesDetailModel.unitId=itemModel.unitId;
      salesDetailModel.taxId=itemModel.taxId;
      salesDetailModel.downId=itemModel.downId;
      salesDetailModel.rackId=itemModel.rackId;
      salesDetailModel.unitName=itemModel.unitName;
      salesDetailModel.mrp=itemModel.mrp;
      salesDetailModel =calculateSalesValues(salesDetailModel);

      salesCartList.add(salesDetailModel);

    }

    notifyListeners();
  }
  void addToSalesReturnCart(ProductModel itemModel,double qty){
    if(null!= salesReturnCartList && salesReturnCartList.length>0){
      final index= salesReturnCartList.indexWhere((data) =>
      data.productId.toString()==itemModel.productId.toString());
      if(index> -1  ){
        salesReturnCartList[index].qty= qty;
        salesReturnCartList[index].rate=itemModel.salesRate;

        salesReturnCartList[index]=calculateSalesReturnValues(salesReturnCartList[index]);

      }else{

        SalesReturnDetailModel salesReturnDetailModel=new SalesReturnDetailModel();
        salesReturnDetailModel.qty=qty;
        salesReturnDetailModel.rate=itemModel.salesRate;
        salesReturnDetailModel.productName=itemModel.productName.toString();
        salesReturnDetailModel.productId=itemModel.productId;
        salesReturnDetailModel.unitId=itemModel.unitId;
        salesReturnDetailModel.taxId=itemModel.taxId;
        salesReturnDetailModel.downId=itemModel.downId;
        salesReturnDetailModel.rackId=itemModel.rackId;
        salesReturnDetailModel.unitName=itemModel.unitName;
        // salesReturnDetailModel.mrp=itemModel.mrp;
        salesReturnDetailModel=calculateSalesReturnValues(salesReturnDetailModel);


        salesReturnCartList.add(salesReturnDetailModel);


      }

    } else {
      SalesReturnDetailModel salesReturnDetailModel=new SalesReturnDetailModel();
      salesReturnDetailModel.qty=qty;
      salesReturnDetailModel.rate=itemModel.salesRate;
      salesReturnDetailModel.productName=itemModel.productName.toString();
      salesReturnDetailModel.productId=itemModel.productId;
      salesReturnDetailModel.unitId=itemModel.unitId;
      salesReturnDetailModel.taxId=itemModel.taxId;
      salesReturnDetailModel.downId=itemModel.downId;
      salesReturnDetailModel.rackId=itemModel.rackId;
      salesReturnDetailModel.unitName=itemModel.unitName;
      // salesReturnDetailModel.mrp=itemModel.mrp;
      salesReturnDetailModel =calculateSalesReturnValues(salesReturnDetailModel);

      salesReturnCartList.add(salesReturnDetailModel);

    }

    notifyListeners();
  }

}