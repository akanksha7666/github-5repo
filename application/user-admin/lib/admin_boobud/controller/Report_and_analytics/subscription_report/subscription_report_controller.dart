import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/model/appointment_list_model.dart';
import 'package:medicare/views/my_controller.dart';

import '../../../dataModel/SubscriptionModel.dart';

class SubscriptionReportFLDController extends MyController {
  List<SubscriptionModel> subscriptionDataList = [];
  List<AppointmentListModel> appointmentListModel = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? fromSelectedTime;
  TimeOfDay? toSelectedTime;
  bool isView = false;

  int selectedIndex = 0;
  int selectPageLength = 10;
  List<int> pageDropDownList = [10,20,50,100,200,500];
  List<int> pageNavButton = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  int maxVisiblePages = 5;

  int get totalPages => (subscriptionDataList.length / selectPageLength).ceil();
  int get startIndex => selectedIndex * selectPageLength;
  int get endIndex => (startIndex + selectPageLength).clamp(0, subscriptionDataList.length);

  int get startPage => (selectedIndex ~/ maxVisiblePages) * maxVisiblePages;
  int get endPage => (startPage + maxVisiblePages - 1).clamp(0, totalPages - 1);

  @override
  void onInit() {
    selectPageLength = pageDropDownList[0];
    subscriptionDataList = SubscriptionModel.getSubscriptionDummyData();
    // AppointmentListModel.dummyList.then((value) {
    //   appointmentListModel = value;
    //   update();
    // });
    super.onInit();
  }

  void alertBoxData() {
    Constant.showConfirmationDialog(
      Get.context!,
      "Delete Subscription?",
      "Are you sure you want to delete this subscription?",
          () {
        Get.back();
        ///Call Api For Update Subscription List and Reload Screen

      },
    );
  }
  void goEditSubscriptionScreen() {
    Get.toNamed('/admin/subscription/edit');
  }
  void goSubscriptionViewScreen() {
    Get.toNamed('/admin/subscription/view');
  }
  void goDeleteScreen() {
    alertBoxData();
    /// delete Action header
  }
  onPagesList(values){
    selectPageLength =values;
    update();
  }
  void updatePagination() {
    update(); // Notify UI of changes
  }
  gotoPage(){
    update();
  }

  void bookAppointment() {
    Get.toNamed('/admin/reports_analytics/user_report/add');
  }
  void exportData() {

  }

  void goToSchedulingEditScreen() {
    Get.toNamed('/admin/reports_analytics/user_report/edit');
  }

  void goToSchedulingScreen() {
    Get.toNamed('/admin/appointment_scheduling');
  }

  void onView(){
    isView = !isView;
    update();
  }

  Future<void> pickStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!, initialDate: selectedStartDate ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      selectedStartDate = picked;
      update();
    }
  }
  Future<void> pickEndDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!, initialDate: selectedEndDate ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      selectedEndDate = picked;
      update();
    }
  }


}