import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:medicare/admin_boobud/controller/notification/notification_controller.dart';
import 'package:medicare/helpers/theme/admin_theme.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_button.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_flex.dart';
import 'package:medicare/helpers/widgets/my_flex_item.dart';
import 'package:medicare/helpers/widgets/my_list_extension.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:get/get.dart';

import '../../../helpers/utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin, UIMixin {
  late NotificationController controller =  NotificationController(this);
  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1, strokeAlign: 0, color: colorScheme.onSurface.withAlpha(80)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'NotificationController',
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
                      "Alerts & Notifications",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        // MyBreadcrumbItem(name: 'Widget'),
                        MyBreadcrumbItem(name: 'Notifications', active: true),
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
                    MyFlexItem(
                      sizes: 'lg-12',
                      child: MyContainer(
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadiusAll: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: MySpacing.only(left: 23, top: 20, bottom: 8, right: 23),
                              child: MyText.titleMedium(!controller.showBanner ? "Custom Notifications" : "Message Alerts", fontWeight: 600),
                            ),
                            Divider(height: 24),
                            Padding(
                              padding: MySpacing.only(left: 23, top: 8, bottom: 23, right: 23),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Wrap(
                                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                  //   spacing: 16,
                                  //   runSpacing: 16,
                                  //   children: [
                                  //     buildMessageType(),
                                  //     // buildColorVariation(),
                                  //     // if (!controller.showBanner) buildFloatingType(),
                                  //   ],
                                  // ),
                                  MyText.bodyMedium("Title Text", fontWeight: 600),
                                  MySpacing.height(8),
                                  TextFormField(
                                    controller: controller.toastTitleController,
                                    decoration: InputDecoration(
                                        labelText: "Toast Text",
                                        filled: true,
                                        contentPadding: MySpacing.all(16),
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        isCollapsed: true,
                                        floatingLabelBehavior: FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodyMedium("Title Body", fontWeight: 600),
                                  MySpacing.height(8),
                                  TextFormField(
                                    controller: controller.toastBodyController,
                                    decoration: InputDecoration(
                                        labelText: "Toast Body",
                                        filled: true,
                                        contentPadding: MySpacing.all(16),
                                        border: outlineInputBorder,
                                        disabledBorder: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: outlineInputBorder,
                                        isCollapsed: true,
                                        floatingLabelBehavior: FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(12),
                                  if(controller.files.isEmpty)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium("Please Select Images", fontWeight: 600),
                                      MySpacing.height(8),
                                      uploadFile(),
                                      MySpacing.height(12),
                                    ],
                                  ),
                                  if (controller.files.isNotEmpty) ...[
                                    MySpacing.height(16),
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      children: controller.files
                                          .mapIndexed((index, file) => MyContainer.bordered(
                                        borderRadiusAll: 8,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        paddingAll: 8,
                                        child: SizedBox(
                                          width: 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                alignment: Alignment.topRight,
                                                children: [
                                                  MyContainer(
                                                    height: 100,
                                                    width: 100,
                                                    borderRadiusAll: 8,
                                                    color: contentTheme.onBackground.withAlpha(28),
                                                    paddingAll: 0,
                                                    child: Icon(LucideIcons.file, size: 20),
                                                  ),
                                                  MyContainer.transparent(
                                                      onTap: () => controller.removeFile(file),
                                                      paddingAll: 4,
                                                      child: Icon(LucideIcons.circle_x, color: contentTheme.danger)),
                                                ],
                                              ),
                                              MySpacing.height(8),
                                              MyText.bodyMedium(file.name, fontWeight: 600),
                                              MySpacing.height(4),
                                              MyText.bodySmall(
                                                Utils.getStorageStringFromByte(file.bytes?.length ?? 0),
                                                fontWeight: 600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    )
                                  ],


                                  // buildAction(),
                                  // MySpacing.height(12),
                                  // buildTimeOut(),
                                  MyButton(
                                    onPressed: controller.show,
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll: 8,
                                    child: MyText.bodySmall(
                                      'Send',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTimeOut() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Timeout", fontWeight: 600),
        SwitchListTile(
            value: controller.sticky,
            onChanged: controller.onChangeSticky,
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: getCompactDensity,
            contentPadding: MySpacing.zero,
            dense: true,
            title: MyText.bodyMedium("${"Infinite"} (∞)", fontWeight: 600)),
      ],
    );
  }

  Widget buildAction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: contentTheme.light),
          child: CheckboxListTile(
              value: controller.showBanner ? controller.showLeadingIcon : controller.showOkAction,
              onChanged: controller.onAction,
              activeColor: contentTheme.primary,
              controlAffinity: ListTileControlAffinity.leading,
              visualDensity: getCompactDensity,
              contentPadding: MySpacing.zero,
              dense: true,
              title: MyText.bodyMedium(
                controller.showBanner ? "Show Leading Icon" : "Show ok Action",
                fontWeight: 600,
              )),
        ),
      ],
    );
  }

  Widget buildFloatingType() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Floating Type", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<SnackBarBehavior>(
            value: controller.selectedBehavior,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              border: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            dropdownColor: contentTheme.background,
            onChanged: (SnackBarBehavior? newValue) {
              if (newValue != null) {
                controller.onChangeBehavior(newValue);
              }
            },
            items: SnackBarBehavior.values.map<DropdownMenuItem<SnackBarBehavior>>(
              (SnackBarBehavior behavior) {
                return DropdownMenuItem<SnackBarBehavior>(
                  value: behavior,
                  child: InkWell(
                    onTap: () => controller.onChangeBehavior(behavior),
                    child: MyText.labelMedium(behavior.name.capitalize!),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildColorVariation() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Color variation", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<ContentThemeColor>(
            dropdownColor: contentTheme.background,
            value: controller.selectedColor,
            onChanged: controller.onChangeColor,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              border: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            items: ContentThemeColor.values.map((color) {
              return DropdownMenuItem<ContentThemeColor>(
                value: color,
                child: InkWell(
                  onTap: () => controller.onChangeColor(color),
                  child: MyText.labelMedium(
                    color.name.capitalize!,
                    fontWeight: 600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildMessageType() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Message Type", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<bool>(
            value: controller.showBanner,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              border: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            dropdownColor: contentTheme.background,
            onChanged: (bool? newValue) {
              controller.setBannerType(newValue!);
            },
            items: [
              DropdownMenuItem<bool>(
                value: false,
                child: InkWell(
                  onTap: () => controller.setBannerType(false),
                  child: MyText.labelMedium("Custom Notifications"),
                ),
              ),
              DropdownMenuItem<bool>(
                value: true,
                child: InkWell(onTap: () => controller.setBannerType(true), child: MyText.labelMedium("Message Alerts")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget uploadFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyContainer.bordered(
          borderRadiusAll: 12,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onTap: controller.pickFiles,
          paddingAll: 23,
          child: Center(
            heightFactor: 1.5,
            child: Padding(
              padding: MySpacing.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(LucideIcons.folder_up),
                  MySpacing.height(12),
                  MyContainer(
                    width: 340,
                    alignment: Alignment.center,
                    paddingAll: 0,
                    child: MyText.titleMedium(
                      "Click to upload.",
                      fontWeight: 600,
                      muted: true,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MyContainer(
                    alignment: Alignment.center,
                    width: 610,
                    child: MyText.titleMedium(
                      "Selected images are not actually uploaded ",
                      muted: true,
                      fontWeight: 500,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


}
