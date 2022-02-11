import 'package:dr_mech/common/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/header_widget.dart';
// import 'package:trust_fast/Ui/BottomBarScreen.dart';
// import 'package:trust_fast/Screens/DataFlowDocUploadScreen.dart';
// import 'package:trust_fast/Utils/AppColors.dart';

class AddSalesScreen extends StatefulWidget {
  @override
  AddSalesScreenState createState() =>
      new AddSalesScreenState();
}

class AddSalesScreenState
    extends State<AddSalesScreen> {
  bool isServiceDetailsSelected = false;
  bool isUserDetailsSelected = false;
  bool isItemsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(children: [
            Container(
              height: 150,
              child: HeaderWidget(
                  150, false, Icons.person_add_alt_1_rounded),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       right: 20, top: 30, bottom: 200),
                      //
                      // ),
                      SizedBox(
                        height: 200,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 2, bottom: 0),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(22),
                                    bottomLeft: Radius.circular(22),
                                    bottomRight:Radius.circular(22),
                                    topLeft: Radius.circular(22))),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Service Details",
                                          style:
                                          TextStyle(fontSize:20),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 5),
                                  child: MaterialButton(
                                    shape: CircleBorder(),
                                    // color:
                                    // AppColors().buttonColorsDarkBlue,
                                    onPressed: () {
                                      isServiceDetailsSelected=!isServiceDetailsSelected;
                                      isItemsSelected=false;
                                      isUserDetailsSelected=false;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(
                                      isServiceDetailsSelected?Icons.arrow_upward:Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Visibility(visible:isServiceDetailsSelected,child: itemsDetails()),
                      Visibility(visible:isServiceDetailsSelected,child: serviceDetailss()),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 2),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  bottomLeft: Radius.circular(22),
                                  bottomRight:Radius.circular(22),
                                  topLeft: Radius.circular(22))

                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Details",
                                          style:
                                          TextStyle(fontSize:20),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 5),
                                  child: MaterialButton(
                                    shape: CircleBorder(),
                                    // color:
                                    // AppColors().buttonColorsDarkBlue,
                                    onPressed: () {
                                      isUserDetailsSelected=!isUserDetailsSelected;
                                      isItemsSelected=false;
                                      isServiceDetailsSelected=false;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(
                                      isUserDetailsSelected?Icons.arrow_upward:Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Visibility(visible:isUserDetailsSelected,child: userDetails()),

                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 2),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(22),
                                    topLeft: Radius.circular(22),
                                    bottomRight: Radius.circular(22),
                                    bottomLeft: Radius.circular(22))),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Items",
                                          style:
                                          TextStyle(fontSize: 20,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 5),
                                  child: MaterialButton(
                                    shape: CircleBorder(),
                                    // color:
                                    // AppColors().buttonColorsDarkBlue,
                                    onPressed: () {

                                      isItemsSelected=!isItemsSelected;
                                      isUserDetailsSelected=false;
                                      isServiceDetailsSelected=false;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(
                                      isItemsSelected?Icons.arrow_upward:Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Visibility(visible:isItemsSelected,child: itemsDetails()),

                    ],
                  ),
                ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/18,
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[Theme
                                .of(context)
                                .primaryColor, Theme
                                .of(context)
                                .accentColor,
                            ]
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Center(
                        child: Text(
                          "Add".toUpperCase(),
                          style: TextStyle(fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),),
                      ),
                    ),
                  ),
              ],
            ),
          ]),
        ));
  }

  Widget itemsDetails() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 2),
      child:   Container(
        child: TextFormField(
          decoration: ThemeHelper().textInputDecoration(
              ' Title', 'Enter title'),
         // controller: nameController,
        ),
        decoration: ThemeHelper()
            .inputBoxDecorationShaddow(),
      ),
    );



  }
  Widget serviceDetailss() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 2),
      child:   Container(
        child: TextFormField(
          decoration: ThemeHelper().textInputDecoration(
              'Complaints', 'Enter complaints'),
          // controller: nameController,
        ),
        decoration: ThemeHelper()
            .inputBoxDecorationShaddow(),
      ),
    );



  }
  Widget userDetails() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 2),
      child:   Container(
        child: TextFormField(
          decoration: ThemeHelper().textInputDecoration(
              'Customer name', 'Enter Customer name'),
          // controller: nameController,
        ),
        decoration: ThemeHelper()
            .inputBoxDecorationShaddow(),
      ),
    );



  }
}
