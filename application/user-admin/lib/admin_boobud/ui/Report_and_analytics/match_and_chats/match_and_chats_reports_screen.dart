import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:medicare/admin_boobud/controller/Report_and_analytics/match_and_chats/match_and_chats_report_controller.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/app_constant.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/utils/utils.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_flex.dart';
import 'package:medicare/helpers/widgets/my_flex_item.dart';
import 'package:medicare/helpers/widgets/my_list_extension.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/my_text_style.dart';
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:medicare/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchAndChatsReportFLDScreen extends StatefulWidget {
  const MatchAndChatsReportFLDScreen({super.key});

  @override
  State<MatchAndChatsReportFLDScreen> createState() => MatchAndChatsReportFLDScreenState();
}

class MatchAndChatsReportFLDScreenState extends State<MatchAndChatsReportFLDScreen> with UIMixin {
  MatchAndChatsReportFLDController controller = Get.put(MatchAndChatsReportFLDController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'MatchAndChatsReportFLDController',
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
                      "Match & Chats Reports",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Reports & Analytics', active: true),
                        MyBreadcrumbItem(name: 'Match & Chats Reports', active: true),
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
                      filterReportDetail(),
                      MySpacing.height(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyContainer(
                            onTap: controller.exportData,
                            padding: MySpacing.xy(12, 8),
                            borderRadiusAll: 8,
                            color: contentTheme.secondary,
                            child: MyText.labelSmall("Export Data",fontWeight: 600,color: contentTheme.primary),
                          ),
                          MySpacing.width(20),
                          MyContainer(
                            onTap: controller.onView,
                            padding: MySpacing.xy(12, 8),
                            borderRadiusAll: 8,
                            color: contentTheme.primary,
                            child: MyText.labelSmall("View Report", fontWeight: 600, color: contentTheme.onPrimary),
                          ),
                        ],
                      ),
                      MySpacing.height(20),

                      if(controller.isView)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              if (controller.matchAndChatList.isNotEmpty)
                                Row(
                                  children: [
                                    _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                    _widgetTableHeadBox(-1, 200, "User Name"),
                                    _widgetTableHeadBox(-1, 300, "User Email"),
                                    _widgetTableHeadBox(-1, 220, "Mobile Number"),
                                    _widgetTableHeadBox(-1, 220, "Date",),
                                    _widgetTableHeadBox(-1, 220, "Time",isLast: true),
                                  ],
                                ),

