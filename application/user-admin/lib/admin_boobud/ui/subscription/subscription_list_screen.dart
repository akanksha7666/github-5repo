import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/controller/subscription/subscription_list_controller.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_button.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_flex.dart';
import 'package:medicare/helpers/widgets/my_flex_item.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/my_text_style.dart';
import 'package:medicare/helpers/widgets/responsive.dart';

class SubscriptionListScreen extends StatefulWidget {
  const SubscriptionListScreen({super.key});

  @override
  State<SubscriptionListScreen> createState() => SubscriptionListScreenState();
}

class SubscriptionListScreenState extends State<SubscriptionListScreen>
    with UIMixin {
  SubscriptionListController controller = Get.put(SubscriptionListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'SubscriptionListController',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Subscription List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        // MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(
                            name: 'Subscription List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  paddingAll: 20,
                  borderRadiusAll: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFlex(
                          wrapCrossAlignment: WrapCrossAlignment.center,
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                              sizes: 'lg-4 md-4',
                              child: MyText.bodyMedium(
                                  "Subscription List",
                                  fontWeight: 600,
                                  muted: true),
                            ),
                            MyFlexItem(
                              sizes: 'lg-8 md-8',
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    MyButton(
                                      onPressed: () {
                                        controller.addSubscription();
                                      },
                                      elevation: 0,
                                      borderRadiusAll: 8,
                                      padding: MySpacing.xy(18, 18),
                                      backgroundColor: colorScheme.primary,
                                      child: Row(
                                        children: [
                                          Icon(Icons.add,size: 16,),
                                          MyText.labelMedium(
                                            "Add Subscription",
                                            fontWeight: 600,
                                            color: colorScheme.onPrimary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            MyFlexItem(
                              sizes: 'lg-7 md-7',
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: DropdownButtonFormField(
                                        value: PlanDuration.values.first,
                                        // ✅ Default selected value (0th index)
                                        dropdownColor:
                                        contentTheme.background,
                                        isDense: true,
                                        style: MyTextStyle.bodySmall(),
                                        items: PlanDuration.values
                                            .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: MyText.bodySmall(category.name.capitalize!),
                                        ))
                                            .toList(),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(LucideIcons.chevron_down,
                                            size: 16),
                                        onChanged: (v) {
                                          controller.onPagesList(v);
                                        },
                                        alignment: Alignment.center,
                                        decoration: InputDecoration(
                                            errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                            hintText: "plan",
                                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                            contentPadding: MySpacing.all(12),
                                            isCollapsed: true,
                                            isDense: true,
                                            prefixIcon: Icon(LucideIcons.calendar_days, size: 16),
                                            floatingLabelBehavior: FloatingLabelBehavior.never),
                                        // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                                      ),
                                    ),
                                    MyContainer(
                                        padding: MySpacing.x(flexSpacing),
                                        child: buildIsActiveNotActive()),
                                    Spacer(flex: 2,),
                                  ],
                                ),
                              ),
                            ),
                            MyFlexItem(
                          sizes: 'lg-5 md-5',
                              child:
                              commonTextField(prefixIcon: Icon(Icons.search)),
                            ),

                          ]),
                      MySpacing.height(20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            if (controller.subscriptionDataList.isNotEmpty)
                              Row(
                              children: [
                                _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                _widgetTableHeadBox(-1, 150, "Plan Name"),
                                _widgetTableHeadBox(-1, 150, "Plan Duration"),
                                _widgetTableHeadBox(-1, 220, "Term"),
                                _widgetTableHeadBox(-1, 150, "Amount"),
                                _widgetTableHeadBox(-1, 150, "Remarks"),
                                _widgetTableHeadBox(-1, 250, "Start Date"),
                                _widgetTableHeadBox(-1, 250, "End Date"),
                                _widgetTableHeadBox(-1, 150, "Is Active"),
                                _widgetTableHeadBox(-1, 160, "Action", isLast: true),
                              ],
                            ),

                            // Paginated Table Body
                            for (int index = controller.startIndex;
                            index < controller.endIndex;
                            index++)
                              Row(
                                children: [
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].id.toString(), isFirst: true),
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].planName.toString()),
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].planDuration.toString()),
                                  _widgetTableBody(index, 220, controller.subscriptionDataList[index].term.toString()),
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].amount.toString()),
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].remarks.toString()),
                                  _widgetTableBody(index, 250, controller.subscriptionDataList[index].startTime.toString()),
                                  _widgetTableBody(index, 250, controller.subscriptionDataList[index].endTime.toString()),
                                  _widgetTableBody(index, 150, controller.subscriptionDataList[index].remarks.toString()),
                                  _widgetAction(index, 160, controller.subscriptionDataList[index].amount.toString(),
                                          () => controller.goEditSubscriptionScreen(),
                                          () => controller.goSubscriptionViewScreen(),
                                          () => controller.goDeleteScreen(),
                                      isLast: true),
                                ],
                              ),



                          ],
                        ),
                      ),
                      if(controller.subscriptionDataList.isNotEmpty)
                        MyContainer(
                          margin: MySpacing.only(
                              top: 10
                          ),
                          paddingAll: 0,
                          child: MyFlex(
                            contentPadding: false,
                            children: [
                              MyFlexItem(
                                sizes: MediaQuery.of(context).size.width > 1300 ? 'lg-4 md-4':'lg-12 md-12',
                                child: MyContainer(
                                  bordered: false,
                                  onTap: () {
                                    Debug.printLog("Back Page");
                                  },
                                  margin: MySpacing.symmetric(horizontal: 2),
                                  child: MyText.titleMedium(
                                      "Showing : 1-10 of 1201 Subscription Data",
                                      color: contentTheme.black),
                                ),
                              ),
                              if(MediaQuery.of(context).size.width < 800)
                                MyFlexItem(
                                  sizes: MediaQuery.of(context).size.width < 800  ? 'lg-12 md-12' :MediaQuery.of(context).size.width > 1300 ? 'lg-8 md-8' :'lg-12 md-12',
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Spacer(),
                                      Expanded(
                                        child: DropdownButtonFormField(
                                          value: controller.selectPageLength,
                                          // ✅ Default selected value (0th index)
                                          dropdownColor: contentTheme.background,
                                          isDense: true,
                                          style: MyTextStyle.bodySmall(),
                                          items: controller.pageDropDownList
                                              .map((select) => DropdownMenuItem(
                                            value: select,
                                            child: MyText.bodySmall(
                                                select.toString()),
                                          ))
                                              .toList(),
                                          padding: EdgeInsets.zero,
                                          icon: Icon(LucideIcons.chevron_down,
                                              size: 16),
                                          onChanged: (v) {
                                            controller.onPagesList(v);
                                          },
                                          alignment: Alignment.center,
                                          decoration: InputDecoration(
                                              hintText: "page",
                                              hintStyle: MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12)),
                                              contentPadding: MySpacing.all(12),
                                              prefixIcon:
                                              Icon(Icons.list_alt, size: 16),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never),
                                          // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              MyFlexItem(
                                sizes: MediaQuery.of(context).size.width < 800  ? 'lg-12 md-12' :MediaQuery.of(context).size.width > 1300 ? 'lg-8 md-8' :'lg-12 md-12',
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    Spacer(),
                                    if(!(MediaQuery.of(context).size.width < 800))
                                      Expanded(
                                        child: DropdownButtonFormField(
                                          value: controller.selectPageLength,
                                          // ✅ Default selected value (0th index)
                                          dropdownColor: contentTheme.background,
                                          isDense: true,
                                          style: MyTextStyle.bodySmall(),
                                          items: controller.pageDropDownList
                                              .map((select) => DropdownMenuItem(
                                            value: select,
                                            child: MyText.bodySmall(
                                                select.toString()),
                                          ))
                                              .toList(),
                                          padding: EdgeInsets.zero,
                                          icon: Icon(LucideIcons.chevron_down,
                                              size: 16),
                                          onChanged: (v) {
                                            controller.onPagesList(v);
                                          },
                                          alignment: Alignment.center,
                                          decoration: InputDecoration(
                                              hintText: "page",
                                              hintStyle: MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12)),
                                              contentPadding: MySpacing.all(12),
                                              prefixIcon:
                                              Icon(Icons.list_alt, size: 16),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never),
                                          // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                                        ),
                                      ),
                                    MyContainer(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    MyContainer(
                                      bordered: true,
                                      margin: MySpacing.symmetric(horizontal: 2),
                                      padding: MySpacing.symmetric(horizontal: 5, vertical: 10),
                                      child: Icon(Icons.keyboard_arrow_left, color: contentTheme.black),
                                      onTap: () {
                                        if (controller.selectedIndex > 0) {
                                          controller.selectedIndex--;
                                          controller.updatePagination();
                                        }
                                      },
                                    ),

                                    // Page Number Buttons (Dynamic)
                                    for (int index = controller.startPage; index <= controller.endPage; index++)
                                      MyContainer(
                                        bordered: true,
                                        onTap: () {
                                          Debug.printLog("Page ${index + 1}");
                                          controller.selectedIndex = index;
                                          controller.gotoPage();
                                        },
                                        color: controller.selectedIndex == index ? contentTheme.primary : null,
                                        margin: MySpacing.symmetric(horizontal: 2),
                                        padding: MySpacing.symmetric(horizontal: 13, vertical: 12),
                                        child: MyText.labelLarge(
                                          (index + 1).toString(),
                                          color: controller.selectedIndex == index ? contentTheme.white : contentTheme.black,
                                        ),
                                      ),

                                    // Next Button
                                    MyContainer(
                                      bordered: true,
                                      margin: MySpacing.symmetric(horizontal: 2),
                                      padding: MySpacing.symmetric(horizontal: 5, vertical: 10),
                                      child: Icon(Icons.keyboard_arrow_right, color: contentTheme.black),
                                      onTap: () {
                                        if (controller.selectedIndex < controller.pageNavButton.length - 1) {
                                          controller.selectedIndex++;
                                          controller.updatePagination();
                                        }
                                      },
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),


                     /* if (controller.subscriptionDataList.isNotEmpty)
                        PaginatedDataTable(
                          headingRowColor: WidgetStatePropertyAll(
                              contentTheme.primary.withAlpha(40)),
                          dataRowMaxHeight: 60,
                          columns: [
                            DataColumn(label: MyText.labelMedium('Plan Name', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Plan Duration', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Term', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Amount', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Remarks', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Start Date', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('End Date', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Action', color: contentTheme.primary)),
                          ],
                          onPageChanged: (page){
                            print(page.toString());
                          },
                          source: controller.dataSource!,
                          rowsPerPage: controller.rowsPerPage,
                          availableRowsPerPage: [5, 10, 20], // Page size options
                          onRowsPerPageChanged: (value) {
                            if (value != null) {
                              setState(() {
                                controller.rowsPerPage = value;
                              });
                            }
                          },
                        ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              sortAscending: true,
                              columnSpacing: 60,
                              onSelectAll: (_) => {},
                              headingRowColor: WidgetStatePropertyAll(
                                  contentTheme.primary.withAlpha(40)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(12),
                                  style: BorderStyle.solid,
                                  width: .4,
                                  color: contentTheme.secondary),
                              columns: [
                                DataColumn(
                                    label: MyText.labelMedium('Plan Name',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Plan Duration',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Term',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Amount',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Remarks',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('IsActive',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Start date',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('End date',
                                        color: contentTheme.primary)),
                                DataColumn(
                                    label: MyText.labelMedium('Action',
                                        color: contentTheme.primary)),
                              ],
                              rows: controller.subscriptionDataList
                                  .mapIndexed((index, data) => DataRow(cells: [
                                        DataCell(SizedBox(
                                          width: 170,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              MyContainer.rounded(
                                                paddingAll: 0,
                                                height: 32,
                                                width: 32,
                                                child: Image.asset(
                                                    Images.avatars[index %
                                                        Images.avatars.length],
                                                    fit: BoxFit.cover),
                                              ),
                                              MySpacing.width(16),
                                              MyText.bodySmall(data.planName),
                                            ],
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                            width: 150,
                                            child: MyText.bodySmall(
                                                data.planName))),
                                        DataCell(SizedBox(
                                            width: 250,
                                            child: MyText.bodySmall(
                                                data.planDuration))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child:
                                                MyText.bodySmall(data.term))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: MyText.bodySmall(
                                                data.amount.toString()))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: MyText.bodySmall(
                                                data.remarks))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: MyText.bodySmall(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(data.startTime),
                                            ))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: MyText.bodySmall(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(data.endTime),
                                            ))),
                                        DataCell(Row(
                                          children: [
                                            MyContainer(
                                              onTap: controller
                                                  .goSubscriptionViewScreen,
                                              paddingAll: 10,
                                              color: contentTheme.secondary
                                                  .withAlpha(32),
                                              child: Icon(LucideIcons.eye,
                                                  size: 16),
                                            ),
                                            MyContainer(
                                              onTap: controller
                                                  .goEditSubscriptionScreen,
                                              paddingAll: 8,
                                              color: contentTheme.secondary
                                                  .withAlpha(32),
                                              child: Icon(LucideIcons.pencil,
                                                  size: 16),
                                            ),
                                            MySpacing.width(20),
                                            MyContainer(
                                              onTap: controller.goDeleteScreen,
                                              paddingAll: 8,
                                              color: contentTheme.danger
                                                  .withAlpha(32),
                                              child: Icon(
                                                  Icons.delete_forever_sharp,
                                                  size: 16),
                                            ),
                                          ],
                                        )),
                                      ]))
                                  .toList()),
                        ),*/
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildIsActiveNotActive() {
    return Switch.adaptive(
      applyCupertinoTheme: true,
      value: controller.sticky,
      onChanged: controller.onChangeSticky,
    );
  }

  _widgetTableHeadBox(int index,double width,String title,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      alignment: Alignment.center,
      color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(isFirst ?  12 : 0.1),topRight: Radius.circular(isLast ?  12 : 0.1)),
      width: width,
      child: MyText.labelLarge(title, color: contentTheme.primary),
    );
  }

  _widgetTableBody(int index,double width,String title,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      alignment: Alignment.center,
      // color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0),bottomRight: Radius.circular(isLast ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0)),
      width: width,
      child: MyText.labelLarge(title, color: contentTheme.primary),
    );
  }

  _widgetAction(int index,double width,String title,Function edit,Function view,Function delete,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      padding: MySpacing.xy(12.1, 12.5),
      // color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0),bottomRight: Radius.circular(isLast ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0)),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyContainer(
            onTap: () {
              edit.call();
            },
            padding: MySpacing.xy(7, 7),
            color: contentTheme.primary.withAlpha(36),
            child: Icon(
              LucideIcons.pencil,
              size: 14,
              color: contentTheme.primary,
            ),
          ),
          MyContainer(
            onTap: () {
              view.call();
            },
            padding: MySpacing.xy(7, 7),
            color: contentTheme.success.withAlpha(36),
            child: Icon(
              LucideIcons.eye,
              size: 14,
              color: contentTheme.success,
            ),
          ),
          MyContainer(
            onTap: () {
              delete.call();
            },
            padding: MySpacing.xy(7, 7),
            color: contentTheme.danger.withAlpha(36),
            child: Icon(
              LucideIcons.trash_2,
              size: 14,
              color: contentTheme.danger,
            ),
          ),
        ],
      ),
    ) /*: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 60
      ),
      width: width ?? 150,
      child: MyText.labelMedium(index == -1 ?  'Plan Name':controller.subscriptionDataList[index].id.toString()),
    )*/;
  }

  Widget commonTextField(
      {String? title,
        String? hintText,
        Widget? prefixIcon,
        void Function()? onTap,
        TextEditingController? teController,
        bool numbered = false,
        int? length}) {
    return TextFormField(
      onTap: onTap ?? () {},
      controller: teController,
      keyboardType: numbered ? TextInputType.phone : null,
      maxLength: length,
      style: MyTextStyle.bodySmall(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
        counterText: "",
        hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
        isCollapsed: true,
        isDense: true,
        prefixIcon: prefixIcon,
        contentPadding: MySpacing.all(16),
      ),
    );
  }


}








