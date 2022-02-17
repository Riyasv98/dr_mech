
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
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



class AddUnitScreen extends  StatefulWidget{
  AddUnitScreen(this.unitModel,this.type);

  int?type;
  UnitModel unitModel = new UnitModel();


  @override
  State<StatefulWidget> createState() {
    return _AddUnitScreenState(unitModel);
  }
}

class _AddUnitScreenState extends State<AddUnitScreen>{
  _AddUnitScreenState(this.selectedUnit);

  UnitModel selectedUnit=new UnitModel();


  final _formKey = GlobalKey<FormState>();





  @override

  TextEditingController nameController = new TextEditingController();

  List<UnitModel> unitList = [];

  bool isLoading = false;

  @override
  void initState() {

    if(widget.type==2 || widget.type==3) {
      nameController.text = selectedUnit.unitName.toString();

    }

    getAllUnit();

    super.initState();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(
                  150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                          child: SizedBox(height: 30,),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Unit', 'Enter unit'),
                            controller: nameController,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedUnit.unitName=nameController.text;

                            if (nameController
                                .text.isEmpty) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please type Unit Name",
                                  animationType:
                                  ANIMATION
                                      .FROM_LEFT,
                                  position:
                                  MOTION_TOAST_POSITION
                                      .TOP,
                                  width: 300)
                                  .show(context);
                            }
                            else {
                              addEditUnit(selectedUnit,null !=
                                  selectedUnit
                                      .unitId &&
                                  selectedUnit
                                      .unitId! >
                                      0);
                            }
                          },
                          child: Container(
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
                              child: Text(null !=
                                  selectedUnit
                                      .unitId &&
                                  selectedUnit
                                      .unitId! >
                                      0
                                  ? "Update".toUpperCase()
                                  : "Add".toUpperCase(),
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    unitList = List<UnitModel>.from(data.map((x) => UnitModel.fromJson(x)));
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

        selectedUnit = new UnitModel();

        nameController.text = "";

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
}