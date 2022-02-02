
import 'dart:convert';

import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/Utils/Preference.dart';
import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/common/Contants.dart';
import 'package:dr_mech/models/ProductModelFile.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:dr_mech/models/SubCategoryModelFile.dart';
import 'package:dr_mech/models/UnitModel.dart';
import 'package:dr_mech/pages/Add_product.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'category_screen.dart';


class AllProductScreen extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AllProductScreenState();
  }
}

class _AllProductScreenState extends State<AllProductScreen>{

  final _formKey = GlobalKey<FormState>();



  @override

  TextEditingController productNameController = new TextEditingController();
  TextEditingController salesRateController = new TextEditingController();
  TextEditingController mrpController = new TextEditingController();
  TextEditingController barcodeController = new TextEditingController();

  StaffModel selectedStaff =new StaffModel();
  CategoryModel selectedCategory =new CategoryModel();
  SubCategoryModel selectedSubCategory = new SubCategoryModel();
  UnitModel selectedUnit = new UnitModel();
  ProductModel selectedProduct = new ProductModel();

  bool isLoading = false;

  // List<StaffModel> staffList = [];
  StaffModel staffModel = new StaffModel();

  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];
  List<SubCategoryModel> subCategoryList = [];
  List<UnitModel> unitList = [];

  void initState() {

    getAllUnits();

    PreferenceFile().getStaffData().then((value)
    {
      staffModel=value;
      getAllProduct(staffModel.cmpId.toString(),staffModel.brnId.toString());
      // getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
      setState(() {

      });
    });



    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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

                      isLoading
                          ? Center(
                        child:
                        CircularProgressIndicator(),
                      )
                          :null!=productList && productList.length > 0?

                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height/3.5,
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
                                                  Navigator.push( context, MaterialPageRoute( builder: (context) => AddProductScreen(productList[index],2)));
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
                                                  selectedProduct=productList[index];
                                                  Constants.deleteDialog(context,productList[index].productName.toString()).then((value) {

                                                    if (value) {
                                                      deleteProduct(selectedProduct.productId!.toInt(),selectedProduct.cmpId!.toInt(),selectedProduct.brnId!.toInt());
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
                                                  child: Text("Category Id :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("SubCategory Id :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("Unit Id :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("Product Name :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("SalesRate :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("Mrp :"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text("Barcode :"),
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
                                                  child: Text(productList[index].categoryId.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].subCategoryId.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].unitId.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].productName.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].salesRate.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].mrp.toString(),textAlign: TextAlign.left,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                                  child: Text(productList[index].barCode.toString(),textAlign: TextAlign.left,),
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
    );
  }

  Future getAllProduct(String companyId, String branchId) async {
    isLoading = true;
    setState(() {});

    String url = Apis.PRODUCT_URL + companyId + "/" + branchId;
    var response = await http.get(Uri.parse(url));

    isLoading = false;
    setState(() {});

    String responseData = response.body.toString();
    var jsonData = jsonDecode(responseData); //check response string
    // if(jsonData['success']) {
    var data = jsonData['data']; //based on response string give array name
    productList =
    List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x)));
    setState(() {});
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

  Future deleteProduct(int ProductId, int CompanyId, int BranchId) async {
    isLoading = true;
    setState(() {});
    String? url;
    url = Apis.DELETE_PRODUCT_URL + ProductId.toString()+"/"+CompanyId.toString()+"/"+BranchId.toString();
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
        // getAllStaff(CompanyId,BranchId);
      } else {
        EasyLoading.showSuccess(jsonObject[0]["message"]);
      }
    } else {
      EasyLoading.showSuccess("Something went wrong");
    }
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

  Future getAllUnits() async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.UNIT_URL;
    var response = await http.get(Uri.parse(url));

    isLoading=false;
    setState(() {

    });

    String responseData=response.body.toString();
    var jsonData=jsonDecode(responseData);//check response string
    // if(jsonData['success']) {
    var data = jsonData['data'];//based on response string give array name
    unitList = List<UnitModel>.from(data.map((x) => UnitModel.fromJson(x)));
    setState(() {

    });
  }

}