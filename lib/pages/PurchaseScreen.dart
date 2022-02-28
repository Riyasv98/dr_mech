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
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PurchaseScreenState();
  }
}

class _PurchaseScreenState extends State<PurchaseScreen>
    with SingleTickerProviderStateMixin {
  StaffModel selectedStaff = new StaffModel();
  ProductModel selectedProduct = new ProductModel();
  StaffModel staffModel = new StaffModel();
  List<ProductModel> productList = [];

  bool isLoading = false;
  TabController? tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);

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
        title: Text("Purchase"),
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
                Container(
                  height: MediaQuery.of(context)
                      .size
                      .height /
                      14,
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      1.1,
                  color: Colors.white,
                  child: TextFormField(
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
                                            Text("0")
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
                                            Text("0")
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
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              "Sl.No.",style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                              // textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            "Name",style: TextStyle(
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
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Qty",
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Rate",
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Disc",
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Tax",
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Total",
                                            // textAlign: TextAlign.left,
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
                                      .purchaseCartList.length,
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
                                              padding: const EdgeInsets.only(bottom: 5.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: Text([index + 1]
                                                        .toString(),style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  ),
                                                  Text(
                                                    productProvider
                                                        .purchaseCartList[index]
                                                        .productName
                                                        .toString(),style: TextStyle(
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
                                                  flex:1,
                                                  child: Text(
                                                    productProvider
                                                        .purchaseCartList[index]
                                                        .unitName
                                                        .toString(),
                                                    // textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Expanded(
                                                  child:null!=  productProvider
                                                      .purchaseCartList[index].qty?
                                                  Text(
                                                    productProvider
                                                        .purchaseCartList[index]
                                                        .qty!
                                                        .toStringAsFixed(2),
                                                    // textAlign: TextAlign.left,
                                                  ):Text("0"),
                                                ),
                                                Expanded(
                                                  child:null!=productProvider
                                                      .purchaseCartList[index].rate?
                                                  Text(
                                                    productProvider
                                                        .purchaseCartList[index]
                                                        .rate!
                                                        .toStringAsFixed(2),
                                                    // textAlign: TextAlign.left,
                                                  ):Text("0"),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child:null!=  productProvider
                                                      .purchaseCartList[index].discount?
                                                  Text(
                                                    productProvider
                                                        .purchaseCartList[index]
                                                        .discount!
                                                        .toStringAsFixed(2),
                                                    textAlign:
                                                    TextAlign.left,
                                                  ):Text("0"),
                                                ),
                                                Expanded(
                                                    child:null!=  productProvider
                                                        .purchaseCartList[index].taxAmount?
                                                    Text(
                                                      productProvider
                                                          .purchaseCartList[index]
                                                          .taxAmount!
                                                          .toStringAsFixed(2),
                                                      textAlign:
                                                      TextAlign.left,
                                                    ):Text("0")
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child:null!= productProvider
                                                        .purchaseCartList[index].amount?
                                                    Text(
                                                      productProvider
                                                          .purchaseCartList[index]
                                                          .amount!
                                                          .toStringAsFixed(2),
                                                      textAlign:
                                                      TextAlign.left,
                                                    ):Text("0")
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
                                          Theme.of(context)
                                              .primaryColor,
                                          Theme.of(context)
                                              .accentColor,
                                        ])),
                                child: Padding(
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
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "Name",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Unit",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Group",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Sales Rate",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "MRP",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "Barcode",
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                    FocusScope.of(context).requestFocus(FocusNode());
                    productProvider.addToPurchaseCart(
                        productProvider.filteredItemList[index], 1);
                    productProvider.filteredItemList = [];
                  },
                );
              })
              : Container(
            height: 0,
          );
        });
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
