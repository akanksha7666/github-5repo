import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/controller/subscription/subscription_view_controller.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/admin_boobud/widgets/custom_search_field.dart';
import 'package:medicare/app_constant.dart';
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

import '../../controller/subscription/subscription_edit_controller.dart';

class SubscriptionViewScreen extends StatefulWidget {
  const SubscriptionViewScreen({super.key});

  @override
  State<SubscriptionViewScreen> createState() => _SubscriptionViewScreenState();
}

class _SubscriptionViewScreenState extends State<SubscriptionViewScreen>
    with UIMixin {
  late SubscriptionViewController controller;

  @override
  void initState() {
    controller = SubscriptionViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'subscription_view_controller',
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
                      "View Subscription",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(
                          route: "/admin/subscription/list",
                            name: 'Subscription',),
                          MyBreadcrumbItem(
                            name: 'View Subscription', active: true),
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
                      MyText.titleMedium("View Information", fontWeight: 600),
                      MySpacing.height(20),
                      MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonTextField(
                                      title: "Plan Name",
                                      hintText: "Plan Name",
                                      prefixIcon:
                                      Icon(Icons.queue_play_next_sharp, size: 16,),
                                      numbered: true,
                                      length: 10),
                                  MySpacing.height(20),
                                  commonTextField(
                                      title: "Term",
                                      hintText: "Term",
                                      prefixIcon: Icon(Icons.date_range,
                                          size: 16),
                                      numbered: true,
                                      length: 10),
                                  MySpacing.height(20),
                                  MyText.bodyMedium("Additional Details",
                                      fontWeight: 600),
                                  MySpacing.height(8),
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            contentTheme.light),
                                    child: CheckboxListTile(
                                        value: controller.showCloseIcon,
                                        onChanged: null,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        visualDensity: getCompactDensity,
                                        contentPadding: MySpacing.zero,
                                        activeColor: contentTheme.primary,
                                        dense: true,
                                        title: MyText.bodyMedium(
                                            "additional details",
                                            fontWeight: 600,color: contentTheme.primary)),
                                  ),
                                  MySpacing.height(8),
                                  commonTextField(
                                      title: "Start Subscription Date",
                                      hintText: "Select Date",
                                      prefixIcon:
                                          Icon(Icons.calendar_month_outlined, size: 16),
                                      onTap: controller.pickDate,
                                      teController: TextEditingController(
                                          text: controller.selectedDate != null
                                              ? dateFormatter.format(
                                                  controller.selectedDate!)
                                              : "")),
                                ],
                              )),
                          MyFlexItem(
                              sizes: 'lg-6 md-6',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium("Plan Duration",
                                      fontWeight: 600, muted: true),
                                  MySpacing.height(8),
                                  DropdownButtonFormField<PlanDuration>(
                                    dropdownColor: contentTheme.background,
                                    isDense: true,
                                    style: MyTextStyle.bodySmall(color: contentTheme.primary),
                                    items: PlanDuration.values
                                        .map((category) =>
                                        DropdownMenuItem<PlanDuration>(
                                          value: category,
                                          child: MyText.bodySmall(
                                              category.name.capitalize!),
                                        ))
                                        .toList(),
                                    icon: Icon(LucideIcons.chevron_down,
                                        size: 20),
                                    decoration: InputDecoration(
                                        hintText: "plan",
                                        hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true,color: contentTheme.primary),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),borderSide: BorderSide(color: contentTheme.primary)),
                                        contentPadding: MySpacing.all(12),
                                        isCollapsed: true,
                                        isDense: true,
                                        prefixIcon: Icon(
                                            LucideIcons.chevron_down,
                                            size: 16),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never),
                                    onChanged: null,
                                  ),
                                  MySpacing.height(20),
                                  commonTextField(
                                      title: "Amount",
                                      hintText: "Amount",
                                      prefixIcon:
                                          Icon(Icons.currency_rupee, size: 16)),
                                  MySpacing.height(20),
                                  buildTimeOut(controller),
                                  MySpacing.height(20),
                                  commonTextField(
                                      title: "End Subscription Date",
                                      hintText: "Select Date",
                                      prefixIcon:
                                          Icon(Icons.calendar_month_outlined, size: 16),
                                      onTap: controller.pickDate,
                                      teController: TextEditingController(
                                          text: controller.selectedDate != null
                                              ? dateFormatter.format(
                                                  controller.selectedDate!)
                                              : "")),
                                ],
                              )),
                        ],
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

  Widget commonTextField(
      {String? title,
      String? hintText,
      Widget? prefixIcon,
      void Function()? onTap,
      TextEditingController? teController,
      bool numbered = false,
      int? length}) {
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
          inputFormatters: numbered
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ]
              : null,
          style: MyTextStyle.bodySmall(color: contentTheme.primary),
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: contentTheme.primary)),
            hintText: hintText,
            counterText: "",
            hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true,color: contentTheme.primary),
            isCollapsed: true,
            isDense: true,
            prefixIcon: prefixIcon,
            prefixIconColor: contentTheme.primary,
            contentPadding: MySpacing.all(16),
          ),
        ),
      ],
    );
  }

  Widget buildTimeOut(SubscriptionViewController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Subscription", fontWeight: 600),
        Switch.adaptive(
          value: logic.light,
          onChanged: null,
          activeColor: contentTheme.primary,
        ),
      ],
    );
  }
}
