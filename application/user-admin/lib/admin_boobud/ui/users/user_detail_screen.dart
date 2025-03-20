import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:medicare/admin_boobud/controller/users/user_detail_controller.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/utils/utils.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_flex.dart';
import 'package:medicare/helpers/widgets/my_flex_item.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:medicare/images.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => UserDetailScreenState();
}

class UserDetailScreenState extends State<UserDetailScreen> with UIMixin {
  UserDetailController controller = Get.put(UserDetailController());
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'admin_patient_detail_controller',
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
                      "User Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'User Management'),
                        MyBreadcrumbItem(name: 'User Detail', active: true),
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
                    MyFlexItem(sizes: 'lg-4 md-6', child: patientDetail()),
                    MyFlexItem(
                        sizes: 'lg-8 md-6',
                        child: Column(
                          children: [about(), /*MySpacing.height(20), *//*generalReport()*/],
                        )),
                    // MyFlexItem(sizes: 'lg-12 md-6', child: doctorVisit()),
                    MyFlexItem(sizes: 'lg-9.7 md-9.7', child: report()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget patientDetail() {
    Widget details(String title, String detail) {
      return Row(
        children: [
          Expanded(child: MyText.bodySmall(title, fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis)),
          Flexible(child: MyText.bodySmall(detail, muted: true, maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      );
    }

    return MyContainer(
      paddingAll: 24,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Details", fontWeight: 600),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyContainer(padding: MySpacing.xy(7, 7),),
                  MyContainer(
                    onTap: () {
                      controller.goEditScreen();
                    },
                    padding: MySpacing.xy(7, 7),
                    color: contentTheme.primary.withAlpha(36),
                    child: Icon(
                      LucideIcons.pencil,
                      size: 14,
                      color: contentTheme.primary,
                    ),
                  ),
                  MyContainer(padding: MySpacing.xy(7, 7)),
                  MyContainer(
                    onTap: () {
                      controller.goDeleteScreen();
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

              // PopupMenuButton(
              //   itemBuilder: (context) {
              //     return [
              //       PopupMenuItem(height: 32, child: MyText.labelSmall("CSV")),
              //       PopupMenuItem(height: 32, child: MyText.labelSmall("Print")),
              //       PopupMenuItem(height: 32, child: MyText.labelSmall("PDF")),
              //       PopupMenuItem(height: 32, child: MyText.labelSmall("Excel")),
              //     ];
              //   },
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              //   offset: Offset(0, 26),
              //   child: Icon(LucideIcons.ellipsis_vertical, size: 16),
              // )
            ],
          ),
          MySpacing.height(20),
          Center(
            child: MyContainer(
              paddingAll: 0,
              height: 200,
              width: 200,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadiusAll: 100,
              child: Image.asset(Images.avatars[9], fit: BoxFit.cover),
            ),
          ),
          MySpacing.height(20),
          MySpacing.height(20),
          details("Name", "Boobud Admin"),
          MySpacing.height(20),
          details("Email", "user1@example.com"),
          MySpacing.height(20),
          details("Phone", "+1234567890"),
          MySpacing.height(20),
          details("Verification Status", "Pending"),
          MySpacing.height(20),
          details("Subscription Status", "Approved"),
          MySpacing.height(20),
        ],
      ),
    );
  }

  Widget about() {
    return MyContainer(
      paddingAll: 24,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Bio", fontWeight: 600),
          MySpacing.height(20),
          MyText.bodySmall(controller.dummyTexts[0], muted: true),
          MySpacing.height(20),
          MyText.bodySmall(controller.dummyTexts[1], muted: true),
          MySpacing.height(20),
          MyText.bodySmall(controller.dummyTexts[1], muted: true),
          MySpacing.height(20),
          MyText.bodySmall(controller.dummyTexts[0], muted: true),
          MySpacing.height(20),
          MyText.bodySmall(controller.dummyTexts[1], muted: true)
        ],
      ),
    );
  }

