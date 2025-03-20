import 'package:medicare/admin_boobud/controller/users/user_edit_controller.dart';
import 'package:medicare/app_constant.dart';
import 'package:medicare/admin_boobud/controller/users/user_add_controller.dart';
import 'package:medicare/helpers/theme/app_themes.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb.dart';
import 'package:medicare/helpers/widgets/my_breadcrumb_item.dart';
import 'package:medicare/helpers/widgets/my_container.dart';
import 'package:medicare/helpers/widgets/my_flex.dart';
import 'package:medicare/helpers/widgets/my_flex_item.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:medicare/helpers/widgets/my_text_style.dart';
import 'package:medicare/helpers/widgets/responsive.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({super.key});

  @override
  State<UserAddScreen> createState() => UserAddScreenState();
}

class UserAddScreenState extends State<UserAddScreen> with UIMixin {
  UserAddController controller = Get.put(UserAddController());
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'admin_patient_add_controller',
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
                      "User Add",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        // MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'User Add', active: true),
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
                      MyText.titleMedium("Basic Information", fontWeight: 600),
                      MySpacing.height(20),
                      MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                            sizes: 'lg-6 md-6',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextField(title: "User Name", hintText: "User Name", prefixIcon: Icon(LucideIcons.user_round, size: 16), ),
                                MySpacing.height(20),
                                commonTextField(title: "User Email", hintText: "User Email", prefixIcon: Icon(Icons.mail_outline_rounded, size: 16),),
                                MySpacing.height(20),
                                MyText.labelMedium("Verification Status", fontWeight: 600, muted: true),
                                MySpacing.height(8),
                                DropdownButtonFormField<VerificationStatus>(
                                  value: VerificationStatus.values.first, // ✅ Default selected value (0th index)
                                  dropdownColor: contentTheme.background,
                                  isDense: true,
                                  style: MyTextStyle.bodySmall(),
                                  items: VerificationStatus.values
                                      .map((category) => DropdownMenuItem<VerificationStatus>(
                                    value: category,
                                    child: MyText.bodySmall(category.name.capitalize!),
                                  ))
                                      .toList(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(LucideIcons.chevron_down, size: 16),
                                  onChanged: (v){

                                  },
                                  alignment: Alignment.center,
                                  // validator: (value) => controller.validateField(value.toString(), "plan"),
                                  decoration: InputDecoration(
                                      errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                      hintText: "Verification Status",
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                      contentPadding: MySpacing.all(12),
                                      isCollapsed: true,
                                      isDense: true,
                                      prefixIcon: Icon(Icons.pending_actions, size: 16),
                                      floatingLabelBehavior: FloatingLabelBehavior.never),
                                  // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                                ),
                              ],
                            ),
                          ),
                          MyFlexItem(
                            sizes: 'lg-6 md-6',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextField(
                                    title: "Mobile Number",
                                    hintText: "Mobile Number",
                                    prefixIcon: Icon(LucideIcons.phone_call, size: 16),
                                    numbered: true,
                                    length: 10
                                ),
                                MySpacing.height(20),
                                MyText.labelMedium("Subscription Status", fontWeight: 600, muted: true),
                                MySpacing.height(8),
                                DropdownButtonFormField<SubscriptionStatus>(
                                  value: SubscriptionStatus.values.first, // ✅ Default selected value (0th index)
                                  dropdownColor: contentTheme.background,
                                  isDense: true,
                                  style: MyTextStyle.bodySmall(),
                                  items: SubscriptionStatus.values
                                      .map((category) => DropdownMenuItem<SubscriptionStatus>(
                                    value: category,
                                    child: MyText.bodySmall(category.name.capitalize!),
                                  ))
                                      .toList(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(LucideIcons.chevron_down, size: 16),
                                  onChanged: (v){

                                  },
                                  alignment: Alignment.center,
                                  // validator: (value) => controller.validateField(value.toString(), "plan"),
                                  decoration: InputDecoration(
                                      errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                      hintText: "Subscription Status",
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                      contentPadding: MySpacing.all(12),
                                      isCollapsed: true,
                                      isDense: true,
                                      prefixIcon: Icon(Icons.pending_actions, size: 16),
                                      floatingLabelBehavior: FloatingLabelBehavior.never),
                                  // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                                ),
                                MySpacing.height(20),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyContainer(
                            onTap: () {
                              controller.gotoSubmit();
                            },
                            padding: MySpacing.xy(12, 8),
                            color: contentTheme.primary,
                            borderRadiusAll: 8,
                            child: MyText.labelMedium("Submit", color: contentTheme.onPrimary, fontWeight: 600),
                          ),
                          MySpacing.width(20),
                          MyContainer(
                            onTap: () {
                              controller.gotoSubmit();
                            },
                            padding: MySpacing.xy(12, 8),
                            borderRadiusAll: 8,
                            color: contentTheme.secondary.withAlpha(32),
                            child: MyText.labelMedium("Cancel", color: contentTheme.secondary, fontWeight: 600),
                          ),
                        ],
                      )
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

  Widget commonTextField({String? title, String? hintText, Widget? prefixIcon, void Function()? onTap, TextEditingController? teController, bool numbered = false, int? length}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(title ?? "", fontWeight: 600, muted: true),
        MySpacing.height(8),
        TextFormField(
          onTap: onTap ?? () {},
          controller: teController,
          keyboardType: numbered ? TextInputType.phone : null,
          maxLength: length,
          inputFormatters: numbered ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : null,
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
        ),
      ],
    );
  }
}
