import 'package:flutter/material.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/helpers/services/auth_services.dart';
import 'package:medicare/helpers/widgets/my_form_validator.dart';
import 'package:medicare/helpers/widgets/my_validators.dart';
import 'package:get/get.dart';
import 'package:medicare/views/my_controller.dart';

class ForgotPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false;

  @override
  void onInit() {
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );

    super.onInit();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser(Get.context!, "","");
      if (errors != null) {
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/auth/otp');
      loading = false;
      update();
    }
  }

  void gotoLogIn() {
    Get.toNamed('/auth/login');
  }
}
