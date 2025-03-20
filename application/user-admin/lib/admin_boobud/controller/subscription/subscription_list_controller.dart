import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicare/admin_boobud/dataModel/SubscriptionModel.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/images.dart';
import 'package:medicare/views/my_controller.dart';

class SubscriptionListController extends MyController {
  List<SubscriptionModel> subscriptionDataList = [];
  bool isRemarks = false, showOkAction = true, showBanner = false, showLeadingIcon = true, sticky = false;

  SubscriptionDataSource? dataSource;
  int rowsPerPage = 5; // Default rows per page

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<int> pageList =  List.generate(10, (index) {
    return index + 1;
  });
  int selectedIndex = 0;
  int selectPageLength = 10;
  List<int> pageDropDownList = [10,20,50,100,200,500];
  List<int> pageNavButton = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

  int itemsPerPage = 10;
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
    update();
    super.onInit();
  }

  void onChangeSticky(bool? value) {
    if (value != null) {
      sticky = value;
      update();
    }
  }

  void goEditSubscriptionScreen() {
    Get.toNamed('/admin/subscription/edit');
  }

  void goSubscriptionViewScreen() {
    Get.toNamed('/admin/subscription/view');
  }

  void addSubscription() {
    Get.toNamed('/admin/subscription/add');
  }

  void exportData() {
    if (formKey.currentState!.validate()) {
      Debug.printLog("Form has validation !");
      Constant.shankBarCustomWeb(
          Get.context!, "Subscription Plan added Successfully");
      Get.toNamed('/admin/subscription/edit');
    } else {
      Debug.printLog("Form has validation errors!");
      Constant.shankBarCustomWeb(
          Get.context!, "Please Enter a valid Information");
    }
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




  void updatePagination() {
    update(); // Notify UI of changes
  }

  void goDeleteScreen() {
    alertBoxData();
    /// delete Action header
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


}

enum PlanDuration {
  days,
  months,
  years;

  const PlanDuration();
}

class SubscriptionDataSource extends DataTableSource {
  final List<SubscriptionModel> subscriptions;
  final Function(int) onView;
  final Function(int) onEdit;
  final Function(int) onDelete;

  SubscriptionDataSource({
    required this.subscriptions,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final data = subscriptions[index];

    return DataRow(
      cells: [
        // 🔹 Plan Name with Image
        DataCell(Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              height: 32,
              width: 32,
              child: Image.asset(
                Images.avatars[index % Images.avatars.length],
                fit: BoxFit.cover,
              ),
            ),
            MySpacing.width(12),
            Expanded(child: MyText.bodySmall(data.planName)),
          ],
        )),

        // 🔹 Plan Duration
        DataCell(MyText.bodySmall(data.planDuration, maxLines: 1)),

        // 🔹 Term
        DataCell(MyText.bodySmall(data.term, maxLines: 1)),

        // 🔹 Amount
        DataCell(MyText.bodySmall("\$${data.amount}", maxLines: 1)),

        // 🔹 Remarks
        DataCell(MyText.bodySmall(data.remarks, maxLines: 1)),

        // 🔹 Start Date
        DataCell(MyText.bodySmall(DateFormat('yyyy-MM-dd').format(data.startTime))),

        // 🔹 End Date
        DataCell(MyText.bodySmall(DateFormat('yyyy-MM-dd').format(data.endTime))),

        // 🔹 Actions (View, Edit, Delete)
        DataCell(Row(
          children: [
            _actionButton(icon: LucideIcons.eye, color: Colors.blue, onTap: () => onView(index)),
            MySpacing.width(6),
            _actionButton(icon: LucideIcons.pencil, color: Colors.green, onTap: () => onEdit(index)),
            MySpacing.width(6),
            _actionButton(icon: Icons.delete_forever_sharp, color: Colors.red, onTap: () => onDelete(index)),
          ],
        )),
      ],
    );
  }

  /// 🔹 Custom Action Button for Icons
  Widget _actionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  @override
  int get rowCount => subscriptions.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
