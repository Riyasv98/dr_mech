import 'package:dr_mech/models/BranchModelFile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceFile {

  Future<bool> setBranchData(String branchModelJson) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('branchModel',branchModelJson);
  }
  Future<String> getBranchData() async {
    BranchModel branchModel=new BranchModel();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonData=preferences.getString('branchModel')!;
    branchModel=branchModelFromJson(jsonData);
    return jsonData;
  }




}