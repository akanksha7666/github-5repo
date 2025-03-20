import 'package:flutter/material.dart';
import 'package:medicare/admin_boobud/dio/authModels/LoginModelResponse.dart';
import 'package:medicare/admin_boobud/uttils/PreferencesHelper.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/admin_boobud/uttils/env.dart';
import 'package:medicare/helpers/services/auth_services.dart';
import 'package:medicare/helpers/storage/local_storage.dart';
import 'package:medicare/helpers/widgets/my_form_validator.dart';
import 'package:medicare/helpers/widgets/my_validators.dart';
import 'package:get/get.dart';
import 'package:medicare/views/my_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../uttils/enDeDataManage.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;

  final String _dummyEmail = "soham@gmail.com";
  final String _dummyPassword = "john1234";

  @override
  void onInit() {
    basicValidator.addField('email', required: true, label: "Email", validators: [MyEmailValidator()], controller: TextEditingController(text: _dummyEmail));
    basicValidator.addField('password', required: true, label: "Password", validators: [MyLengthValidator(min: 6, max: 10)], controller: TextEditingController(text: _dummyPassword));
    _loadSavedCredentials();
    super.onInit();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      String emailId = encryptAESCryptoJS(basicValidator.getController('email')!.text.toString().trim(),Env.enENKey);
      String passWord = encryptAESCryptoJS(basicValidator.getController('password')!.text.toString().trim(),Env.enENKey);
      Debug.printLog("Valid Input: Email = ${basicValidator.getController('email')!.text}///$emailId, Password = ${basicValidator.getController('password')!.text}////$passWord");
      update();
      LoginModelResponse loginModelResponse = await AuthService.loginUser(Get.context!,emailId,passWord);
      if(loginModelResponse != null && loginModelResponse.status.toString().toLowerCase() == "Success".toString().toLowerCase()){
        if(loginModelResponse.data!.mfaEnabled == true){
          // ignore: use_build_context_synchronously
          Constant.shankBarCustomWeb(Get.context!,loginModelResponse.message.toString());
          String nextUrl = Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "").queryParameters['next'] ?? "/dashboard";
          Get.offAllNamed(
            nextUrl,
          );
        }else{
          await LocalStorage.setAuhToken(loginModelResponse.data!.token.toString());
          PreferencesHelper.setString(PreferencesHelper.token, loginModelResponse.data!.token.toString());
          PreferencesHelper.setBool(PreferencesHelper.loginIs, true);
          String nextUrl = Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "").queryParameters['next'] ?? "/dashboard";
          Get.offAllNamed(
            nextUrl,
          );
        }
      }
      loading = false;
      update();
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register_account');
  }


  /// Load saved email and password if "Remember Me" was checked
  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      basicValidator.getController('email')!.text = prefs.getString('savedEmail') ?? '';
      basicValidator.getController('password')!.text = prefs.getString('savedPassword') ?? '';
      isChecked = true;
      update();
    }
  }

  /// Handle login and save credentials
  void _handleLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setString('savedEmail', basicValidator.getController('email')!.text);
      await prefs.setString('savedPassword', basicValidator.getController('password')!.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
      await prefs.setBool('rememberMe', false);
    }


    // Login process (Implement your authentication logic)
    print("Logging in with Email: ${basicValidator.getController('email')!.text}");
  }


}
