
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
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



class AddStaffScreen extends  StatefulWidget{
  AddStaffScreen(this.staffModel,this.type);

  int?type;
  StaffModel staffModel = new StaffModel();


  @override
  State<StatefulWidget> createState() {
    return _AddStaffScreenState(staffModel);
  }
}

class _AddStaffScreenState extends State<AddStaffScreen>{
  _AddStaffScreenState(this.selectedStaff);

  StaffModel selectedStaff=new StaffModel();


  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;



  @override

  TextEditingController addressController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  List<StaffModel> staffList = [];

  String? mySelection;
  bool isStaffAdding=false;
  bool  isStaffLoading= false;

  @override
  void initState() {

    if(widget.type==2 || widget.type==3) {
      nameController.text = selectedStaff.name.toString();
      addressController.text = selectedStaff.address.toString();
      numberController.text = selectedStaff.phone.toString();
      emailController.text = selectedStaff.email.toString();

    }

    getAllStaff();

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
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' UserName', 'Enter username'),
                            controller: nameController,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Password', 'Enter password'),
                            controller: nameController,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Name', 'Enter staff name'),
                            controller: nameController,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter email"),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Mobile Number ', 'Enter phone number'),
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]+')),
                            ],
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),

                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Address", "Enter address"),
                            controller: addressController,
                            validator: (val) {
                              if (!(val!.isEmpty)) {
                                return "Enter a valid address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: () {
                            selectedStaff.name=nameController.text;
                            selectedStaff.address=addressController.text;
                            selectedStaff.email=emailController.text;
                            selectedStaff.phone=numberController.text;

                            if (nameController
                                .text.isEmpty) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please type Staff Name",
                                  animationType:
                                  ANIMATION
                                      .FROM_LEFT,
                                  position:
                                  MOTION_TOAST_POSITION
                                      .TOP,
                                  width: 300)
                                  .show(context);
                            }

                            else if (emailController
                                .text.isEmpty) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please type Email",
                                  animationType:
                                  ANIMATION
                                      .FROM_LEFT,
                                  position:
                                  MOTION_TOAST_POSITION
                                      .TOP,
                                  width: 300)
                                  .show(context);
                            }else if (!EmailValidator
                                .validate(
                                emailController
                                    .text)) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please enter valid Email",
                                  animationType:
                                  ANIMATION
                                      .FROM_LEFT,
                                  position:
                                  MOTION_TOAST_POSITION
                                      .TOP,
                                  width: 300)
                                  .show(context);
                            }
                            else if (addressController
                                .text.isEmpty) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please type Address",
                                  animationType:
                                  ANIMATION
                                      .FROM_LEFT,
                                  position:
                                  MOTION_TOAST_POSITION
                                      .TOP,
                                  width: 300)
                                  .show(context);
                            }
                            else if (numberController
                                .text.isEmpty) {
                              MotionToast.error(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                  description:
                                  "Please type Number",
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
                              addEditStaff(selectedStaff,null !=
                                  selectedStaff
                                      .employeeId &&
                                  selectedStaff
                                      .employeeId! >
                                      0);
                            }
                          },
                          child: Container(
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
                                  selectedStaff
                                      .employeeId &&
                                  selectedStaff
                                      .employeeId! >
                                      0
                                  ? "Update Staff".toUpperCase()
                                  : "Add Staff".toUpperCase(),
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

  Future getAllStaff() async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.STAFF_URL;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    staffList = List<StaffModel>.from(data.map((x) => StaffModel.fromJson(x)));
    setState(() {

    });
  }

  Future<bool?> addEditStaff(
      StaffModel staffDetailsModel, bool isEdit) async {
    String url = "";
    if (isEdit) {
      url = Apis.EDIT_STAFF_URL;
    } else {
      url = Apis.ADD_STAFF_URL;
    }
    // staffDetailsModel.status = 1;

    String dataJson = staffModelToJson(staffDetailsModel);

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

        selectedStaff = new StaffModel();

        nameController.text = "";
        emailController.text = "";
        addressController.text = "";
        numberController.text = "";

        setState(() {});
        getAllStaff();
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