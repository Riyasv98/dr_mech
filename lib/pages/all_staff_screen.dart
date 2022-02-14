
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Models/BranchModelFile.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'add_staff_screen.dart';



class AllStaffScreen extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AllStaffScreenState();
  }
}

class _AllStaffScreenState extends State<AllStaffScreen>{

  final _formKey = GlobalKey<FormState>();



  @override

  bool isLoading = false;

  List<StaffModel> staffList = [];

  StaffModel staffModel = new StaffModel();

  StaffModel selectedStaff =new StaffModel();

  void initState() {

    PreferenceFile().getStaffData().then((value)
    {
      staffModel=value;
      getAllStaff(staffModel.cmpId.toString(),staffModel.brnId.toString());
      setState(() {

      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            child: Stack(
              children: [
                Container(
                  height: 150,
                  child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                  child: SizedBox(height: 20,),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push( context, MaterialPageRoute( builder: (context) => AddStaffScreen(new StaffModel(),1))).then((value){
                                  getAllStaff(staffModel.cmpId.toString(),staffModel.brnId.toString());
                                });
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0,bottom: 5),
                                  child: Icon(
                                    Icons.add_circle,color: Colors.grey,size: 40,
                                  ),
                                ),
                              ),
                            ),



                            isLoading
                                ? Center(
                              child:
                              CircularProgressIndicator(),
                            )
                                :null!=staffList && staffList.length > 0?

                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: staffList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height/4.5,
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top:2),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/6,
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push( context, MaterialPageRoute( builder: (context) => AddStaffScreen(staffList[index],2)));
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        selectedStaff=staffList[index];
                                                        Constants.deleteDialog(context,staffList[index].name.toString()).then((value) {
                                                          if (value) {
                                                            deleteStaff(selectedStaff.employeeId!.toInt(),selectedStaff.cmpId!.toString(),selectedStaff.brnId!.toString());
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
                                              ),
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text("Name :"),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text("Email Address :"),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text("Mobile Number :"),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text("Address :"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text(staffList[index].name.toString(),textAlign: TextAlign.left,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text(staffList[index].email.toString(),textAlign: TextAlign.left,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text(staffList[index].phone.toString(),textAlign: TextAlign.left,),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text(staffList[index].address.toString(),textAlign: TextAlign.left,),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                                : Center(
                              child: Text(
                                  "No document found"),
                            )





                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getAllStaff(String CompanyId, String BranchId) async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.STAFF_URL+CompanyId+"/"+BranchId;
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

  Future deleteStaff(int EmployeeId, String CompanyId, String BranchId) async {
    isLoading = true;
    setState(() {});
    String? url;
    url = Apis.DELETE_STAFF_URL + EmployeeId.toString()+"/"+ CompanyId.toString()+"/"+ CompanyId.toString();
    final response =
    await http.get(Uri.parse(url));

    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonObject = jsonDecode(responseString)["errorData"] as List;

      if (jsonObject[0]["error"] == 0) {
        setState(() {

        });
        EasyLoading.showSuccess(jsonObject[0]["message"]);
        getAllStaff(staffModel.cmpId.toString(),staffModel.brnId.toString());
      } else {
        EasyLoading.showError(jsonObject[0]["message"]);
      }
    } else {
      EasyLoading.showError("Something went wrong");
    }
  }

}