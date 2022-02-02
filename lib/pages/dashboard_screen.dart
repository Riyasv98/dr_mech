
import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/models/ProductModelFile.dart';
import 'package:dr_mech/models/SubCategoryModelFile.dart';
import 'package:dr_mech/models/UnitModel.dart';
import 'package:dr_mech/pages/Add_product.dart';
import 'package:dr_mech/pages/AllUnits.dart';
import 'package:dr_mech/pages/add_unit_screen.dart';
import 'package:dr_mech/pages/all_staff_screen.dart';
import 'package:dr_mech/pages/subcategory_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dr_mech/pages/login_page.dart';
import 'package:dr_mech/pages/splash_screen.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';

import 'all_category_screen.dart';
import 'all_subcategory_screen.dart';
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
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddCategoryScreen(new CategoryModel(),1)));
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
                                      Text("Add Category",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllCategoryScreen()));

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
                                      Text("All Category",style: TextStyle(
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddSubCategoryScreen(new SubCategoryModel(),1)));
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
                                      Text("Add SubCategory",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllSubCategoryScreen()));

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
                                      Text("All Subcategory",style: TextStyle(
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddUnitScreen(new UnitModel(),1)));
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
                                      Text("Add Unit",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllUnitScreen()));

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
                                      Text("All Units",style: TextStyle(
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddProductScreen(new ProductModel(),1)));
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
                                      Text("Add Product",style: TextStyle(
                                          fontSize: 15,fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AllUnitScreen()));

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
                                      Text("All Product",style: TextStyle(
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