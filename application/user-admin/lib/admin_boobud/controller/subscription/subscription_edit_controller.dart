import 'package:flutter/services.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/helpers/theme/app_style.dart';
import 'package:medicare/helpers/widgets/my_form_validator.dart';
import 'package:medicare/helpers/widgets/my_text_utils.dart';
import 'package:medicare/views/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender {
  male,
  female;

  const Gender();
}

enum PlanDuration {
  days,
  months,
  years;

  const PlanDuration();
}

class SubscriptionEditController extends MyController {
  bool isRemarks = false, showOkAction = true, showBanner = false, showLeadingIcon = true, sticky = false;
  Gender gender = Gender.male;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController planNameController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController amountController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
  }

  String? validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  void onChangeShowCloseIcon(bool? value) {
    if (value != null) {
      isRemarks = value;
      update();
    }
  }

  void onChangeSticky(bool? value) {
    if (value != null) {
      sticky = value;
      update();
    }
  }

  void onChangeGender(Gender? value) {
    gender = value ?? gender;
    update();
  }

  void cancelForm() {
    Get.offAndToNamed("/admin/subscription/list");
  }

  void updateSubscription() {
    if (formKey.currentState!.validate()) {
      print("Form has validation !");
      Constant.shankBarCustomWeb(Get.context!,"Subscription Plan added Successfully");
      Get.offAndToNamed("/admin/subscription/list");
    } else {
      print("Form has validation errors!");
      Constant.shankBarCustomWeb(Get.context!,"Please Enter a valid Information");
    }
  }
  Future<void> pickStartDate() async {
    final DateTime? picked = await showDatePicker(context: Get.context!, initialDate: selectedStartDate ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      selectedStartDate = picked;
      update();
    }
  }

  Future<void> pickEndDate() async {
    final DateTime? picked = await showDatePicker(context: Get.context!, initialDate: selectedEndDate ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      selectedEndDate = picked;
      update();
    }
  }
}

