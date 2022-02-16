import 'dart:convert';

import 'package:dr_mech/models/CategoryModelFile.dart';
import 'package:dr_mech/Api/Api.dart';
import 'package:dr_mech/common/theme_helper.dart';
import 'package:dr_mech/models/ProductModelFile.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:dr_mech/models/UnitModel.dart';
import 'package:dr_mech/pages/widgets/header_widget.dart';
import 'package:dr_mech/Utils/Preference.dart';

import 'package:dr_mech/models/SubCategoryModelFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen(this.productModel, this.type);

  int? type;
  ProductModel productModel = new ProductModel();

  @override
  State<StatefulWidget> createState() {
    return _AddProductScreenState(productModel);
  }
}

class _AddProductScreenState extends State<AddProductScreen> {
  _AddProductScreenState(this.selectedProduct);

  ProductModel selectedProduct = new ProductModel();

  final _formKey = GlobalKey<FormState>();

  @override
  TextEditingController productNameController = new TextEditingController();
  TextEditingController salesRateController = new TextEditingController();
  TextEditingController mrpController = new TextEditingController();
  TextEditingController barcodeController = new TextEditingController();

  CategoryModel selectedCategory = new CategoryModel();
  SubCategoryModel selectedSubCategory = new SubCategoryModel();
  UnitModel selectedUnit = new UnitModel();

  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];
  List<SubCategoryModel> subCategoryList = [];
  List<UnitModel> unitList = [];

  StaffModel staffModel = new StaffModel();

  bool isLoading = false;

  @override
  void initState() {

    if(widget.type==2 || widget.type==3) {
      productNameController.text = selectedProduct.productName.toString();
      salesRateController.text = selectedProduct.salesRate.toString();
      mrpController.text = selectedProduct.mrp.toString();
      barcodeController.text = selectedProduct.barCode.toString();
      selectedCategory.categoryName=selectedProduct.categoryName.toString();
      selectedSubCategory.subcategoryName=selectedProduct.subCategoryName.toString();
      selectedUnit.name=selectedProduct.unitName.toString();

    }
    getAllUnits();


    PreferenceFile().getStaffData().then((value)
    {
      staffModel=value;
      getAllCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
      getAllSubCategory(staffModel.cmpId.toString(),staffModel.brnId.toString());
      setState(() {

      });
    });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                              child: SizedBox(
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   child: TextFormField(
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         'Company ID', 'Enter company Id'),
                        //     controller: companyIdController,
                        //     validator: (val) {
                        //       if (!(val!.isEmpty)) {
                        //         return "Enter a company Id";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        //   decoration: ThemeHelper()
                        //       .inputBoxDecorationShaddow(),
                        // ),
                        SizedBox(
                          height: 15,
                        ),

                        // null != selectedCompany.companyId?
                        GestureDetector(
                          onTap: () {
                            categoryDialog(context, categoryList).then((value) {
                              if (null != value) {
                                selectedCategory = value;
                                // selectedCategory.categoryName =
                                //     selectedProduct.categoryName;
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width /1.25,
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
                              padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Category ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                    Text(null != selectedCategory.categoryName
                                        ? selectedCategory.categoryName.toString()
                                        : "")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        GestureDetector(
                          onTap: () {
                            subCategoryDialog(context, subCategoryList)
                                .then((value) {
                              if (null != value) {
                                selectedSubCategory = value;
                                // selectedProduct.subCategoryId =
                                //     selectedSubCategory.subcategoryId;
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.25,
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
                              padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SubCategory ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                    Text(null !=
                                            selectedSubCategory.subcategoryName
                                        ? selectedSubCategory.subcategoryName
                                            .toString()
                                        : "")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        GestureDetector(
                          onTap: () {
                            unitDialog(context, unitList).then((value) {
                              if (null != value) {
                                selectedUnit = value;
                                // selectedProduct.unitId = selectedUnit.id;
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.25,
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
                              padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Unit ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                    Text(null != selectedUnit.name
                                        ? selectedUnit.name.toString()
                                        : "")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // null != selectedCompany.companyId?

                        //     : Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Product Name', 'Enter product name'),
                            controller: productNameController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Sales Rate', 'Enter sales rate'),
                            controller: salesRateController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration(' MRP', 'Enter Mrp'),
                            controller: mrpController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                ' Barcode', 'Enter Barcode'),
                            controller: barcodeController,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        GestureDetector(
                          onTap: () {
                            if (productNameController.text.isEmpty) {
                              MotionToast.error(
                                      title: "Error",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      description: "Please type Product Name",
                                      animationType: ANIMATION.FROM_LEFT,
                                      position: MOTION_TOAST_POSITION.TOP,
                                      width: 300)
                                  .show(context);
                            } else if (salesRateController.text.isEmpty) {
                              MotionToast.error(
                                      title: "Error",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      description: "Please type salesRate",
                                      animationType: ANIMATION.FROM_LEFT,
                                      position: MOTION_TOAST_POSITION.TOP,
                                      width: 300)
                                  .show(context);
                            } else if (mrpController.text.isEmpty) {
                              MotionToast.error(
                                      title: "Error",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      description: "Please type Mrp",
                                      animationType: ANIMATION.FROM_LEFT,
                                      position: MOTION_TOAST_POSITION.TOP,
                                      width: 300)
                                  .show(context);
                            } else if (barcodeController.text.isEmpty) {
                              MotionToast.error(
                                      title: "Error",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      description: "Please type barcode",
                                      animationType: ANIMATION.FROM_LEFT,
                                      position: MOTION_TOAST_POSITION.TOP,
                                      width: 300)
                                  .show(context);
                            } else {
                              selectedProduct.productName =
                                  productNameController.text;

                              selectedProduct.salesRate =
                                  salesRateController.text;

                              selectedProduct.mrp = mrpController.text;
                              selectedProduct.barCode = barcodeController.text;

                              selectedProduct.categoryId =
                                  selectedCategory.categoryId;

                              selectedProduct.categoryName =
                                  selectedCategory.categoryName;

                              selectedProduct.subCategoryName =
                                  selectedSubCategory.subcategoryName;

                              selectedProduct.unitName =
                                  selectedUnit.name;

                              selectedProduct.subCategoryId =
                                  selectedSubCategory.subcategoryId;

                              selectedProduct.unitId = selectedUnit.id;

                              selectedProduct.brnId = staffModel.brnId;
                              selectedProduct.cmpId = staffModel.cmpId;

                              addEditProduct(
                                  selectedProduct,
                                  null != selectedProduct.productId &&
                                      selectedProduct.productId! > 0);
                            }
                            isLoading = true;
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
                              child: Text(null !=
                                  selectedProduct
                                      .productId &&
                                  selectedProduct
                                      .productId! >
                                      0
                                  ? "Update".toUpperCase()
                                  : "Add".toUpperCase(),
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

  Future<CategoryModel> categoryDialog(
      BuildContext context, List<CategoryModel> categoryList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
            // bottom: MediaQuery.of(context).size.height/5,
            // top: MediaQuery.of(context).size.height/5
            // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
            // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Category",
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
                itemCount: categoryList.length,
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
                              categoryList[position].categoryName.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(categoryList[position]);
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

  Future<SubCategoryModel> subCategoryDialog(
      BuildContext context, List<SubCategoryModel> subCategoryList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
            // bottom: MediaQuery.of(context).size.height/5,
            // top: MediaQuery.of(context).size.height/5
            // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
            // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select SubCategory",
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
                itemCount: subCategoryList.length,
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
                              subCategoryList[position]
                                  .subcategoryName
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(subCategoryList[position]);
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

  Future<UnitModel> unitDialog(
      BuildContext context, List<UnitModel> UnitList) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
            // bottom: MediaQuery.of(context).size.height/5,
            // top: MediaQuery.of(context).size.height/5
            // top: MediaQuery.of(context).size.width < 700 ? 50 : 50,
            // bottom: MediaQuery.of(context).size.width < 700 ? 50 : 50
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Unit",
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
                itemCount: unitList.length,
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
                              UnitList[position].name.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pop(UnitList[position]);
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

  Future<bool?> addEditProduct(ProductModel productDetailsModel, isEdit) async {
    String url = "";
    if (isEdit) {
      url = Apis.EDIT_PRODUCT_URL;
    } else {
      url = Apis.ADD_PRODUCT_URL;
    }
    // branchDetailsModel.status = 1;

    String dataJson = productModelToJson(productDetailsModel);

    var data = jsonEncode({"jsonData": dataJson});

    EasyLoading.show(status: "Please wait");

    final response = await http.post(Uri.parse(url), body: data);
    // isLoading=false;
    setState(() {});

    if (response.statusCode == 200) {
      String responseString = response.body;

      var jsonObject = jsonDecode(responseString)['errorData'] as List;
      if (jsonObject[0]["error"] == 0) {
        EasyLoading.showSuccess(jsonObject[0]["message"]);

        selectedProduct = new ProductModel();

        productNameController.text = "";
        salesRateController.text = "";
        mrpController.text = "";
        barcodeController.text = "";
        selectedCategory.categoryName="";
        selectedSubCategory.subcategoryName="";
        selectedProduct.productName = "";
        selectedUnit.name="";
        setState(() {});

        getAllProduct(selectedProduct.brnId.toString(),selectedProduct.cmpId.toString());
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

  Future getAllCategory(String companyId, String branchId) async{
    isLoading=true;
    setState(() {
    });

    String url=Apis.GROUP_URL+companyId+"/"+branchId;
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
