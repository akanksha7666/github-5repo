import 'package:medicare/admin_boobud/dataModel/UserDataModel.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/model/patient_list_model.dart';
import 'package:medicare/views/my_controller.dart';
import 'package:get/get.dart';

class UserListController extends MyController {

  List<UserDataModel> userModelList = [];

  int rowsPerPage = 5; // Default rows per page

  List<int> pageList =  List.generate(10, (index) {
    return index + 1;
  });
  int selectedIndex = 0;
  int selectPageLength = 10;
  List<int> pageDropDownList = [10,20,50,100,200,500];
  List<int> pageNavButton = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  int itemsPerPage = 10;
  int maxVisiblePages = 5;

  int get totalPages => (userModelList.length / selectPageLength).ceil();
  int get startIndex => selectedIndex * selectPageLength;
  int get endIndex => (startIndex + selectPageLength).clamp(0, userModelList.length);


  int get startPage => (selectedIndex ~/ maxVisiblePages) * maxVisiblePages;
  int get endPage => (startPage + maxVisiblePages - 1).clamp(0, totalPages - 1);
  @override
  void onInit() {
    selectPageLength = pageDropDownList[0];
    userModelList = generateDummyUsers(500);
    update();
    super.onInit();
  }


  void goEditScreen() {
    Get.toNamed('/admin/user/edit');
  }

  void goDetailScreen() {
    Get.toNamed('/admin/user/detail');
  }
  void goDeleteScreen() {
    alertBoxData();
    Debug.printLog("delete user");
  }

  void alertBoxData() {
    Constant.showConfirmationDialog(
      Get.context!,
      "Delete User?",
      "Are you sure you want to delete this User?",
          () {
        Get.back();
      },
    );
  }


  void addUser() {
    Get.toNamed('/admin/user/add');
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