  Widget generalReport() {
    Widget generalReportWidget(String title, String progress, double value, Color color) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodySmall(title, fontWeight: 600),
              MyText.bodySmall(progress),
            ],
          ),
          MySpacing.height(12),
          LinearProgressIndicator(
            value: value,
            minHeight: 9,
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
        ],
      );
    }

    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("General Report", fontWeight: 600),
          MySpacing.height(20),
          generalReportWidget("Heart Beat", '34', .8, contentTheme.primary),
          MySpacing.height(20),
          generalReportWidget("Blood Pressure", '93', .93, contentTheme.danger),
          MySpacing.height(20),
          generalReportWidget("Sugar", '55', .55, contentTheme.info),
          MySpacing.height(20),
          generalReportWidget("Haemoglobin", '78', .78, contentTheme.warning),
        ],
      ),
    );
  }

  Widget doctorVisit() {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Book Genres", fontWeight: 600),
          MySpacing.height(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                border: TableBorder.all(borderRadius: BorderRadius.circular(12), style: BorderStyle.solid, width: .4, color: contentTheme.secondary),
                columnSpacing: 100,
                dataRowMaxHeight: 75,
                dataRowMinHeight: 75,
                columns: [
                  DataColumn(label: MyText.bodyMedium("Book", fontWeight: 600)),
                  DataColumn(label: MyText.bodyMedium("Book Author", fontWeight: 600)),
                  DataColumn(label: MyText.bodyMedium("Favorite", fontWeight: 600)),
                  DataColumn(label: MyText.bodyMedium("Reports", fontWeight: 600)),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Row(
                      children: [
                        MyContainer(
                          paddingAll: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 32,
                          width: 32,
                          child: Image.asset(Images.avatars[6], fit: BoxFit.cover),
                        ),
                        MySpacing.width(12),
                        MyText.bodySmall("Christian"),
                      ],
                    )),
                    DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2024-10-11T00:00:00Z')))),
                    DataCell(MyText.bodySmall("Dentist")),
                    DataCell(MyContainer(
                      onTap: () {},
                      padding: MySpacing.xy(12, 8),
                      color: contentTheme.primary,
                      child: MyText.bodySmall("View Report", fontWeight: 600, color: contentTheme.onPrimary),
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(Row(
                      children: [
                        MyContainer(
                          paddingAll: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 32,
                          width: 32,
                          child: Image.asset(Images.avatars[7], fit: BoxFit.cover),
                        ),
                        MySpacing.width(12),
                        MyText.bodySmall("Leonard"),
                      ],
                    )),
                    DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-12-12T12:30:00Z')))),
                    DataCell(MyText.bodySmall("Urologist")),
                    DataCell(MyContainer(
                      onTap: () {},
                      padding: MySpacing.xy(12, 8),
                      color: contentTheme.primary,
                      child: MyText.bodySmall("View Report", fontWeight: 600, color: contentTheme.onPrimary),
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(Row(
                      children: [
                        MyContainer(
                          paddingAll: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 32,
                          width: 32,
                          child: Image.asset(Images.avatars[8], fit: BoxFit.cover),
                        ),
                        MySpacing.width(12),
                        MyText.bodySmall("Sebastian"),
                      ],
                    )),
                    DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-09-13T18:45:00Z')))),
                    DataCell(MyText.bodySmall("Surgeon")),
                    DataCell(MyContainer(
                      onTap: () {},
                      padding: MySpacing.xy(12, 8),
                      color: contentTheme.primary,
                      child: MyText.bodySmall("View Report", fontWeight: 600, color: contentTheme.onPrimary),
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(Row(
                      children: [
                        MyContainer(
                          paddingAll: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 32,
                          width: 32,
                          child: Image.asset(Images.avatars[9], fit: BoxFit.cover),
                        ),
                        MySpacing.width(12),
                        MyText.bodySmall("aThomas"),
                      ],
                    )),
                    DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-05-14T07:15:00Z')))),
                    DataCell(MyText.bodySmall("Dentist")),
                    DataCell(MyContainer(
                      onTap: () {},
                      padding: MySpacing.xy(12, 8),
                      color: contentTheme.primary,
                      child: MyText.bodySmall("View Report", fontWeight: 600, color: contentTheme.onPrimary),
                    )),
                  ]),
                ]),
          )
        ],
      ),
    );
  }

  Widget report() {
    return MyContainer(
      paddingAll: 20,
      borderRadiusAll: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Books Report", fontWeight: 600),
          MySpacing.height(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                border: TableBorder.all(borderRadius: BorderRadius.circular(12), style: BorderStyle.solid, width: .4, color: contentTheme.secondary),
                dataRowMaxHeight: 75,
                dataRowMinHeight: 75,
                columns: [
              DataColumn(label: MyText.bodyMedium("Book Author", fontWeight: 600)),
              DataColumn(label: SizedBox(width: 200, child: MyText.bodyMedium("Book Name", fontWeight: 600))),
              DataColumn(label: SizedBox(width: 200, child: MyText.bodyMedium("Published Date", fontWeight: 600))),
              DataColumn(label: MyText.bodyMedium("Action", fontWeight: 600)),
            ], rows: [
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    MyContainer(
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 32,
                      width: 32,
                      child: Image.asset(Images.avatars[6], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    MyText.bodySmall("Christian"),
                  ],
                )),
                DataCell(
                    InkWell(onTap: () {}, child: MyText.bodySmall("Reports 1 clinical documentation"))),
                DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-12-12T12:30:00Z'), showMonthShort: true))),
                DataCell(Row(
                  children: [
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.primary,
                      child: Icon(LucideIcons.file, size: 16, color: contentTheme.onPrimary),
                    ),
                    MySpacing.width(20),
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.danger,
                      child: Icon(LucideIcons.trash, size: 16, color: contentTheme.onDanger),
                    ),
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    MyContainer(
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 32,
                      width: 32,
                      child: Image.asset(Images.avatars[6], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    MyText.bodySmall("Christian"),
                  ],
                )),

                DataCell(InkWell(onTap: () {}, child: MyText.bodySmall("Reports 2 random files documentation"))),
                DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-09-13T18:45:00Z'), showMonthShort: true))),
                DataCell(Row(
                  children: [
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.primary,
                      child: Icon(LucideIcons.file, size: 16, color: contentTheme.onPrimary),
                    ),
                    MySpacing.width(20),
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.danger,
                      child: Icon(LucideIcons.trash, size: 16, color: contentTheme.onDanger),
                    ),
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    MyContainer(
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 32,
                      width: 32,
                      child: Image.asset(Images.avatars[6], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    MyText.bodySmall("Christian"),
                  ],
                )),
                DataCell(InkWell(onTap: () {}, child: MyText.bodySmall("Reports 3 glucose level complete report"))),
                DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2023-05-14T07:15:00Z'), showMonthShort: true))),
                DataCell(Row(
                  children: [
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.primary,
                      child: Icon(LucideIcons.file, size: 16, color: contentTheme.onPrimary),
                    ),
                    MySpacing.width(20),
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.danger,
                      child: Icon(LucideIcons.trash, size: 16, color: contentTheme.onDanger),
                    ),
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Row(
                  children: [
                    MyContainer(
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 32,
                      width: 32,
                      child: Image.asset(Images.avatars[6], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    MyText.bodySmall("Christian"),
                  ],
                )),
                DataCell(InkWell(onTap: () {}, child: MyText.bodySmall("Reports 4 clinical documentation"))),
                DataCell(MyText.bodySmall(Utils.getDateStringFromDateTime(DateTime.parse('2024-10-11T00:00:00Z'), showMonthShort: true))),
                DataCell(Row(
                  children: [
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.primary,
                      child: Icon(LucideIcons.file, size: 16, color: contentTheme.onPrimary),
                    ),
                    MySpacing.width(20),
                    MyContainer(
                      onTap: () {},
                      paddingAll: 8,
                      color: contentTheme.danger,
                      child: Icon(LucideIcons.trash, size: 16, color: contentTheme.onDanger),
                    ),
                  ],
                )),
              ]),
            ]),
          )
        ],
      ),
    );
  }
}
