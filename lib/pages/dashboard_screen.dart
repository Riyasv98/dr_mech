

import 'package:dr_mech/models/StaffModel.dart';
import 'package:dr_mech/pages/AllUnits.dart';
import 'package:dr_mech/pages/All_product.dart';
import 'package:dr_mech/pages/UnitScreen.dart';
import 'package:dr_mech/pages/all_staff_screen.dart';
import 'package:dr_mech/pages/job_card_screen.dart';
import 'package:dr_mech/pages/group_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';

import 'SalesScreen.dart';


class DashboardScreen extends StatefulWidget{
  DashboardScreen(this.staffModel);
  StaffModel staffModel=new StaffModel();

  @override
  State<StatefulWidget> createState() {
     return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                        ],
                      ),
                      child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.staffModel.name!),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => JobCardScreen()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline_outlined,size: 50,
                                      ),
                                      Text("Job card",style: TextStyle(
                                          fontSize: 20,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllStaffScreen()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.people,size: 50,
                                      ),
                                      Text("Staff",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt,size: 50,
                                    ),
                                    Text("Billing",style: TextStyle(
                                        fontSize: 15,fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search,size: 50,
                                    ),
                                    Text("Search",style: TextStyle(
                                        fontSize: 15,fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.directions_car,size: 50,
                                    ),
                                    Text("Stock",style: TextStyle(
                                        fontSize: 15,fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) =>SalesScreen()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.receipt,size: 50,
                                      ),
                                      Text("Sales",style: TextStyle(
                                          fontSize: 15 ,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => GroupScreen()));

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.category,size: 50,
                                      ),
                                      Text("Group",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => UnitScreen()));

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.ac_unit,size: 50,
                                      ),
                                      Text("Units",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllProductScreen()));

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.width/4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.inventory,size: 50,
                                      ),
                                      Text("Products",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [


                            ],
                          ),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     "User Information",
                          //     style: TextStyle(
                          //       color: Colors.black87,
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 16,
                          //     ),
                          //     textAlign: TextAlign.left,
                          //   ),
                          // ),
                          // Card(
                          //   child: Container(
                          //     alignment: Alignment.topLeft,
                          //     padding: EdgeInsets.all(15),
                          //     child: Column(
                          //       children: <Widget>[
                          //         Column(
                          //           children: <Widget>[
                          //             ...ListTile.divideTiles(
                          //               color: Colors.grey,
                          //               tiles: [
                          //                 ListTile(
                          //                   contentPadding: EdgeInsets.symmetric(
                          //                       horizontal: 12, vertical: 4),
                          //                   leading: Icon(Icons.my_location),
                          //                   title: Text("Location"),
                          //                   subtitle: Text("USA"),
                          //                 ),
                          //                 ListTile(
                          //                   leading: Icon(Icons.email),
                          //                   title: Text("Email"),
                          //                   subtitle: Text("donaldtrump@gmail.com"),
                          //                 ),
                          //                 ListTile(
                          //                   leading: Icon(Icons.phone),
                          //                   title: Text("Phone"),
                          //                   subtitle: Text("99--99876-56"),
                          //                 ),
                          //                 ListTile(
                          //                   leading: Icon(Icons.person),
                          //                   title: Text("About Me"),
                          //                   subtitle: Text(
                          //                       "This is a about me link and you can khow about me in this section."),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}