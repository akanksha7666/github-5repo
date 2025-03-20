import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';
import 'package:medicare/admin_boobud/dio/allRepoDataModel.dart';
import 'package:medicare/admin_boobud/uttils/DeviceUtils.dart';
import 'package:medicare/admin_boobud/uttils/PreferencesHelper.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/model/user.dart';

import '../../admin_boobud/dio/authModels/LoginModelResponse.dart';
import '../../admin_boobud/dio/authModels/LoginPayloadModel.dart';
import '../storage/local_storage.dart';

class AuthService {
  static bool isLoggedIn = false;

  /*static User get dummyUser =>
      User(-1, "admin@gmail.com", "Admin", "Navadiya");

  static Future<Map<String, String>?> loginUser(
      Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));
    if (data['email'] != dummyUser.email) {
      return {"email": "This email is not registered"};
    } else if (data['password'] != "123456789") {
      return {"password": "Password is incorrect"};
    }

    isLoggedIn = true;
    await LocalStorage.setLoggedInUser(true);
    return null;
  }*/

static Future<LoginModelResponse> loginUser(BuildContext context,String emailId,String passWord) async {
  var allRepoDataModel = AllRepoDataModel();

  try{
    DeviceInfo deviceInfo = await DeviceUtils.getDeviceInfo();
    LoginPayloadModel loginPayloadModel = LoginPayloadModel(
        email: emailId,
        password: passWord,
        deviceInfo: deviceInfo
    );
    // ignore: use_build_context_synchronously
    LoginModelResponse loginRes = await allRepoDataModel.loginCallAPI(context, loginPayloadModel);
    if(loginRes.data != null){
      PreferencesHelper.setString(PreferencesHelper.emailKey, emailId);
      PreferencesHelper.saveUserData(loginRes.data!);
      isLoggedIn = true;
      await LocalStorage.setLoggedInUser(true);
      return loginRes;
    }else{
      return LoginModelResponse();
    }
  }catch(e){
    Debug.printLog("Api Side to Error......$e");
    return LoginModelResponse();
  }
}

}