                              // Paginated Table Body
                              for (int index = controller.startIndex;
                              index < controller.endIndex;
                              index++)
                                Row(
                                  children: [
                                    _widgetTableBody(index, 150, controller.matchAndChatList[index].id.toString(), isFirst: true),
                                    _widgetTableBody(index, 200, controller.matchAndChatList[index].name.toString()),
                                    _widgetTableBody(index, 300, controller.matchAndChatList[index].email.toString()),
                                    _widgetTableBody(index, 220, controller.matchAndChatList[index].mobile.toString()),
                                    _widgetTableBody(index, 220, Utils.getDateStringFromDateTime(controller.matchAndChatList[index].date, showMonthShort: true)),
                                    _widgetTableBody(index, 220, Utils.getTimeStringFromDateTime(controller.matchAndChatList[index].date, showSecond: false),isLast: true),
                                    /* _widgetAction(index, 160,
                                      () => controller.goEditScreen(),
                                      () => controller.goDetailScreen(),
                                      () => controller.goDeleteScreen(),
                                  isLast: true),*/
                                  ],
                                ),



                            ],
                          ),
                        ),
                      if(controller.matchAndChatList.isNotEmpty)
                        if(controller.isView)
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
                                        "Showing : 1-10 of 500 Match & Chats Data",
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


                      // if(controller.isView)
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: DataTable(
                      //       sortAscending: true,
                      //       columnSpacing: 60,
                      //       onSelectAll: (_) => {},
                      //       headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                      //       dataRowMaxHeight: 60,
                      //       showBottomBorder: true,
                      //       clipBehavior: Clip.antiAliasWithSaveLayer,
                      //       border: TableBorder.all(
                      //           borderRadius: BorderRadius.circular(12), style: BorderStyle.solid, width: .4, color: contentTheme.secondary),
                      //       columns: [
                      //         DataColumn(label: MyText.labelLarge('Name', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Consulting Doctor', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Treatment', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Mobile', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Email', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Time', color: contentTheme.primary)),
                      //         DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                      //       ],
                      //       rows: controller.matchAndChatList
                      //           .mapIndexed((index, data) => DataRow(cells: [
                      //                 DataCell(SizedBox(
                      //                   width: 250,
                      //                   child: Row(
                      //                     children: [
                      //                       MyContainer.rounded(
                      //                         height: 36,
                      //                         width: 36,
                      //                         paddingAll: 0,
                      //                         clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                         child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                      //                       ),
                      //                       MySpacing.width(12),
                      //                       MyText.labelLarge(data.name),
                      //                     ],
                      //                   ),
                      //                 )),
                      //                 DataCell(SizedBox(width: 150, child: MyText.bodySmall('Dr. ${data.consultingDoctor}', fontWeight: 600))),
                      //                 DataCell(MyText.bodySmall(data.treatment, fontWeight: 600)),
                      //                 DataCell(MyText.bodySmall(data.mobile, fontWeight: 600)),
                      //                 DataCell(SizedBox(width: 250, child: MyText.bodySmall(data.email, fontWeight: 600))),
                      //                 DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(data.date, showMonthShort: true), fontWeight: 600)),
                      //                 DataCell(MyText.bodySmall(Utils.getTimeStringFromDateTime(data.time, showSecond: false), fontWeight: 600)),
                      //                 DataCell(Row(
                      //                   children: [
                      //                     MyContainer(
                      //                       onTap: controller.goToSchedulingScreen,
                      //                       paddingAll: 8,
                      //                       color: contentTheme.secondary.withAlpha(32),
                      //                       child: Icon(Icons.payments_outlined, size: 16),
                      //                     ),
                      //                     MySpacing.width(20),
                      //                     MyContainer(
                      //                       onTap: controller.goToSchedulingScreen,
                      //                       paddingAll: 8,
                      //                       color: contentTheme.secondary.withAlpha(32),
                      //                       child: Icon(LucideIcons.eye, size: 16),
                      //                     ),
                      //                     MySpacing.width(20),
                      //                     MyContainer(
                      //                       onTap: controller.goToSchedulingEditScreen,
                      //                       paddingAll: 8,
                      //                       color: contentTheme.secondary.withAlpha(32),
                      //                       child: Icon(LucideIcons.pencil, size: 16),
                      //                     ),
                      //                   ],
                      //                 )),
                      //               ]))
                      //           .toList()),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
      child: MyText.labelLarge(title, color: contentTheme.primary,maxLines: 1,overflow: TextOverflow.ellipsis,),
    );
  }

  _widgetAction(int index,double width,Function edit,Function view,Function delete,{bool isFirst = false,bool isLast = false}){
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


  Widget filterReportDetail() {
    return MyFlex(contentPadding: false, children: [
      MyFlexItem(
          sizes: 'lg-6 md-6',
          child: commonTextField(title: "Match & Chats Name", hintText: "Please Enter Match & Chats Name", prefixIcon: Icon(Icons.person, size: 16))),
      MyFlexItem(
          sizes: 'lg-6 md-6',
          child: commonTextField(title: "User Id", hintText: "Please Enter User Id", prefixIcon: Icon(Icons.person, size: 16))),

      MyFlexItem(
          sizes: 'lg-6 md-6',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.labelMedium("Date of Start", fontWeight: 600, muted: true),
              MySpacing.height(8),
              TextFormField(
                onTap: () => controller.pickStartDate(),
                style: MyTextStyle.bodySmall(),
                controller: TextEditingController(text: controller.selectedStartDate != null ? dateFormatter.format(controller.selectedStartDate!) : ""),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Date of Start Report",
                  hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                  isCollapsed: true,
                  isDense: true,
                  prefixIcon: Icon(LucideIcons.calendar),
                  contentPadding: MySpacing.all(16),
                ),
              ),
            ],
          )),
      MyFlexItem(
          sizes: 'lg-6 md-6',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.labelMedium("Date of End", fontWeight: 600, muted: true),
              MySpacing.height(8),
              TextFormField(
                onTap: () => controller.pickEndDate(),
                style: MyTextStyle.bodySmall(),
                controller: TextEditingController(text: controller.selectedEndDate != null ? dateFormatter.format(controller.selectedEndDate!) : ""),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Date of End Report",
                  hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                  isCollapsed: true,
                  isDense: true,
                  prefixIcon: Icon(LucideIcons.calendar),
                  contentPadding: MySpacing.all(16),
                ),
              ),
            ],
          )),
    ]);
  }

  Widget commonTextField({String? title, String? hintText, Widget? prefixIcon, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(title ?? "", fontWeight: 600, muted: true),
        MySpacing.height(8),
        TextFormField(
          controller: controller,
          style: MyTextStyle.bodySmall(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: hintText,
            hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
            isCollapsed: true,
            isDense: true,
            prefixIcon: prefixIcon,
            contentPadding: MySpacing.all(16),
          ),
        ),
      ],
    );
  }



}
