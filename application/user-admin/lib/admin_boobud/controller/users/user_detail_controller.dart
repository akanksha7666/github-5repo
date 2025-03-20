import 'package:get/get.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/helpers/utils/my_utils.dart';
import 'package:medicare/views/my_controller.dart';

class UserDetailController extends MyController {
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));


  void goEditScreen() {
    Get.toNamed('/admin/user/edit');
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

}