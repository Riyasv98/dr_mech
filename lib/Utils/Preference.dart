import 'package:dr_mech/models/BranchModelFile.dart';
import 'package:dr_mech/models/StaffModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceFile {

  Future<bool> setStaffData(String staffModelJson) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('staffModel',staffModelJson);
  }
  Future<StaffModel> getStaffData() async {
    StaffModel staffModel=new StaffModel();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonData= null != preferences.getString('staffModel')!?
    preferences.getString('staffModel')!:"";
    staffModel=staffModelFromJson(jsonData);
    return staffModel;
  }




}