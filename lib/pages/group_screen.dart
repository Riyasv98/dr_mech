import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/EmailValidater.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/common/Contants.dart';
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

class GroupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GroupScreenState();
  }
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  GroupModel selectedGroupModel = new GroupModel();
  StaffModel staffModel = new StaffModel();

  TextEditingController groupNameController = new TextEditingController();
  TextEditingController groupUnderController = new TextEditingController();

  List<GroupModel> allGroupModelList = [];
  List<GroupModel> subgroupModelList = [];
  List<GroupModel> groupModelList = [];
  bool isLoading = false;
  TabController? tabController;
  bool isGroupUnderVisible = true;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);

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
        backgroundColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.4),
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
                    decoration: ThemeHelper()
                        .textInputDecoration(' Group Name', 'Enter group name'),
                    controller: groupNameController,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: isGroupUnderVisible,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: groupUnderController,
                      readOnly: true,
                      decoration: ThemeHelper().textInputDecoration(
                        ' Group under',
                      ),
                      onTap: () {
                        groupDialog(context, groupModelList).then((value) {
                          if (null != value) {
                            selectedGroupModel.groupUnder = value.groupId;
                            groupUnderController.text = value.groupName!;
                            setState(() {});
                          }
                        });
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
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
                              titleStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              description: "Invalid group Name",
                              animationType: ANIMATION.FROM_LEFT,
                              position: MOTION_TOAST_POSITION.TOP,
                              width: 300)
                          .show(context);
                    } else if (null == selectedGroupModel.groupUnder) {
                      MotionToast.error(
                              title: "Error",
                              titleStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              description: "Invalid group under",
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
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : null != allGroupModelList && allGroupModelList.length > 0
                        ? Column(
                            children: [
                              TabBar(controller: tabController, tabs: [
                                Tab(
                                  text: "Group",
                                ),
                                Tab(
                                  text: "Sub group",
                                ),
                              ]),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 2.0, horizontal:2),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                              //       borderRadius: BorderRadius.circular(5)
                              //     ),
                              //     child: Row(
                              //       children: [
                              //         Expanded(child: Padding(
                              //           padding: const EdgeInsets.all(3.0),
                              //           child: Text("Group"),
                              //         )),
                              //         Expanded(child: Padding(
                              //           padding: const EdgeInsets.all(3.0),
                              //           child: Text("Sub group"),
                              //         )),
                              //         Expanded(child: Text("")),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: TabBarView(
                                    controller: tabController,
                                    children: [

                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: groupModelList.length,
                                          itemBuilder: (context, index) {
                                            return Visibility(
                                              visible: groupModelList[index]
                                                      .groupId! >
                                                  0,
                                              child: Card(
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
                                                        groupModelList[index]
                                                            .groupName
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              isGroupUnderVisible =
                                                                  false;
                                                              selectedGroupModel =
                                                                  groupModelList[
                                                                      index];
                                                              groupNameController
                                                                      .text =
                                                                  groupModelList[
                                                                          index]
                                                                      .groupName!;
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
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     selectedGroupModel =
                                                          //         groupModelList[
                                                          //             index];
                                                          //     Constants.deleteDialog(context,groupModelList[index].categoryName.toString()).then((value) {
                                                          //       if (value) {
                                                          //         // deleteCategory(selectedCategory.categoryId!.toInt(),selectedCategory.cmpId!.toInt(),selectedCategory.brnId!.toInt());
                                                          //       }
                                                          //     });
                                                          //   },
                                                          //   child: Icon(
                                                          //     Icons.delete,
                                                          //     size: 20,
                                                          //     color: Colors.red,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: subgroupModelList.length,
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
                                                      subgroupModelList[index]
                                                          .groupName
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            isGroupUnderVisible =
                                                                true;
                                                            List<GroupModel>
                                                                filtereGroupModelList =
                                                                [];

                                                            selectedGroupModel =
                                                                subgroupModelList[
                                                                    index];
                                                            groupNameController
                                                                    .text =
                                                                subgroupModelList[
                                                                        index]
                                                                    .groupName!;
                                                            filtereGroupModelList = groupModelList
                                                                .where((element) =>
                                                                    element
                                                                        .groupId ==
                                                                    selectedGroupModel
                                                                        .groupUnder)
                                                                .toList();
                                                            groupUnderController
                                                                    .text =
                                                                filtereGroupModelList[
                                                                        0]
                                                                    .groupName
                                                                    .toString();
                                                            setState(() {});
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
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
                                                            selectedGroupModel =
                                                            subgroupModelList[
                                                                    index];
                                                            Constants.deleteDialog(
                                                                    context,
                                                                    subgroupModelList[
                                                                            index]
                                                                        .groupName
                                                                        .toString())
                                                                .then((value) {
                                                              if (value) {
                                                                deleteGroup(
                                                                    selectedGroupModel);
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
                                          }),
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
                          elevation: 0,
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
    groupModelList = [];
    subgroupModelList = [];
    isGroupUnderVisible = true;
    allGroupModelList =
        List<GroupModel>.from(data.map((x) => GroupModel.fromJson(x)));
    for (GroupModel groupModel in allGroupModelList) {
      if (groupModel.groupUnder == 0) {
        groupModelList.add(groupModel);
      } else if (groupModel.groupUnder! > 0) {
        subgroupModelList.add(groupModel);
      }
    }
    groupModelList.insert(
        0, GroupModel(groupId: 0, groupUnder: -1, groupName: "Primary"));

    setState(() {});
  }

  Future<bool?> addEditGroup(GroupModel groupModel, bool isEdit) async {
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

        groupNameController.clear();
        groupUnderController.clear();
        isGroupUnderVisible = true;
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

  Future deleteGroup(GroupModel groupModel) async {
    EasyLoading.show(status: "Deleting sub group");
    String? url;
    url = Apis.DELETE_GROUP +
        groupModel.groupId.toString() +
        "/" +
        groupModel.cmpId.toString() +
        "/" +
        groupModel.brnId.toString() +
        "/";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonObject = jsonDecode(responseString)["errorData"] as List;

      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showInfo(jsonObject[0]["message"],
            duration: Duration(seconds: 5));
        selectedGroupModel = new GroupModel();
        groupNameController.clear();
        groupUnderController.clear();
        isGroupUnderVisible = true;

        getAllGroup(staffModel.cmpId.toString(), staffModel.brnId.toString());
      } else {
        EasyLoading.showInfo(jsonObject[0]["message"],
            duration: Duration(seconds: 5));
      }
    } else {
      EasyLoading.showInfo("Something went wrong");
    }
  }
}
