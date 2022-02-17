//
// import 'dart:convert';
//
// import 'package:dr_mech/Api/Api.dart';
// import 'package:dr_mech/Utils/Preference.dart';
// import 'package:dr_mech/models/CategoryModelFile.dart';
// import 'package:dr_mech/common/Contants.dart';
// import 'package:dr_mech/models/GroupModel.dart';
// import 'package:dr_mech/models/ProductModelFile.dart';
// import 'package:dr_mech/models/StaffModel.dart';
// import 'package:dr_mech/models/SubCategoryModelFile.dart';
// import 'package:dr_mech/models/UnitModel.dart';
// import 'package:dr_mech/pages/Add_product.dart';
// import 'package:dr_mech/pages/widgets/header_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart' as http;
// import 'category_screen.dart';
//
//
// class SalesScreen extends  StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _SalesScreenState();
//   }
// }
//
// class _SalesScreenState extends State<SalesScreen>{
//
//   final _formKey = GlobalKey<FormState>();
//
//
//
//   @override
//
//   TextEditingController productNameController = new TextEditingController();
//   TextEditingController salesRateController = new TextEditingController();
//   TextEditingController mrpController = new TextEditingController();
//   TextEditingController barcodeController = new TextEditingController();
//
//   StaffModel selectedStaff =new StaffModel();
//   CategoryModel selectedCategory =new CategoryModel();
//   SubCategoryModel selectedSubCategory = new SubCategoryModel();
//   UnitModel selectedUnit = new UnitModel();
//   ProductModel selectedProduct = new ProductModel();
//
//   bool isLoading = false;
//
//   // List<StaffModel> staffList = [];
//   StaffModel staffModel = new StaffModel();
//
//   List<ProductModel> productList = [];
//   List<CategoryModel> categoryList = [];
//   List<SubCategoryModel> subCategoryList = [];
//   List<UnitModel> unitList = [];
//
//   void initState() {
//
//     getAllUnits();
//
//     PreferenceFile().getStaffData().then((value)
//     {
//       staffModel=value;
//       getAllProduct(staffModel.brnId.toString(),staffModel.cmpId.toString());
//
//       setState(() {
//
//       });
//     });
//     // getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
//
//
//
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Stack(
//               children: [
//                 Container(
//                   height: 150,
//                   child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Stack(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
//                                   child: SizedBox(height: 20,),
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: (){
//                                 Navigator.push( context, MaterialPageRoute( builder: (context) => AddProductScreen(new ProductModel(),1))).then((value){
//                                   getAllProduct(staffModel.cmpId.toString(),staffModel.brnId.toString());
//                                 });
//                               },
//                               child: Align(
//                                 alignment: Alignment.topRight,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(right: 8.0,bottom: 5),
//                                   child: Icon(
//                                     Icons.add_circle,color: Colors.grey,size: 40,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               // crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("Category",textAlign: TextAlign.start,style: TextStyle(fontSize: 13),),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("SubCategory",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("Unit",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("Product Name",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("SalesRate",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("Mrp",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Text("Barcode",textAlign: TextAlign.start,),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             isLoading
//                                 ? Center(
//                               child:
//                               CircularProgressIndicator(),
//                             )
//                                 :null!=productList && productList.length > 0?
//
//                             ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: productList.length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(left: 8.0,top:2),
//                                     child: Column(
//                                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].categoryName.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].subCategoryName.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].unitName.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].productName.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].salesRate.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].mrp.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(2.0),
//                                                 child: Text(productList[index].barCode.toString(),textAlign: TextAlign.start,),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//                                       ],
//                                     ),
//                                   );
//                                 })
//                                 : Center(
//                               child: Text(
//                                   "No document found"),
//                             )
//
//
//
//
//
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future getAllProduct(String branchId, String companyId) async {
//     isLoading = true;
//     setState(() {});
//
//     String url = Apis.PRODUCT_URL + branchId + "/" + companyId;
//     var response = await http.get(Uri.parse(url));
//
//     isLoading = false;
//     setState(() {});
//
//     String responseData = response.body.toString();
//     var jsonData = jsonDecode(responseData); //check response string
//     // if(jsonData['success']) {
//     var data = jsonData['data']; //based on response string give array name
//     productList = List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
//     setState(() {});
//   }
//
//
//   Future getAllGroup(String companyId, String branchId) async {
//     isLoading = true;
//     setState(() {});
//
//     String url = Apis.GROUP_URL + companyId + "/" + branchId;
//     var response = await http.get(Uri.parse(url));
//
//     isLoading = false;
//     setState(() {});
//
//     String responseData = response.body.toString();
//     var jsonData = jsonDecode(responseData);
//     var data = jsonData['data'];
//     groupModelList = [];
//     List<GroupModel> list = [];
//     list=List<GroupModel>.from(data.map((x) => GroupModel.fromJson(x)));
//     for (GroupModel groupModel in list) {
//       if (groupModel.groupUnder!>0) {
//         groupModelList.add(groupModel);
//
//       }
//     }
//     setState(() {});
//   }
//
//   Future deleteProduct(int ProductId, int CompanyId, int BranchId) async {
//     isLoading = true;
//     setState(() {});
//     String? url;
//     url = Apis.DELETE_PRODUCT_URL + ProductId.toString()+"/"+CompanyId.toString()+"/"+BranchId.toString();
//     final response =
//     await http.get(Uri.parse(url));
//
//     isLoading = false;
//     setState(() {});
//     if (response.statusCode == 200) {
//       String responseString = response.body.toString();
//       var jsonObject = jsonDecode(responseString)["errorData"] as List;
//
//       if (jsonObject[0]["error"] == 0) {
//         setState(() {
//
//         });
//         EasyLoading.showSuccess(jsonObject[0]["message"]);
//         getAllProduct(selectedProduct.brnId.toString(),selectedProduct.cmpId.toString());
//       } else {
//         EasyLoading.showSuccess(jsonObject[0]["message"]);
//       }
//     } else {
//       EasyLoading.showSuccess("Something went wrong");
//     }
//   }
//
//   Future getAllUnits() async{
//     isLoading=true;
//     setState(() {
//     });
//
//     String url=Apis.UNIT_URL;
//     var response = await http.get(Uri.parse(url));
//
//     isLoading=false;
//     setState(() {
//
//     });
//
//     String responseData=response.body.toString();
//     var jsonData=jsonDecode(responseData);//check response string
//     // if(jsonData['success']) {
//     var data = jsonData['data'];//based on response string give array name
//     unitList = List<UnitModel>.from(data.map((x) => UnitModel.fromJson(x)));
//     setState(() {
//
//     });
//   }
//
// }