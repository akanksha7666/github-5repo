import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/helpers/services/auth_services.dart';
import 'package:medicare/helpers/widgets/my_form_validator.dart';

class OtpController extends GetxController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false;

  var isLoading = false;
  List<TextEditingController> otpControllers =
  List.generate(4, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes =
  List.generate(4, (index) => FocusNode());

  void onOtpChange(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      otpFocusNodes[index].unfocus();
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index].unfocus();
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verifyOtp() async {
    String otpCode =
    otpControllers.map((controller) => controller.text).join();

    if (otpCode.length < 4) {
      Get.snackbar("Error", "Please enter a valid 4-digit OTP");
      return;
    }

    isLoading = true;

    // var response = await AuthService.verifyOtp(otpCode);

    // if (response == true) {
      Get.toNamed('/auth/reset_password');
    // } else {
    //   Get.snackbar("Invalid OTP", "Please try again.");
    // }

    isLoading = false;
  }

  void gotoLogIn() {
    Get.toNamed('/auth/login');
  }
}
