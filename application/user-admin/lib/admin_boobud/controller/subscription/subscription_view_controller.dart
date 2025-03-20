import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/helpers/widgets/my_form_validator.dart';
import 'package:medicare/model/subscription_model.dart';
import 'package:medicare/views/my_controller.dart';

import '../../../helpers/widgets/my_text_utils.dart';

class SubscriptionViewController extends MyController {
  bool showCloseIcon = true, showOkAction = true, showBanner = false, showLeadingIcon = true, sticky = false;
  DateTime? selectedDate;
  MyFormValidator basicValidator = MyFormValidator();
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));
  late TextEditingController firstNameTE, lastNameTE, userNameTE, educationTE, cityTE, stateTE, addressTE, mobileNumberTE, emailAddressTE, designationTE, countryTE, postalCodeTE, biographyTE;
  List<SubscriptionModel> subscription = [];

  bool light = true;

  void toggleLight(bool value) {
    light = value;
  }


  @override
  void onInit() {
    super.onInit();
  }

  void onChangeShowCloseIcon(bool? value) {
    if (value != null) {
      showCloseIcon = value;
      update();
    }
  }

  void onChangeSticky(bool? value) {

  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(context: Get.context!, initialDate: selectedDate ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }
}