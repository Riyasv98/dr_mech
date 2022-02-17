import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/models/GroupModel.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:dr_mech/models/UnitModel.dart';
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

class UnitScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UnitScreenState();
  }
}

class _UnitScreenState extends State<UnitScreen>
    with SingleTickerProviderStateMixin {
  UnitModel selectedUnitModel = new UnitModel();
  StaffModel staffModel = new StaffModel();

  TextEditingController unitNameController = new TextEditingController();

  List<UnitModel> allUnitlList = [];

  bool isLoading = false;

  bool isUnitVisible = true;

  @override
  void initState() {

   getAllUnit();

    // getAllCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        title: Text("Units"),
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
                Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    decoration: ThemeHelper()
                        .textInputDecoration(' Unit Name', 'Enter unit'),
                    controller: unitNameController,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    selectedUnitModel.unitName = unitNameController.text;

                    if (unitNameController.text.isEmpty) {
                      MotionToast.error(
                          title: "Error",
                          titleStyle:
                          TextStyle(fontWeight: FontWeight.bold),
                          description: "Invalid unit Name",
                          animationType: ANIMATION.FROM_LEFT,
                          position: MOTION_TOAST_POSITION.TOP,
                          width: 300)
                          .show(context);
                    }  else {
                      addEditUnit(
                          selectedUnitModel,
                          null != selectedUnitModel.unitId &&
                              selectedUnitModel.unitId! > 0);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Theme.of(context).primaryColor,
                              Theme.of(context).accentColor,
                            ])),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        null != selectedUnitModel.unitId &&
                            selectedUnitModel.unitId! > 0
                            ? "Update".toUpperCase()
                            : "Add".toUpperCase(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                isLoading
                    ? Center(
                  child:
                  CircularProgressIndicator(),
                )
                    :null!=allUnitlList && allUnitlList.length > 0?

                    ListView.builder(
                        physics:
                        NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allUnitlList.length,
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
                                    allUnitlList[index]
                                        .unitName
                                        .toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          isUnitVisible =
                                          false;
                                          selectedUnitModel =
                                          allUnitlList[
                                          index];
                                          unitNameController
                                              .text =
                                          allUnitlList[
                                          index]
                                              .unitName!;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(
                                              right:
                                              8.0),
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                            color:
                                            Colors.grey,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          selectedUnitModel =
                                          allUnitlList[
                                          index];
                                          Constants.deleteDialog(
                                              context,
                                              allUnitlList[
                                              index]
                                                  .unitName
                                                  .toString())
                                              .then((value) {
                                            if (value) {
                                              deleteUnit(
                                                  selectedUnitModel);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
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

  Future getAllUnit() async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.UNIT_URL;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    allUnitlList = List<UnitModel>.from(data.map((x) => UnitModel.fromJson(x)));
    setState(() {

    });
  }


  Future<bool?> addEditUnit(
      UnitModel unitDetailsModel, bool isEdit) async {
    String url = "";
    if (isEdit) {
      url = Apis.EDIT_UNIT;
    } else {
      url = Apis.ADD_UNIT;
    }
    // staffDetailsModel.status = 1;

    String dataJson = unitModelToJson(unitDetailsModel);

    var data = jsonEncode({"jsonData": dataJson});

    EasyLoading.show(status: "Please wait");

    final response =
    await http.post(Uri.parse(url), body: data);
    // isUniversityAdding=false;
    setState(() {});

    if (response.statusCode == 200) {
      String responseString = response.body;

      var jsonObject = jsonDecode(responseString)['errorData'] as List;
      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showSuccess(jsonObject[0]["message"]);

        selectedUnitModel = new UnitModel();

        unitNameController.text = "";

        setState(() {});
        getAllUnit();
      } else {
        EasyLoading.showError(jsonObject[0]["message"]);
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch data');
    }

    String responseData = response.body.toString();
    var jsonData = jsonDecode(responseData); //check response string
    // if(jsonData['success']) {
    // var data = jsonData['data'];//based on response string give array name
    // locationList = List<LocationModel>.from(data.map((x) => LocationModel.fromJson(x)));
    setState(() {});
  }

  Future deleteUnit(UnitModel unitModel) async {
    EasyLoading.show(status: "Deleting unit");
    String? url;
    url = Apis.DELETE_UNIT +"/"+
        unitModel.unitId.toString();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonObject = jsonDecode(responseString)["errorData"] as List;

      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showInfo(jsonObject[0]["message"],
            duration: Duration(seconds: 5));
        selectedUnitModel = new UnitModel();
        unitNameController.clear();
        isUnitVisible = true;

        getAllUnit();
      } else {
        EasyLoading.showError(jsonObject[0]["message"],
            duration: Duration(seconds: 2));
      }
    } else {
      EasyLoading.showError("Something went wrong");
    }
  }
}
