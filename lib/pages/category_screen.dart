
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/CategoryModelFile.dart';
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



class AddCategoryScreen extends  StatefulWidget{
  AddCategoryScreen(this.categoryModel,this.type);

  int?type;
  CategoryModel categoryModel = new CategoryModel();

  @override
  State<StatefulWidget> createState() {
    return _AddCategoryScreenState(categoryModel);
  }
}

class _AddCategoryScreenState extends State<AddCategoryScreen>{
  _AddCategoryScreenState(this.selectedCategory);

  final _formKey = GlobalKey<FormState>();





  @override

  CategoryModel selectedCategory=new CategoryModel();

  StaffModel staffModel = new StaffModel();

  TextEditingController categoryNameController = new TextEditingController();


  List<CategoryModel> categoryList = [];
  bool isLoading = false;
  String? mySelection;

  @override
  void initState() {

    if(widget.type==2 || widget.type==3) {
      categoryNameController.text = selectedCategory.name.toString();

    }
    PreferenceFile().getStaffData().then((value)
        {
          staffModel=value;
          getAllCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
        });


    // getAllCategory();

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
                        // GestureDetector(
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           border: Border.all(
                        //               width: 5, color: Colors.white),
                        //           color: Colors.white,
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black12,
                        //               blurRadius: 20,
                        //               offset: const Offset(5, 5),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Category Name', 'Enter category name'),
                            controller: categoryNameController,
                          ),
                          decoration: ThemeHelper()
                              .inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: () {
                            selectedCategory.name=categoryNameController.text;
                            selectedCategory.brnId=staffModel.brnId;
                            selectedCategory.cmpId=staffModel.cmpId;

                            if (categoryNameController
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
                            else {
                              addEditCategory(selectedCategory,null !=
                                  selectedCategory
                                      .categoryId &&
                                  selectedCategory
                                      .categoryId! >
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
                              child: Text("Add".toUpperCase(),
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

  Future<bool?> addEditCategory(
      CategoryModel categoryDetailsModel, bool isEdit) async {
    String url = "";
    if (isEdit) {
      url = Apis.EDIT_CATEGORY;
    } else {
      url = Apis.ADD_CATEGORY;
    }
    // staffDetailsModel.status = 1;

    String dataJson = categoryModelToJson(categoryDetailsModel);

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

        selectedCategory = new CategoryModel();

        categoryNameController.text = "";

        setState(() {});
        // getAllStaff();
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