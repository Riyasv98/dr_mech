import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/common/Provider.dart';
import 'package:dr_mech/models/GroupModel.dart';
import 'package:dr_mech/models/ProductModelFile.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_mech/common/theme_helper.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../models/ledger_posting_model.dart';
import '../models/sales_detail_model.dart';
import '../models/sales_header_model.dart';
import '../models/stock_posting_model.dart';

class SalesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalesScreenState();
  }
}

class _SalesScreenState extends State<SalesScreen>
    with SingleTickerProviderStateMixin {
  StaffModel selectedStaff = new StaffModel();
  StaffModel staffModel = new StaffModel();
  List<ProductModel> productList = [];

  bool isLoading = false;
  TabController? tabController;

  TextEditingController quantityController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  double cgstTotal = 0;
  double sgstTotal = 0;
  double totalAmt = 0;
  double billDiscount = 0;
  double grandTotal = 0,
      qty = 0;
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .clearPurchaseCart();
    });

    tabController = new TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      setState(() {

      });

    });
    PreferenceFile().getStaffData().then((value) {
      staffModel = value;
      getAllProduct();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        title: Text("Sales"),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 120,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: null != tabController && tabController!.index==0,
                  child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  height: MediaQuery.of(context)
                      .size
                      .height /
                      17,
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      1.1,
                  // color: Colors.white,
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: searchController,
                      onChanged: (text) {
                        Provider.of<ProductProvider>(
                            context,
                            listen: false)
                            .filterItems(text);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon:
                          Icon(Icons.search)),
                      onTap: () {},
                    ),
                  ),
                ),),
                searchListView(),
                // SizedBox(
                //   height: 10,
                // ),
                TabBar(controller: tabController, tabs: [
                  Tab(
                    text: "Cart",
                  ),
                  Tab(
                    text: "Items",
                  ),
                ]),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Colors.deepOrangeAccent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(
                                              bottom: 5.0),
                                      child: Text(
                                        "Summary",
                                        style: TextStyle(
                                            fontSize: 10),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Qty: ",
                                              textAlign:
                                                  TextAlign.left,
                                            ),
                                            Text(qty.toString())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Disc: ",
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                            Text("0")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Net: ",
                                              textAlign:
                                              TextAlign.left,
                                            ),
                                            Text(grandTotal.toString())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.black12,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "Sl.No.", style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                              // textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            "Name", style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                            // textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Unit",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Qty",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Rate",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Disc",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Tax",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Total",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Consumer<ProductProvider>(builder:
                                (context, productProvider,
                                child) {
                              return ListView.builder(
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productProvider
                                      .salesCartList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 1,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 8.0),
                                                    child: Text([index + 1]
                                                        .toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),),
                                                  ),
                                                  Text(
                                                    productProvider
                                                        .salesCartList[index]
                                                        .productName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold
                                                    ),
                                                    // textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    productProvider
                                                        .salesCartList[index]
                                                        .unitName
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: null != productProvider
                                                      .salesCartList[index].qty
                                                      ?
                                                  Text(
                                                    productProvider
                                                        .salesCartList[index]
                                                        .qty!
                                                        .toStringAsFixed(2),
                                                    textAlign: TextAlign.start,
                                                  )
                                                      : Text("0",
                                                    textAlign: TextAlign
                                                        .start,),
                                                ),
                                                Expanded(
                                                  child: null != productProvider
                                                      .salesCartList[index].rate
                                                      ?
                                                  Text(
                                                    productProvider
                                                        .salesCartList[index]
                                                        .rate!
                                                        .toStringAsFixed(2),
                                                    textAlign: TextAlign.right,
                                                  )
                                                      : Text("0",
                                                    textAlign: TextAlign
                                                        .right,),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: null != productProvider
                                                      .salesCartList[index]
                                                      .discount ?
                                                  Text(
                                                    productProvider
                                                        .salesCartList[index]
                                                        .discount!
                                                        .toStringAsFixed(2),
                                                    textAlign: TextAlign.right,
                                                  ) : Text("0",
                                                    textAlign: TextAlign
                                                        .right,),
                                                ),
                                                Expanded(
                                                    child: null !=
                                                        productProvider
                                                            .salesCartList[index]
                                                            .taxAmount ?
                                                    Text(
                                                      productProvider
                                                          .salesCartList[index]
                                                          .taxAmount!
                                                          .toStringAsFixed(2),
                                                      textAlign: TextAlign
                                                          .right,
                                                    ) : Text("0",
                                                      textAlign: TextAlign
                                                          .right,)
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: null !=
                                                        productProvider
                                                            .salesCartList[index]
                                                            .amount ?
                                                    Text(
                                                      productProvider
                                                          .salesCartList[index]
                                                          .amount!
                                                          .toStringAsFixed(2),
                                                      textAlign: TextAlign
                                                          .right,
                                                    ) : Text("0",
                                                      textAlign: TextAlign
                                                          .right,)
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(10)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end:
                                        Alignment.bottomRight,
                                        colors: <Color>[
                                          Theme
                                              .of(context)
                                              .primaryColor,
                                          Theme
                                              .of(context)
                                              .accentColor,
                                        ])),
                                child: InkWell(
                                  child:
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20, 5, 20, 5),
                                    child: Text(
                                      "Save".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    if (null !=
                                        Provider
                                            .of<ProductProvider>(
                                            context,
                                            listen:
                                            false)
                                            .salesCartList &&
                                        Provider
                                            .of<ProductProvider>(
                                            context,
                                            listen:
                                            false)
                                            .salesCartList
                                            .length >
                                            0) {
                                      calculateSalesSummary();
                                      SalesHeaderModel
                                      model =
                                      new SalesHeaderModel();
                                      // model.date =
                                      //     dateController
                                      //         .text;
                                      // model.invoicedate=voucherInvoiceNumberController.text;

                                      // model.gstIn=purchaseAccController.text;
                                      // model.supplier=purchaseAccController.text;
                                      model.extraDate =
                                          DateTime.now()
                                              .toString();
                                      model.salesAccount =
                                      10;


                                      // model.cgst=lrNoController.text;
                                      // model.sgst=lrNoController.text;
                                      model.totalAmount = totalAmt;
                                      model.billDiscount = billDiscount;
                                      model.grandTotal = grandTotal;

                                      double totalCgst = cgstTotal;

                                      double totalSgst = sgstTotal;

                                      model.taxAmount =
                                      (totalSgst +
                                          totalCgst);
                                      model.voucherTypeId =
                                      19;

                                      createSales(model);
                                      setState(() {

                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              color: Colors.black12,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "Sl.No.", style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                              // textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            "Item name", style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                            // textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Unit",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Rate",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Stock",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                           null != productList &&
                                  productList.length > 0 ?
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: productList
                                      .length,
                                  itemBuilder: (context, position) {
                                    return Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Card(
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    12.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(right: 8.0),
                                                      child: Text((position + 1)
                                                          .toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold
                                                        ),),
                                                    ),
                                                    Text(
                                                     productList[position]
                                                          .productName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),
                                                      // textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),


                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 33.0),
                                                child:
                                                Row(
                                                    children: [

                                                      Expanded(
                                                        child: Text(
                                                          null !=
                                                              productList[position]
                                                                  .unitName
                                                              ? productList[position]
                                                              .unitName.
                                                          toString()
                                                              : "",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          ),
                                                          // textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          productList[position]
                                                              .salesRate
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          ),
                                                          // textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ]
                                                ),),
                                            ]
                                        ),
                                      ),
                                    );
                                  }) : Container(
                                height: 0,
                              )

                          ],
                        ),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchListView() {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return null != productProvider.filteredItemList &&
              productProvider.filteredItemList.length > 0
              ? ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productProvider.filteredItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(productProvider
                          .filteredItemList[index].productName
                          .toString()),
                    ),
                  ),
                  onTap: () {
                    qtyDialog(context, productProvider.filteredItemList[index]);
                    Provider
                        .of<ProductProvider>(context, listen: false)
                        .filteredItemList = [];
                    searchController.clear();
                    //.then((value) {
                    //   FocusScope.of(context).requestFocus(FocusNode());
                    //   ProductModel productModel = new ProductModel();
                    //   productModel =  productProvider.filteredItemList[index];
                    //   productModel.salesRate= null!=value?double.parse(value[1]):0;
                    //
                    //   productProvider.addToSalesCart(
                    //       productModel, null!=value?double.parse(value[0]):1);
                    //
                    //   productProvider.filteredItemList = [];
                    //   searchController.clear();
                    //   quantityController.clear();
                    //   rateController.clear();
                    // }
                    // );
                  },
                );
              })
              : Container(
            height: 0,
          );
        });
  }

  void calculateSalesSummary() {
    cgstTotal = 0;
    sgstTotal = 0;
    totalAmt = 0;
    billDiscount = 0;
    grandTotal = 0;
    qty = 0;

    if (null !=
        Provider
            .of<ProductProvider>(context, listen: false)
            .salesCartList &&
        Provider
            .of<ProductProvider>(context, listen: false)
            .salesCartList
            .length >
            0) {
      for (SalesDetailsModel salesDetailModel
      in Provider
          .of<ProductProvider>(context, listen: false)
          .salesCartList) {
        cgstTotal = cgstTotal +
            (null != salesDetailModel.cgstAmt
                ? salesDetailModel.cgstAmt! * salesDetailModel.qty!
                : 0);
        sgstTotal = sgstTotal +
            (null != salesDetailModel.sgstAmt
                ? salesDetailModel.sgstAmt! * salesDetailModel.qty!
                : 0);

        totalAmt = totalAmt + salesDetailModel.amount!;
        qty = qty + (null != salesDetailModel.qty ? salesDetailModel.qty! : 0);
      }
    }

    grandTotal = (totalAmt - billDiscount);
    setState(() {

    });
  }

  Future qtyDialog(BuildContext context, ProductModel productModel) async {
    rateController.text = productModel.salesRate.toString();
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Quantity",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),

            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                child: TextFormField(
                  decoration: ThemeHelper().textInputDecoration(
                      ' Quantity', 'Enter quantity'),
                  controller: quantityController,
                ),
                decoration: ThemeHelper()
                    .inputBoxDecorationShaddow(),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                child: TextFormField(
                  decoration: ThemeHelper().textInputDecoration(
                      ' Rate', 'Enter purchase rate'),
                  controller: rateController,
                ),
                decoration: ThemeHelper()
                    .inputBoxDecorationShaddow(),
              ),
            ),
            SizedBox(height: 20,),

            GestureDetector(
              child: const Align(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Save"),
                      )
                  ),
                ),
                alignment: Alignment.center,
              ),
              onTap: () {
                Provider.of<ProductProvider>(context, listen: false).
                addToSalesCart(
                    productModel, double.parse(quantityController.text));
                calculateSalesSummary();
                Provider
                    .of<ProductProvider>(context, listen: false)
                    .filteredItemList = [];
                searchController.clear();
                quantityController.clear();
                rateController.clear();
                Navigator.of(context).pop();
                setState(() {});
              },
            ),


          ],
        );
      },
    );
  }

  Future createSales(SalesHeaderModel salesHeaderModel) async {
    // isAddingSalesData = true;
    setState(() {});
    String salesDetailJson = "";
    String salesHdrJson = "";
    String ledgerPostingJson = "";
    String stockPostingJson = "";
    List<LedgerPostingModel> ledgerPostingList = [];

    LedgerPostingModel ledgerPostingModelOne = new LedgerPostingModel();
    ledgerPostingModelOne.date = salesHeaderModel.date;
    ledgerPostingModelOne.voucherTypeId = salesHeaderModel.voucherTypeId;
    ledgerPostingModelOne.voucherNo = salesHeaderModel.voucherNo;
    ledgerPostingModelOne.ledgerId = salesHeaderModel.ledgerId;
    ledgerPostingModelOne.debit = salesHeaderModel.grandTotal;
    ledgerPostingModelOne.credit = 0;
    ledgerPostingModelOne.detailsId = 0;
    ledgerPostingModelOne.yearId = 0;
    ledgerPostingModelOne.invoiceNo = salesHeaderModel.invoiceNo;
    ledgerPostingModelOne.chequeNo = "";
    ledgerPostingModelOne.chequeDate = "";
    ledgerPostingModelOne.extraDate = DateTime.now().toString();
    ledgerPostingModelOne.extra1 = "";
    ledgerPostingModelOne.extra2 = "";
    ledgerPostingList.add(ledgerPostingModelOne);

    LedgerPostingModel ledgerPostingModelTwo = new LedgerPostingModel();
    ledgerPostingModelTwo.date = salesHeaderModel.date;
    ledgerPostingModelTwo.voucherTypeId = salesHeaderModel.voucherTypeId;
    ledgerPostingModelTwo.voucherNo = salesHeaderModel.voucherNo;
    ledgerPostingModelTwo.ledgerId = 10; //sales account
    ledgerPostingModelTwo.debit = 0;
    ledgerPostingModelTwo.credit =
    (salesHeaderModel.grandTotal! - salesHeaderModel.taxAmount!);
    ledgerPostingModelTwo.detailsId = 0;
    ledgerPostingModelTwo.yearId = 0;
    ledgerPostingModelTwo.invoiceNo = salesHeaderModel.invoiceNo;
    ledgerPostingModelTwo.chequeNo = "";
    ledgerPostingModelTwo.chequeDate = "";
    ledgerPostingModelTwo.extraDate = DateTime.now().toString();
    ledgerPostingModelTwo.extra1 = "";
    ledgerPostingModelTwo.extra2 = "";
    ledgerPostingList.add(ledgerPostingModelTwo);

    // if(null!=salesHeaderModel.billDiscount && salesHeaderModel.billDiscount!>0) {
    //   LedgerPostingModel ledgerPostingModelThree = new LedgerPostingModel();
    //   ledgerPostingModelThree.date = salesHeaderModel.date;
    //   ledgerPostingModelThree.voucherTypeId = salesHeaderModel.voucherTypeId;
    //   ledgerPostingModelThree.voucherNo = salesHeaderModel.voucherNo;
    //   ledgerPostingModelThree.ledgerId = 8;//discount allowed
    //   ledgerPostingModelThree.debit = salesHeaderModel.billDiscount;
    //   ledgerPostingModelThree.credit = 0;
    //   ledgerPostingModelThree.detailsId = 0;
    //   ledgerPostingModelThree.yearId = 0;
    //   ledgerPostingModelThree.invoiceNo = salesHeaderModel.invoiceNo;
    //   ledgerPostingModelThree.chequeNo = "";
    //   ledgerPostingModelThree.chequeDate = "";
    //   ledgerPostingModelThree.extraDate = DateTime.now().toString();
    //   ledgerPostingModelThree.extra1 = "";
    //   ledgerPostingModelThree.extra2 = "";
    //   ledgerPostingList.add(ledgerPostingModelThree);
    // }
    LedgerPostingModel ledgerPostingModelFour = new LedgerPostingModel();
    ledgerPostingModelFour.date = salesHeaderModel.date;
    ledgerPostingModelFour.voucherTypeId = salesHeaderModel.voucherTypeId;
    ledgerPostingModelFour.voucherNo = salesHeaderModel.voucherNo;
    ledgerPostingModelFour.ledgerId = 13; //vat
    ledgerPostingModelFour.debit = 0;
    ledgerPostingModelFour.credit = salesHeaderModel.taxAmount;
    ledgerPostingModelFour.detailsId = 0;
    ledgerPostingModelFour.yearId = 0;
    ledgerPostingModelFour.invoiceNo = salesHeaderModel.invoiceNo;
    ledgerPostingModelFour.chequeNo = "";
    ledgerPostingModelFour.chequeDate = "";
    ledgerPostingModelFour.extraDate = DateTime.now().toString();
    ledgerPostingModelFour.extra1 = "";
    ledgerPostingModelFour.extra2 = "";
    ledgerPostingList.add(ledgerPostingModelFour);
    for (LedgerPostingModel ledgerPostingModel in ledgerPostingList) {
      ledgerPostingJson = ledgerPostingJson +
          ledgerPostingModelToJson(ledgerPostingModel) +
          ",";
    }

    for (SalesDetailsModel salesDetailModel
    in Provider
        .of<ProductProvider>(context, listen: false)
        .salesCartList) {
      salesDetailJson =
          salesDetailJson + salesDetailModelToJson(salesDetailModel) + ",";

      StockPostingModel stockPostingModel = new StockPostingModel();
      // stockPostingModel.date = dateController.text;
      stockPostingModel.voucherTypeId = 19; //when create opening stock give 2
      stockPostingModel.voucherNo = salesHeaderModel.voucherNo;
      stockPostingModel.invoiceNo = salesHeaderModel.invoiceNo;
      stockPostingModel.productId = salesDetailModel.productId;
      stockPostingModel.batchId = salesDetailModel.batchId;
      stockPostingModel.unitId = salesDetailModel.unitId;
      stockPostingModel.rackId = salesDetailModel.rackId;
      stockPostingModel.againstVoucherTypeId = "0";
      stockPostingModel.againstInvoiceNo = "NA";
      stockPostingModel.againstVoucherNo = "NA";
      stockPostingModel.inwardQty = 0;
      stockPostingModel.outwardQty = salesDetailModel.qty;
      stockPostingModel.rate = salesDetailModel.rate;
      stockPostingModel.financialYearId = 1;
      stockPostingModel.extraDate = DateTime.now().toString();
      stockPostingModel.extra1 = "";
      stockPostingModel.extra2 = "";

      stockPostingJson =
          stockPostingJson + stockPostingModelToJson(stockPostingModel) + ",";
    }
    salesHdrJson = salesModelToJson(salesHeaderModel);
    salesDetailJson = salesDetailJson.substring(0, salesDetailJson.length - 1);
    salesDetailJson = salesDetailJson.replaceAll('\\', "");

    stockPostingJson =
        stockPostingJson.substring(0, stockPostingJson.length - 1);
    stockPostingJson = stockPostingJson.replaceAll('\\', "");

    ledgerPostingJson =
        ledgerPostingJson.substring(0, ledgerPostingJson.length - 1);
    ledgerPostingJson = ledgerPostingJson.replaceAll('\\', "");

    var data = {
      "hdrData": salesHdrJson,
      "dtlData": '[' + salesDetailJson + ']',
      "ledgerData": '[' + ledgerPostingJson + ']',
      "stockData": '[' + stockPostingJson + ']',
    };

    var body = jsonEncode({"jsonData": data});

    setState(() {});
    String url = " ";
    if (null != salesHeaderModel.brnId && null != salesHeaderModel.cmpId) {
      url = Apis.ADD_SALE;
    } else {
      EasyLoading.showSuccess("Invalid branch id and company id");
    }
    // try {
    // Response response;
    // try {

    var response = await http.post(Uri.parse(url), body: body);

    //isAddingSalesData = false;
    setState(() {});

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonObject = jsonDecode(responseString)["errorData"] as List;

      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showSuccess(jsonObject[0]["message"]);

        // clearFields();
        cgstTotal = 0;
        sgstTotal = 0;
        totalAmt = 0;
        billDiscount = 0;
        grandTotal = 0;
        Provider.of<ProductProvider>(context, listen: false)
            .clearPurchaseCart();
        setState(() {});
      } else {
        EasyLoading.showSuccess(jsonObject[0]["message"]);
      }
    }
    // } on Exception catch (error) {
    //   Toast.show(error.toString(), context, duration: 2);
    //   // isUploadInvoice = false;
    //   setState(() {});
    // }
  }

  Future getAllProduct() async {
    isLoading = true;
    setState(() {});

    String url = Apis.PRODUCT_URL +
        staffModel.brnId.toString() +
        "/" +
        staffModel.cmpId.toString() +
        "/true/";
    var response = await http.get(Uri.parse(url));

    isLoading = false;
    setState(() {});

    String responseData = response.body.toString();
    var jsonData = jsonDecode(responseData); //check response string
    // if(jsonData['success']) {
    var data = jsonData['data']; //based on response string give array name
    productList =
        List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
    Provider.of<ProductProvider>(context, listen: false)
        .reloadItems(productList);

    setState(() {});
  }
}
