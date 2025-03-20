import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/model/appointment_list_model.dart';
import 'package:medicare/views/my_controller.dart';

class BookReportFLDController extends MyController {
  List<AppointmentListModel> bookReportList = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? fromSelectedTime;
  TimeOfDay? toSelectedTime;
  bool isView = false;




  int rowsPerPage = 5; // Default rows per page

  List<int> pageList =  List.generate(10, (index) {
    return index + 1;
  });
  int selectedIndex = 0;
  int selectPageLength = 10;
  List<int> pageDropDownList = [10,20,50,100,200,500];
  List<int> pageNavButton = [1];

  int itemsPerPage = 10;
  int maxVisiblePages = 5;

  int get totalPages => (bookReportList.length / selectPageLength).ceil();
  int get startIndex => selectedIndex * selectPageLength;
  int get endIndex => (startIndex + selectPageLength).clamp(0, bookReportList.length);


  int get startPage => (selectedIndex ~/ maxVisiblePages) * maxVisiblePages;
  int get endPage => (startPage + maxVisiblePages - 1).clamp(0, totalPages - 1);



  @override
  void onInit() {
    AppointmentListModel.dummyList.then((value) {
      bookReportList = value;
      update();
    });
    super.onInit();
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


  onPagesList(values){
    selectPageLength =values;
    update();
  }

  gotoNextPage(){
    selectedIndex++;
    update();
  }

  gotoPreviesPage(){
    selectedIndex--;
    update();
  }

  gotoPage(){
    update();
  }

  void updatePagination() {
    update(); // Notify UI of changes
  }


}