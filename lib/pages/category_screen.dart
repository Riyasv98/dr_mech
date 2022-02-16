import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/models/GroupModel.dart';
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

class CategoryScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _formKey = GlobalKey<FormState>();


  GroupModel selectedGroupModel = new GroupModel();
  StaffModel staffModel = new StaffModel();

  TextEditingController groupNameController = new TextEditingController();
  TextEditingController groupUnderController = new TextEditingController();

  List<GroupModel> groupModelList = [];
  List<GroupModel> subgroupModelList = [];
  List<GroupModel> selectedgroupModelList = [];
  bool isLoading = false;

  @override
  void initState() {

    PreferenceFile().getStaffData().then((value) {
      staffModel = value;
      getAllGroup(staffModel.cmpId.toString(), staffModel.brnId.toString());
    });

    // getAllCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
        title: Text("Group"),
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
                    decoration: ThemeHelper().textInputDecoration(
                        ' Group Name', 'Enter group name'),
                    controller: groupNameController,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: groupUnderController,
                    readOnly: true,
                    decoration: ThemeHelper().textInputDecoration(
                        ' Group under', ),
                    onTap: (){
                      groupDialog(context, selectedgroupModelList).then((value) {
                        if(null!=value){
                          selectedGroupModel.groupUnder=value.groupId;
                          groupUnderController.text=value.groupName!;
                          setState(() {

                          });
                        }
                      });
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    selectedGroupModel.groupName = groupNameController.text;
                    selectedGroupModel.brnId = staffModel.brnId;
                    selectedGroupModel.cmpId = staffModel.cmpId;

                    if (groupNameController.text.isEmpty) {
                      MotionToast.error(
                              title: "Error",
                              titleStyle: TextStyle(
                                  fontWeight: FontWeight.bold),
                              description: "Please type group Name",
                              animationType: ANIMATION.FROM_LEFT,
                              position: MOTION_TOAST_POSITION.TOP,
                              width: 300)
                          .show(context);
                    } else {
                      addEditGroup(
                          selectedGroupModel,
                          null != selectedGroupModel.groupId &&
                              selectedGroupModel.groupId! > 0);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10)),
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
                        null != selectedGroupModel.groupId &&
                                selectedGroupModel.groupId! > 0
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
                isLoading
                    ? Center(
                  child:
                  CircularProgressIndicator(),
                )
                    :null!=groupModelList && groupModelList.length > 0?

                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupModelList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height/10,
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0,top:2),
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
                                            selectedGroupModel=groupModelList[index];
                                            // Constants.deleteDialog(context,categoryList[index].categoryName.toString()).then((value) {
                                            //   if (value) {
                                            //     deleteCategory(selectedCategory.categoryId!.toInt(),selectedCategory.cmpId!.toInt(),selectedCategory.brnId!.toInt());
                                            //   }
                                            // });
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
                                            child: Text("Category Name :"),
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
                                            child: Text(groupModelList[index].groupName.toString(),textAlign: TextAlign.left,),
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
                      "No data found"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<GroupModel> groupDialog(
      BuildContext context, List<GroupModel> groupModelList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // insetPadding: EdgeInsets.only(
          //   left: MediaQuery.of(context).size.width/9,
          //   right: MediaQuery.of(context).size.width/9,
          //   // bottom: MediaQuery.of(context).size.height/5,
          //   // top: MediaQuery.of(context).size.height/5
          //   // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
          //   // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          // ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select group",
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
                itemCount: groupModelList.length,
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
                              groupModelList[position].groupName.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(groupModelList[position]);
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
  Future getAllGroup(String companyId, String branchId) async {
    isLoading = true;
    setState(() {});

    String url = Apis.GROUP_URL + companyId + "/" + branchId;
    var response = await http.get(Uri.parse(url));

    isLoading = false;
    setState(() {});

    String responseData = response.body.toString();
    var jsonData = jsonDecode(responseData);
    var data = jsonData['data'];
    selectedgroupModelList = [];
    subgroupModelList = [];
    groupModelList =
        List<GroupModel>.from(data.map((x) => GroupModel.fromJson(x)));
    for (GroupModel groupModel in groupModelList) {
      if (groupModel.groupUnder == 0) {
        selectedgroupModelList.add(groupModel);
      } else if (groupModel.groupUnder! >0) {
        subgroupModelList.add(groupModel);
      }
    }
    selectedgroupModelList.insert(0,GroupModel(groupId: 0,groupUnder: -1,groupName: "Primary"));

    setState(() {});
  }

  Future<bool?> addEditGroup(
      GroupModel groupModel, bool isEdit) async {
    String url = "";
    if (isEdit) {
      url = Apis.EDIT_GROUP;
    } else {
      url = Apis.ADD_GROUP;
    }
    // staffDetailsModel.status = 1;

    String dataJson = groupModelToJson(groupModel);

    var data = jsonEncode({"jsonData": dataJson});

    EasyLoading.show(status: "Please wait");

    final response = await http.post(Uri.parse(url), body: data);
    // isUniversityAdding=false;
    setState(() {});

    if (response.statusCode == 200) {
      String responseString = response.body;

      var jsonObject = jsonDecode(responseString)['errorData'] as List;
      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showSuccess(jsonObject[0]["message"]);

        selectedGroupModel = new GroupModel();

        groupNameController.text = "";

        setState(() {});
        getAllGroup(staffModel.cmpId.toString(), staffModel.brnId.toString());
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
