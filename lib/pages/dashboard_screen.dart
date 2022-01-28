
import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/pages/all_staff_screen.dart';
import 'package:dr_mech/pages/subcategory_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dr_mech/pages/login_page.dart';
import 'package:dr_mech/pages/splash_screen.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';

import 'car_details_screen.dart';
import 'add_staff_screen.dart';
import 'category_screen.dart';

class DashboardScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   flexibleSpace:Container(
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
      //         )
      //     ),
      //   ),
      //   // actions: [
      //   //   // Container(
      //   //   //   margin: EdgeInsets.only( top: 16, right: 16,),
      //   //   //   child: Stack(
      //   //   //     children: <Widget>[
      //   //   //       Icon(Icons.notifications),
      //   //   //       Positioned(
      //   //   //         right: 0,
      //   //   //         child: Container(
      //   //   //           padding: EdgeInsets.all(1),
      //   //   //           decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
      //   //   //           constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
      //   //   //           child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
      //   //   //         ),
      //   //   //       )
      //   //   //     ],
      //   //   //   ),
      //   //   // )
      //   // ],
      // ),
      // drawer: Drawer(
      //   child: Container(
      //     decoration:BoxDecoration(
      //         gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             stops: [0.0, 1.0],
      //             colors: [
      //               Theme.of(context).primaryColor.withOpacity(0.2),
      //               Theme.of(context).accentColor.withOpacity(0.5),
      //             ]
      //         )
      //     ) ,
      //     child: ListView(
      //       children: [
      //         DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: Theme.of(context).primaryColor,
      //             gradient: LinearGradient(
      //               begin: Alignment.topLeft,
      //               end: Alignment.bottomRight,
      //               stops: [0.0, 1.0],
      //               colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
      //             ),
      //           ),
      //           // child: Container(
      //           //   alignment: Alignment.bottomLeft,
      //           //   child: Text("FlutterTutorial.Net",
      //           //     style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
      //           //   ),
      //           // ),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
      //           title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
      //           onTap: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
      //           title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
      //           ),
      //           onTap: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
      //           },
      //         ),
      //         Divider(color: Theme.of(context).primaryColor, height: 1,),
      //         Divider(color: Theme.of(context).primaryColor, height: 1,),
      //         Divider(color: Theme.of(context).primaryColor, height: 1,),
      //         Divider(color: Theme.of(context).primaryColor, height: 1,),
      //         ListTile(
      //           leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
      //           title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
      //           onTap: () {
      //             SystemNavigator.pop();
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
                    SizedBox(height: 20,),
                    Text('Mr. Owner Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text('Workshop Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
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
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => CarDetailsPage()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width/3,
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
                                        Icons.add_circle_outline_outlined,size: 70,
                                      ),
                                      Text("New Repair",style: TextStyle(
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
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width/3,
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
                                        Icons.people,size: 70,
                                      ),
                                      Text("Staff",style: TextStyle(
                                          fontSize: 20,fontWeight: FontWeight.bold
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
                              Container(
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width/3,
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
                                      Icons.receipt,size: 70,
                                    ),
                                    Text("Billing",style: TextStyle(
                                        fontSize: 20,fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width/3,
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
                                      Icons.search,size: 70,
                                    ),
                                    Text("Search",style: TextStyle(
                                        fontSize: 20,fontWeight: FontWeight.bold
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
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width/3,
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
                                      Icons.directions_car,size: 70,
                                    ),
                                    Text("Stock",style: TextStyle(
                                        fontSize: 20,fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width/3,
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
                                      Icons.notes,size: 70,
                                    ),
                                    Text("Notes",style: TextStyle(
                                        fontSize: 20,fontWeight: FontWeight.bold
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddCategoryScreen()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width/3,
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
                                        Icons.receipt,size: 70,
                                      ),
                                      Text("Category",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddSubCategoryScreen()));

                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width/3,
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
                                        Icons.search,size: 70,
                                      ),
                                      Text("Subcategory",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
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