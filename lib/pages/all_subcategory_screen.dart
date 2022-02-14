
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:dr_mech/models/SubCategoryModelFile.dart';
import 'package:dr_mech/pages/subcategory_screen.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'category_screen.dart';


class AllSubCategoryScreen extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AllSubCategoryScreenState();
  }
}

class _AllSubCategoryScreenState extends State<AllSubCategoryScreen>{

  final _formKey = GlobalKey<FormState>();



  @override

  StaffModel selectedStaff =new StaffModel();
  SubCategoryModel selectedSubCategory =new SubCategoryModel();

  bool isLoading = false;

  // List<StaffModel> staffList = [];
  StaffModel staffModel = new StaffModel();

  List<SubCategoryModel> subCategoryList = [];
  List<CategoryModel> categoryList = [];

  void initState() {

    PreferenceFile().getStaffData().then((value)
    {
      staffModel=value;
      getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
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
                                Navigator.push( context, MaterialPageRoute( builder: (context) => AddSubCategoryScreen(new SubCategoryModel(),1))).then((value){
                                  getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
                                   //getAllCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
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
                                :null!=subCategoryList && subCategoryList.length > 0?

                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: subCategoryList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height/8,
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
                                                        Navigator.push( context, MaterialPageRoute( builder: (context) => AddSubCategoryScreen(subCategoryList[index],2)));
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
                                                        selectedSubCategory=subCategoryList[index];
                                                        Constants.deleteDialog(context,subCategoryList[index].subcategoryName.toString()).then((value) {
                                                          if (value) {
                                                            deleteSubCategory(selectedSubCategory.subcategoryId!.toInt(),selectedSubCategory.cmpId!.toInt(),selectedSubCategory.brnId!.toInt());
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
                                                        child: Text("Category :"),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text("SubCategory :"),
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
                                                        child: Text(subCategoryList[index].categoryName.toString(),textAlign: TextAlign.left,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                        child: Text(subCategoryList[index].subcategoryName.toString(),textAlign: TextAlign.left,),
                                                      ),
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

  Future getAllCategory(String companyId, String branchId) async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.CATEGORY_URL+companyId+"/"+branchId;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    categoryList = List<CategoryModel>.from(data.map((x) => CategoryModel.fromJson(x)));
    setState(() {

    });
  }

  Future getAllSubCategory(String companyId, String branchId) async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.SUBCATEGORY_URL+companyId+"/"+branchId;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    subCategoryList = List<SubCategoryModel>.from(data.map((x) => SubCategoryModel.fromJson(x)));
    setState(() {

    });
  }

  Future deleteSubCategory(int SubCategoryId, int CompanyId, int BranchId) async {
    isLoading = true;
    setState(() {});
    String? url;
    url = Apis.DELETE_SUBCATEGORY + SubCategoryId.toString()+"/"+CompanyId.toString()+"/"+BranchId.toString();
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
        getAllSubCategory(selectedSubCategory.cmpId.toString(),selectedSubCategory.brnId.toString());
      } else {
        EasyLoading.showError(jsonObject[0]["message"]);
      }
    } else {
      EasyLoading.showError("Something went wrong");
    }
  }

}