/*

class SubscriptionListScreenDummy extends StatefulWidget {
  const SubscriptionListScreenDummy({super.key});

  @override
  State<SubscriptionListScreenDummy> createState() => SubscriptionListScreenDummyState();
}

class SubscriptionListScreenDummyState extends State<SubscriptionListScreenDummy> with UIMixin {
  late SubscriptionListController controller;
  late SubscriptionDataSource _dataSource;
  int _rowsPerPage = 5; // Default rows per page

  @override
  void initState() {
    controller = SubscriptionListController();
    _dataSource = SubscriptionDataSource(
      subscriptions: controller.subscription,
      onView: controller.goSubscriptionViewScreen,
      onEdit: controller.goEditSubscriptionScreen,
      onDelete: controller.goDeleteScreen,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'admin_doctor_list_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Subscription List", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(children: [
                      MyBreadcrumbItem(name: 'Subscription List', active: true),
                    ]),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  paddingAll: 20,
                  borderRadiusAll: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium("Subscription List", fontWeight: 600, muted: true),
                          Row(
                            children: [
                              MyContainer(
                                onTap: controller.exportData,
                                padding: MySpacing.xy(12, 8),
                                borderRadiusAll: 8,
                                color: contentTheme.primary,
                                child: MyText.labelSmall(
                                  "Export Data",
                                  fontWeight: 600,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                              MySpacing.width(20),
                              MyContainer(
                                onTap: controller.addSubscription,
                                padding: MySpacing.xy(12, 8),
                                borderRadiusAll: 8,
                                color: contentTheme.primary,
                                child: MyText.labelSmall(
                                  "Add Subscription",
                                  fontWeight: 600,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      MySpacing.height(20),
                      if (controller.subscription.isNotEmpty)
                        PaginatedDataTable(
                          header: MyText.titleMedium("Subscription List", fontWeight: 600),
                          columns: [
                            DataColumn(label: MyText.labelMedium('Plan Name', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Plan Duration', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Term', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Amount', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Remarks', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Start Date', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('End Date', color: contentTheme.primary)),
                            DataColumn(label: MyText.labelMedium('Action', color: contentTheme.primary)),
                          ],
                          source: _dataSource,
                          rowsPerPage: _rowsPerPage,
                          availableRowsPerPage: [5, 10, 20], // Page size options
                          onRowsPerPageChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _rowsPerPage = value;
                              });
                            }
                          },
                        ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
*/

