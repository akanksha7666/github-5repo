import 'package:medicare/admin_boobud/controller/dashboard/dashboard_controller.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
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
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:medicare/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with UIMixin {
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'DashboardController',
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
                      "Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        // MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats(contentTheme.primary, LucideIcons.user, "101", "Total Users")),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats(contentTheme.primary, LucideIcons.currency, "83", "Active Subscriptions")),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats(contentTheme.warning, LucideIcons.dollar_sign, "\$1200", "Revenue Summary")),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats(contentTheme.success, LucideIcons.shield_alert, "272", "Pending Verifications")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Appointment", "639")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Doctor", "83")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Staff", "296")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Operations", "44")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Admitted", "372")),
                    // MyFlexItem(sizes: 'lg-2 md-4', child: secondStats(LucideIcons.badge_check, "Discharge", "253")),
                    MyFlexItem(sizes: 'lg-6', child: treatmentType()),
                    MyFlexItem(sizes: 'lg-6', child: patientByAge()),
                    // MyFlexItem(sizes: 'lg-12', child: MyContainer()),
                    // MyFlexItem(sizes: 'lg-12', child: appointment()),
                    MyFlexItem(sizes: 'lg-12', child: MyContainer(
                      paddingAll: 20,
                      borderRadiusAll: 12,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.titleLarge("Recent Activities", fontWeight: 600),
                            MySpacing.height(10),
                            MyText.titleMedium("Latest signups", fontWeight: 600),
                            MySpacing.height(20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  if (controller.userModelList.isNotEmpty)
                                    Row(
                                      children: [
                                        _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                        _widgetTableHeadBox(-1, 150, "User Name"),
                                        _widgetTableHeadBox(-1, 220, "User Email"),
                                        _widgetTableHeadBox(-1, 220, "Subscription Status"),
                                        _widgetTableHeadBox(-1, 220, "Verification Status",isLast: true),
                                      ],
                                    ),

                                  // Paginated Table Body
                                  for (int index = 0;
                                  index < 5;
                                  index++)
                                    Row(
                                      children: [
                                        _widgetTableBody(index, 150, controller.userModelList[index].id.toString(), isFirst: true),
                                        _widgetTableBody(index, 150, controller.userModelList[index].name.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].email.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].subscriptionStatus.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].verificationStatus.toString(),isLast: true),
                                      ],
                                    ),



                                ],
                              ),
                            ),
                            MySpacing.height(20),
                            MyText.titleMedium("payments", fontWeight: 600),
                            MySpacing.height(20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  if (controller.userModelList.isNotEmpty)
                                    Row(
                                      children: [
                                        _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                        _widgetTableHeadBox(-1, 150, "User Name"),
                                        _widgetTableHeadBox(-1, 220, "User Email"),
                                        _widgetTableHeadBox(-1, 220, "Subscription Status"),
                                        _widgetTableHeadBox(-1, 220, "Verification Status",isLast: true),
                                      ],
                                    ),

                                  // Paginated Table Body
                                  for (int index = 0;
                                  index < 5;
                                  index++)
                                    Row(
                                      children: [
                                        _widgetTableBody(index, 150, controller.userModelList[index].id.toString(), isFirst: true),
                                        _widgetTableBody(index, 150, controller.userModelList[index].name.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].email.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].subscriptionStatus.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].verificationStatus.toString(),isLast: true),
                                      ],
                                    ),



                                ],
                              ),
                            ),
                            MySpacing.height(20),
                            MyText.titleMedium("verifications", fontWeight: 600),
                            MySpacing.height(20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  if (controller.userModelList.isNotEmpty)
                                    Row(
                                      children: [
                                        _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                        _widgetTableHeadBox(-1, 150, "User Name"),
                                        _widgetTableHeadBox(-1, 220, "User Email"),
                                        _widgetTableHeadBox(-1, 220, "Subscription Status"),
                                        _widgetTableHeadBox(-1, 220, "Verification Status",isLast: true),
                                      ],
                                    ),

                                  // Paginated Table Body
                                  for (int index = 0;
                                  index < 5;
                                  index++)
                                    Row(
                                      children: [
                                        _widgetTableBody(index, 150, controller.userModelList[index].id.toString(), isFirst: true),
                                        _widgetTableBody(index, 150, controller.userModelList[index].name.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].email.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].subscriptionStatus.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].verificationStatus.toString(),isLast: true),
                                      ],
                                    ),



                                ],
                              ),
                            ),
                            MySpacing.height(20),
                            MyText.titleMedium("book uploads", fontWeight: 600),
                            MySpacing.height(20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  if (controller.userModelList.isNotEmpty)
                                    Row(
                                      children: [
                                        _widgetTableHeadBox(-1, 150, "ID", isFirst: true),
                                        _widgetTableHeadBox(-1, 150, "User Name"),
                                        _widgetTableHeadBox(-1, 220, "User Email"),
                                        _widgetTableHeadBox(-1, 220, "Subscription Status"),
                                        _widgetTableHeadBox(-1, 220, "Verification Status",isLast: true),
                                      ],
                                    ),

                                  // Paginated Table Body
                                  for (int index = 0;
                                  index < 5;
                                  index++)
                                    Row(
                                      children: [
                                        _widgetTableBody(index, 150, controller.userModelList[index].id.toString(), isFirst: true),
                                        _widgetTableBody(index, 150, controller.userModelList[index].name.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].email.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].subscriptionStatus.toString()),
                                        _widgetTableBody(index, 220, controller.userModelList[index].verificationStatus.toString(),isLast: true),
                                      ],
                                    ),



                                ],
                              ),
                            ),
                            MySpacing.height(20),

                          ],
                        ),
                      ),
                    ),),
                    // MyFlexItem(sizes: 'lg-4.5', child: doctorList()),
                  ],
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
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ? index == 4 ?   12 :0 : 0.0),bottomRight: Radius.circular(isLast ?   index == 4 ?   12 :0   : 0.0)),
      width: width,
      child: MyText.labelLarge(title, color: contentTheme.primary),
    );
  }


  Widget stats(Color color, IconData icon, String title, String subTitle) {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Row(
        children: [
          MyContainer.roundBordered(
            paddingAll: 8,
            borderColor: color,
            child: MyContainer.rounded(
              color: color,
              height: 44,
              width: 44,
              paddingAll: 0,
              borderRadiusAll: 8,
              child: Icon(icon, color: contentTheme.onPrimary),
            ),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleLarge(title, fontWeight: 600, overflow: TextOverflow.ellipsis),
                MyText.bodySmall(subTitle, fontWeight: 600, muted: true, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget secondStats(IconData icon, String title, String subTitle) {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyContainer.rounded(
            color: contentTheme.primary,
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Icon(icon, color: contentTheme.onPrimary),
          ),
          MyText.bodySmall(title),
          MyText.titleLarge(subTitle, fontWeight: 600, xMuted: true, color: contentTheme.primary),
        ],
      ),
    );
  }

  Widget treatmentType() {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("User growth trends", fontWeight: 600),
          MySpacing.height(20),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            legend: Legend(position: LegendPosition.bottom, isVisible: true),
            primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
            primaryYAxis: const NumericAxis(
                minimum: 30, maximum: 80, axisLine: AxisLine(width: 0), edgeLabelPlacement: EdgeLabelPlacement.shift, labelFormat: '{value}', majorTickLines: MajorTickLines(size: 0)),
            series: controller.treatmentTypeChart(),
            tooltipBehavior: TooltipBehavior(enable: true),
          )
        ],
      ),
    );
  }

  Widget patientByAge() {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Subscription revenue graph", fontWeight: 600),
          MySpacing.height(20),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
            ),
            primaryYAxis: const NumericAxis(maximum: 20, minimum: 0, interval: 4, axisLine: AxisLine(width: 0), majorTickLines: MajorTickLines(size: 0)),
            series: controller.patientByAgeChart(),
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: controller.tooltipBehavior,
          )
        ],
      ),
    );
  }

  Widget tableHeadBox(int index,double width,String title,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      alignment: Alignment.center,
      color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(isFirst ?  12 : 0.1),topRight: Radius.circular(isLast ?  12 : 0.1)),
      width: width,
      child: MyText.labelLarge(title, color: contentTheme.primary),
    ) /*: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 60
      ),
      width: width ?? 150,
      child: MyText.labelMedium(index == -1 ?  'Plan Name':controller.subscriptionDataList[index].id.toString()),
    )*/;
  }

  Widget tableBody(int index,double width,String title,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      alignment: Alignment.center,
      // color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ?  12  : 0.0),bottomRight: Radius.circular(isLast ?  12 : 0.0)),
      width: width,
      child: MyText.labelLarge(title, color: contentTheme.primary),
    ) /*: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 60
      ),
      width: width ?? 150,
      child: MyText.labelMedium(index == -1 ?  'Plan Name':controller.subscriptionDataList[index].id.toString()),
    )*/;
  }

  // Widget appointment() {
  //   return MyContainer(
  //     paddingAll: 20,
  //     borderRadiusAll: 12,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         MyText.titleMedium("Recent Activities", fontWeight: 600),
  //         MySpacing.height(20),
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: DataTable(
  //               sortAscending: true,
  //               columnSpacing: 60,
  //               onSelectAll: (_) => {},
  //               headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
  //               dataRowMaxHeight: 60,
  //               showBottomBorder: true,
  //               clipBehavior: Clip.antiAliasWithSaveLayer,
  //               border: TableBorder.all(borderRadius: BorderRadius.circular(8), style: BorderStyle.solid, width: .4, color: Colors.grey),
  //               columns: [
  //                 DataColumn(label: MyText.labelLarge('Profile', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Email', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Location', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Bod', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Book Genres', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Book Author', color: contentTheme.primary)),
  //                 DataColumn(label: MyText.labelLarge('Favorite Books', color: contentTheme.primary)),
  //               ],
  //               rows: controller.appointment
  //                   .mapIndexed((index, data) => DataRow(cells: [
  //                         DataCell(SizedBox(
  //                           width: 200,
  //                           child: Row(
  //                             children: [
  //                               MyContainer.rounded(height: 36, width: 36, paddingAll: 0, clipBehavior: Clip.antiAliasWithSaveLayer, child: Image.asset(Images.avatars[index % Images.avatars.length])),
  //                               MySpacing.width(20),
  //                               MyText.labelLarge(data['patient_name'], overflow: TextOverflow.ellipsis, maxLines: 1),
  //                             ],
  //                           ),
  //                         )),
  //                         DataCell(MyText.bodySmall(data['gender'], fontWeight: 600)),
  //                         DataCell(SizedBox(width: 200, child: MyText.bodySmall("${data['appointment_for']}", fontWeight: 600))),
  //                         DataCell(SizedBox(width: 100, child: MyText.bodySmall(Utils.getDateStringFromDateTime(data['date'], showMonthShort: true), fontWeight: 600))),
  //                         DataCell(SizedBox(width: 100, child: MyText.bodySmall(data['genres'],  fontWeight: 600))),
  //                         DataCell(SizedBox(width: 100, child: MyText.bodySmall(data['author'],  fontWeight: 600))),
  //                         DataCell(SizedBox(width: 100, child: MyText.bodySmall(data['favoriteBooks'], fontWeight: 600))),
  //                       ]))
  //                   .toList()),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget doctorList() {
  //   Widget doctorDetail(String image, String doctorName, String professionalization) {
  //     return Padding(
  //       padding: MySpacing.x(20),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           MyContainer.rounded(
  //             height: 44,
  //             width: 44,
  //             paddingAll: 0,
  //             clipBehavior: Clip.antiAliasWithSaveLayer,
  //             child: Image.asset(image, fit: BoxFit.cover),
  //           ),
  //           MySpacing.width(20),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 MyText.titleMedium("Dr. $doctorName", fontWeight: 600),
  //                 MyText.bodySmall(professionalization, muted: true),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             children: [
  //               Icon(Icons.circle_rounded, size: 8, color: contentTheme.success),
  //               MySpacing.width(8),
  //               MyText.bodyMedium("Available", fontWeight: 600, overflow: TextOverflow.ellipsis),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   return MyContainer(
  //     borderRadiusAll: 12,
  //     paddingAll: 0,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: MySpacing.all(20),
  //           child: MyText.titleMedium("Doctor List", fontWeight: 600),
  //         ),
  //         doctorDetail(Images.avatars[0], "Gabrielle Boris", "MBBS"),
  //         Divider(height: 33),
  //         doctorDetail(Images.avatars[1], "Heather Allan", "Neurology"),
  //         Divider(height: 33),
  //         doctorDetail(Images.avatars[2], "Penelope Greene", "MBBS"),
  //         Divider(height: 33),
  //         doctorDetail(Images.avatars[3], "Madeleine Hodges", "MS, DLO"),
  //         Divider(height: 33),
  //         doctorDetail(Images.avatars[4], "Melanie Cameron", "MD, Neurology"),
  //         MySpacing.height(20),
  //       ],
  //     ),
  //   );
  // }
}
