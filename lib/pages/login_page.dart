
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/BranchModelFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dr_mech/common/theme_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  bool isLoading = false;

  bool isLoggedIn = false;

  TextEditingController companyIdController=new TextEditingController();

  TextEditingController userNameController=new TextEditingController();

  TextEditingController passwordController=new TextEditingController();


  // BranchModel selectedBranch =new BranchModel();

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.settings), //let's create a common header widget
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(20,0, 20, 10),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),// This will be the login form
              child: Column(
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold,color: Colors.grey),
                  ),
                  Text(
                    'Sign in into your account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextField(
                              controller: companyIdController,
                              decoration: ThemeHelper().textInputDecoration('Company ID', 'Enter your company Id'),
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: TextField(
                              controller: userNameController,
                              decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your user name'),
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 12.0),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(10,0,10,20),
                          //   alignment: Alignment.topRight,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                          //     },
                          //     child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap:(){
                              userLogin(companyIdController.text.toString(),userNameController.text.toString(),passwordController.text.toString());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(10,20,10,20),
                          //   //child: Text('Don\'t have an account? Create'),
                          //   child: Text.rich(
                          //     TextSpan(
                          //       children: [
                          //         TextSpan(text: "Don\'t have an account? "),
                          //         TextSpan(
                          //           text: 'Create',
                          //           recognizer: TapGestureRecognizer()
                          //             ..onTap = (){
                          //               Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                          //             },
                          //           style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                          //         ),
                          //       ]
                          //     )
                          //   ),
                          // ),
                        ],
                      )
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );

  }

  // Future userLogin(String companyId,String userName, String password) async {
  //   isLoggedIn = true;
  //   setState(() {});
  //
  //   String url = Apis.LOGIN_URL+companyId+"/"+userName+"/"+password+"/";
  //   final response = await http.get(Uri.parse(url));
  //
  //   isLoggedIn = false;
  //   setState(() {});
  //   if (response.statusCode == 200) {
  //     String responseString = response.body.toString();
  //     var jsonObject = jsonDecode(responseString)["errorData"] as List;
  //
  //     if (jsonObject[0]["error"] == 0) {
  //       setState(() {
  //
  //       });
  //       EasyLoading.showSuccess(jsonObject[0]["message"]);
  //       // getUniversityDetails();
  //     } else {
  //       EasyLoading.showSuccess(jsonObject[0]["message"]);
  //     }
  //   } else {
  //     EasyLoading.showSuccess("Something went wrong");
  //   }
  // }


  Future userLogin(String companyId,String userName, String password ) async {

    String url=Apis.LOGIN_URL+companyId+"/"+userName+"/"+password+"/";
    isLoading=true;
    setState(() {});
    var response = await http.get(Uri.parse(url));
    isLoading=false;
      setState(() {});
      String responseData=response.body.toString();
      // var jsonData=jsonDecode(responseData);
      // if(jsonData['"BranchData Fetched Succesfully']) {
      //   var data = jsonData['data'];
      //   setState(() {
      //
      //   });
      //
      // }
      // else {
      //   EasyLoading.showError(jsonData['message']);
      // }
    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var dataObject = jsonDecode(responseString)["data"] as List;
      var errorObject = jsonDecode(responseString)["errorData"] as List;

      if (null!=dataObject && dataObject.length>0) {
        setState(() {

        });
        BranchModel branchModel=new BranchModel();
        branchModel=BranchModel.fromJson(dataObject[0]);
        String branchJson=branchModelToJson(branchModel);
        PreferenceFile().setBranchData(branchJson);
        EasyLoading.showSuccess("Login Successful");
        Navigator.push( context, MaterialPageRoute( builder: (context) => ProfilePage()));

      } else {

        EasyLoading.showError(errorObject[0]["message"]);
      }
    } else {
      EasyLoading.showError("Something went wrong");
    }




    }

  }