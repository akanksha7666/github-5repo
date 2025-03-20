import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';
import 'package:medicare/admin_boobud/dio/allRepoDataModel.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelPayload.dart';
import 'package:medicare/admin_boobud/dio/subscription/subscriptionModelResponce.dart';
import 'package:medicare/admin_boobud/uttils/DeviceUtils.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/views/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender {
  male,
  female;

  const Gender();
}

enum PlanDuration {
  day,
  month,
  year;

  const PlanDuration();
}

class SubscriptionAddController extends MyController {
  bool isRemarks = false, showOkAction = true, showBanner = false, showLeadingIcon = true, sticky = false;
  Gender gender = Gender.male;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // ✅ Form Key

  TextEditingController planNameController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  var allRepoDataModel = AllRepoDataModel();

  String plan = "";

  @override
  void onInit() {
    plan = PlanDuration.day.name.toString();
    super.onInit();
  }

  String? validateField(String? value, String fieldName, {int start = 0, int end = 0}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    // If start and end range is provided, validate length
    if (start != 0 || end != 0) {
      int length = value.length;

      if (length < start) {
        return "$fieldName must be at least $start characters";
      }
      if (end != 0 && length > end) {
        return "$fieldName must not exceed $end characters";
      }
    }
    return null; // ✅ No validation errors
  }

  bool isValidAmount(String value) {
    RegExp regex = RegExp(r'^\d{1,6}(\.\d{1,2})?$');
    return regex.hasMatch(value);
  }


  onChangePlan(String values){
    plan = values;
    update();
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

  Future<void> addSubscription(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try{
        DeviceInfo deviceInfo = await DeviceUtils.getDeviceInfo();
        double amount = double.tryParse(amountController.text.trim()) ?? 0.0;

        String isActiveValues = "false";
        if(sticky){
          isActiveValues = "true";
        }
        SubscriptionModelPayload addSubscriptionPayloadModel = SubscriptionModelPayload(
            amount: amount.toString().trim(),
            isActive: isActiveValues.toString(),
            isDefault: 1,
            planName: planNameController.text.toString().trim(),
            plan: plan.toString().trim(),
            remarks: remarkController.text.toString().trim(),
            startTime: selectedStartDate.toString(),
            term: int.parse(termController.text.toString()),
            deviceInfo: deviceInfo
        );
        // ignore: use_build_context_synchronously
        SubscriptionModelResponse loginRes = await allRepoDataModel.addSubscriptionsApiCallAPI(context, addSubscriptionPayloadModel);
        if(loginRes.data != null && loginRes.status.toString().toLowerCase() == Constant.success){
            Constant.doneShankBar(Get.context!,loginRes.message.toString());
            Get.offAndToNamed("/admin/subscription/list");
        }
      }catch(e){
        Debug.printLog("Api Side to Error......$e");
      }
    } else {
      Constant.errorShankBar(Get.context!,"Please Enter a valid Information");
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
