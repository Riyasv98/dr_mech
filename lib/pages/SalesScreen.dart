import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/common/Contants.dart';
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

class SalesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalesScreenState();
  }
}

class _SalesScreenState extends State<SalesScreen>
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
    // getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());

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
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),

            Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: MediaQuery.of(context).size.height/13,
                  width: MediaQuery.of(context).size.width/1.1,
                  color: Colors.white,
                ),
                isLoading
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                )
                    : null != productList && productList.length > 0
                    ? Column(
                  children: [
                    TabBar(controller: tabController, tabs: [
                      Tab(
                        text: "Cart",
                      ),
                      Tab(
                        text: "Items",
                      ),
                    ]),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                          controller: tabController,
                          children: [
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
                                ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: productList.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                productList[index]
                                                    .productName
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                productList[index]
                                                    .unitName
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                productList[index]
                                                    .groupName
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                productList[index]
                                                    .salesRate
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                productList[index]
                                                    .mrp
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                productList[index]
                                                    .barCode
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                              //     Row(
                                              //       mainAxisAlignment:
                                              //       MainAxisAlignment.end,
                                              //       children: [
                                              //         GestureDetector(
                                              //           onTap: () {
                                              //             isGroupUnderVisible =
                                              //             true;
                                              //             List<GroupModel>
                                              //             filtereGroupModelList =
                                              //             [];
                                              //
                                              //             selectedGroupModel =
                                              //             subgroupModelList[
                                              //             index];
                                              //             groupNameController
                                              //                 .text =
                                              //             subgroupModelList[
                                              //             index]
                                              //                 .groupName!;
                                              //             filtereGroupModelList = groupModelList
                                              //                 .where((element) =>
                                              //             element
                                              //                 .groupId ==
                                              //                 selectedGroupModel
                                              //                     .groupUnder)
                                              //                 .toList();
                                              //             groupUnderController
                                              //                 .text =
                                              //                 filtereGroupModelList[
                                              //                 0]
                                              //                     .groupName
                                              //                     .toString();
                                              //             setState(() {});
                                              //           },
                                              //           child: Padding(
                                              //             padding:
                                              //             const EdgeInsets
                                              //                 .only(
                                              //                 right: 8.0),
                                              //             child: Icon(
                                              //               Icons.edit,
                                              //               size: 20,
                                              //               color:
                                              //               Colors.grey,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         GestureDetector(
                                              //           onTap: () {
                                              //             selectedGroupModel =
                                              //             subgroupModelList[
                                              //             index];
                                              //             Constants.deleteDialog(
                                              //                 context,
                                              //                 subgroupModelList[
                                              //                 index]
                                              //                     .groupName
                                              //                     .toString())
                                              //                 .then((value) {
                                              //               if (value) {
                                              //                 deleteGroup(
                                              //                     selectedGroupModel);
                                              //               }
                                              //             });
                                              //           },
                                              //           child: Icon(
                                              //             Icons.delete,
                                              //             size: 20,
                                              //             color: Colors.red,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),

                            // ListView.builder(
                            //     physics:
                            //     NeverScrollableScrollPhysics(),
                            //     shrinkWrap: true,
                            //     itemCount: groupModelList.length,
                            //     itemBuilder: (context, index) {
                            //       return Visibility(
                            //         visible: groupModelList[index]
                            //             .groupId! >
                            //             0,
                            //         child: Card(
                            //           elevation: 1,
                            //           child: Padding(
                            //             padding:
                            //             const EdgeInsets.all(8.0),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment
                            //                   .spaceBetween,
                            //               children: [
                            //                 Text(
                            //                   groupModelList[index]
                            //                       .groupName
                            //                       .toString(),
                            //                   textAlign:
                            //                   TextAlign.left,
                            //                 ),
                            //                 Row(
                            //                   mainAxisAlignment:
                            //                   MainAxisAlignment
                            //                       .end,
                            //                   children: [
                            //                     GestureDetector(
                            //                       onTap: () {
                            //                         isGroupUnderVisible =
                            //                         false;
                            //                         selectedGroupModel =
                            //                         groupModelList[
                            //                         index];
                            //                         groupNameController
                            //                             .text =
                            //                         groupModelList[
                            //                         index]
                            //                             .groupName!;
                            //                         setState(() {});
                            //                       },
                            //                       child: Padding(
                            //                         padding:
                            //                         const EdgeInsets
                            //                             .only(
                            //                             right:
                            //                             8.0),
                            //                         child: Icon(
                            //                           Icons.edit,
                            //                           size: 20,
                            //                           color:
                            //                           Colors.grey,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     // GestureDetector(
                            //                     //   onTap: () {
                            //                     //     selectedGroupModel =
                            //                     //         groupModelList[
                            //                     //             index];
                            //                     //     Constants.deleteDialog(context,groupModelList[index].categoryName.toString()).then((value) {
                            //                     //       if (value) {
                            //                     //         // deleteCategory(selectedCategory.categoryId!.toInt(),selectedCategory.cmpId!.toInt(),selectedCategory.brnId!.toInt());
                            //                     //       }
                            //                     //     });
                            //                     //   },
                            //                     //   child: Icon(
                            //                     //     Icons.delete,
                            //                     //     size: 20,
                            //                     //     color: Colors.red,
                            //                     //   ),
                            //                     // ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }),
                            Column(
                              children: [
                                Padding(
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
                                ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: productList.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                productList[index]
                                                    .productName
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                              ),
                                        Text(
                                          productList[index]
                                              .unitName
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          productList[index]
                                              .groupName
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          productList[index]
                                              .salesRate
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          productList[index]
                                              .mrp
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          productList[index]
                                              .barCode
                                              .toString(),
                                          textAlign: TextAlign.left,
                                        ),
                                          //     Row(
                                          //       mainAxisAlignment:
                                          //       MainAxisAlignment.end,
                                          //       children: [
                                          //         GestureDetector(
                                          //           onTap: () {
                                          //             isGroupUnderVisible =
                                          //             true;
                                          //             List<GroupModel>
                                          //             filtereGroupModelList =
                                          //             [];
                                          //
                                          //             selectedGroupModel =
                                          //             subgroupModelList[
                                          //             index];
                                          //             groupNameController
                                          //                 .text =
                                          //             subgroupModelList[
                                          //             index]
                                          //                 .groupName!;
                                          //             filtereGroupModelList = groupModelList
                                          //                 .where((element) =>
                                          //             element
                                          //                 .groupId ==
                                          //                 selectedGroupModel
                                          //                     .groupUnder)
                                          //                 .toList();
                                          //             groupUnderController
                                          //                 .text =
                                          //                 filtereGroupModelList[
                                          //                 0]
                                          //                     .groupName
                                          //                     .toString();
                                          //             setState(() {});
                                          //           },
                                          //           child: Padding(
                                          //             padding:
                                          //             const EdgeInsets
                                          //                 .only(
                                          //                 right: 8.0),
                                          //             child: Icon(
                                          //               Icons.edit,
                                          //               size: 20,
                                          //               color:
                                          //               Colors.grey,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         GestureDetector(
                                          //           onTap: () {
                                          //             selectedGroupModel =
                                          //             subgroupModelList[
                                          //             index];
                                          //             Constants.deleteDialog(
                                          //                 context,
                                          //                 subgroupModelList[
                                          //                 index]
                                          //                     .groupName
                                          //                     .toString())
                                          //                 .then((value) {
                                          //               if (value) {
                                          //                 deleteGroup(
                                          //                     selectedGroupModel);
                                          //               }
                                          //             });
                                          //           },
                                          //           child: Icon(
                                          //             Icons.delete,
                                          //             size: 20,
                                          //             color: Colors.red,
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ]),
                    )
                  ],
                )
                    : Center(
                  child: Text("No data found"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getAllProduct() async {
    isLoading = true;
    setState(() {});

    String url = Apis.PRODUCT_URL + staffModel.brnId.toString() + "/" + staffModel.cmpId.toString();
    var response = await http.get(Uri.parse(url));

    isLoading = false;
    setState(() {});

    String responseData = response.body.toString();
    var jsonData = jsonDecode(responseData); //check response string
    // if(jsonData['success']) {
    var data = jsonData['data']; //based on response string give array name
    productList =
    List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
    setState(() {});
  }
}
