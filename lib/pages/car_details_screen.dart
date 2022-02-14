
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_mech/common/theme_helper.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';

class CarDetailsPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CarDetailsPageState();
  }
}

class _CarDetailsPageState extends State<CarDetailsPage>{

  final _formKey = GlobalKey<FormState>();

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
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
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
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(100),
                              //     border: Border.all(
                              //         width: 5, color: Colors.white),
                              //     color: Colors.white,
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black12,
                              //         blurRadius: 20,
                              //         offset: const Offset(5, 5),
                              //       ),
                              //     ],
                              //   ),
                              //   child: Icon(
                              //     Icons.directions_car,
                              //     color: Colors.grey.shade300,
                              //     size: 80.0,
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                              //   child: Icon(
                              //     Icons.add_circle,
                              //     color: Colors.grey.shade700,
                              //     size: 25.0,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Owner Name', 'Enter owner name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Mobile Number', 'Enter phone number'),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid Mobile number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration("Address", "Enter address"),
                            keyboardType: TextInputType.emailAddress,
                            // validator: (val) {
                            //   if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                            //     return "Enter a valid email address";
                            //   }
                            //   return null;
                            // },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Vehicle Number",
                                "Enter vehicle number"),
                            // keyboardType: TextInputType.phone,
                            // validator: (val) {
                            //   if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                            //     return "Enter a valid phone number";
                            //   }
                            //   return null;
                            // },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(height: 15.0),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black26)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: TextField(
                                // controller: descriptionController,z
                                textAlign: TextAlign.left,
                                maxLines: 7,
                                maxLength: 200,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Complaints",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   child: TextField(
                        //     textAlign: TextAlign.left,
                        //     maxLines: 10,
                        //     maxLength: 750,
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         "Complaint",
                        //         "Enter complaint"),
                        //     // keyboardType: TextInputType.phone,
                        //     // validator: (val) {
                        //     //   if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                        //     //     return "Enter a valid phone number";
                        //     //   }
                        //     //   return null;
                        //     // },
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        SizedBox(height: 15.0),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
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

}