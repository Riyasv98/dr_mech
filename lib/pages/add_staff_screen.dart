
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/BranchModelFile.dart';
import 'package:dr_mech/models/CompanyModel.dart';
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
  TextEditingController passwordController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();

  List<StaffModel> staffList = [];
  List<CompanyModel> companyList = [];
  List<BranchModel> branchList = [];
  BranchModel selectedBranch=new BranchModel();
  CompanyModel selectedCompany=new CompanyModel();
  StaffModel staffModel = new StaffModel();

  String? mySelection;
  bool isStaffAdding=false;
  bool  isStaffLoading= false;

  @override
  void initState() {

    PreferenceFile().getStaffData().then((value)
    {
      staffModel=value;
      getAllStaff(staffModel.cmpId.toString(),staffModel.brnId.toString());
      setState(() {

      });
    });

    if(widget.type==2 || widget.type==3) {
      nameController.text = selectedStaff.name.toString();
      addressController.text = selectedStaff.address.toString();
      numberController.text = selectedStaff.phone.toString();
      emailController.text = selectedStaff.email.toString();
      selectedBranch.name=selectedStaff.branchName.toString();
      selectedCompany.name=selectedStaff.companyName.toString();
      // passwordController.text = selectedStaff.password.toString();
      // userNameController.text = selectedStaff.userName.toString();

    }
    getAllBranches();
    getCompanyDetails();

    super.initState();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
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
                        SizedBox(height: 15,),

                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                companyDialog(context, companyList).then((value) {
                                  if(null!=value){
                                    selectedCompany=value;
                                    selectedStaff.cmpId=selectedCompany.companyId;
                                    selectedStaff.companyName=selectedCompany.name;
                                    setState(() {

                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/1.25,
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
                                  padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Company",
                                          style:
                                          TextStyle(fontSize: 15, color: Colors.white),
                                        ),
                                        Icon(
                                            Icons.arrow_drop_down
                                        ),

                                        Text(null!=selectedCompany.name?selectedCompany.name.toString():"")

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            GestureDetector(
                              onTap: (){
                                branchDialog(context, branchList).then((value) {
                                  if(null!=value){
                                    selectedBranch=value;
                                    selectedStaff.brnId=selectedBranch.branchId;
                                    selectedStaff.branchName=selectedBranch.name;
                                    setState(() {

                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/1.25,
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
                                  padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Branch",
                                          style:
                                          TextStyle(fontSize: 15, color: Colors.white),
                                        ),
                                        Icon(
                                            Icons.arrow_drop_down
                                        ),

                                        Text(null!=selectedBranch.name?selectedBranch.name.toString():"")

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                               selectedStaff.name=nameController.text;
                               selectedStaff.email=emailController.text;
                               selectedStaff.address=addressController.text;
                               selectedStaff.phone=numberController.text;

                               selectedStaff.brnId=selectedBranch.branchId;
                               selectedStaff.branchName=selectedBranch.name;

                               selectedStaff.cmpId=selectedCompany.companyId;
                               selectedStaff.companyName=selectedCompany.name;

                               selectedStaff.brnId=staffModel.brnId;
                               selectedStaff.cmpId=staffModel.cmpId;


                               addEditStaff(
                                   selectedStaff,null !=
                                   selectedStaff
                                       .employeeId &&
                                   selectedStaff
                                       .employeeId! >
                                       0);
                             }
                            isLoading = true;
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

  Future getAllStaff(String companyId, String branchId) async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.STAFF_URL+companyId+"/"+branchId;
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
        getAllStaff(selectedStaff.cmpId.toString(),selectedStaff.brnId.toString());

        selectedStaff = new StaffModel();

        // userNameController.text = "";
        // passwordController.text = "";
        nameController.text = "";
        emailController.text = "";
        addressController.text = "";
        numberController.text = "";
        selectedCompany.name="";
        selectedBranch.name="";


        setState(() {});
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

  Future<CompanyModel> companyDialog(
      BuildContext context, List<CompanyModel> companyList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width/9,
            right: MediaQuery.of(context).size.width/9,
            // bottom: MediaQuery.of(context).size.height/5,
            // top: MediaQuery.of(context).size.height/5
            // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
            // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Company",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              GestureDetector(
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: companyList.length,
                itemBuilder: (ctx, position) {
                  return SimpleDialogOption(
                    child: GestureDetector(
                      child: Card(
                          color: Colors.grey[100],
                          elevation:0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              companyList[position].name.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(companyList[position]);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future<BranchModel> branchDialog(
      BuildContext context, List<BranchModel> branchList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width/9,
            right: MediaQuery.of(context).size.width/9,
            // bottom: MediaQuery.of(context).size.height/5,
            // top: MediaQuery.of(context).size.height/5
            // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
            // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Branch",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              GestureDetector(
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: branchList.length,
                itemBuilder: (ctx, position) {
                  return SimpleDialogOption(
                    child: GestureDetector(
                      child: Card(
                          color: Colors.grey[100],
                          elevation:0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              branchList[position].name.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(branchList[position]);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getCompanyDetails() async{
    isLoading=true;
    setState(() {

    });

    String url=Apis.COMPANY_URL;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    companyList = List<CompanyModel>.from(data.map((x) => CompanyModel.fromJson(x)));
    setState(() {

    });

  }

  Future getAllBranches() async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.BRANCH_URL;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    branchList = List<BranchModel>.from(data.map((x) => BranchModel.fromJson(x)));
    setState(() {

    });
  }

}