import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/admin_boobud/widgets/custom_search_field.dart';
import 'package:medicare/app_constant.dart';
import 'package:medicare/admin_boobud/controller/subscription/subscription_add_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:medicare/views/ui/forms/mask_screen.dart';
import 'package:flutter/cupertino.dart';


class SubscriptionAddScreen extends StatefulWidget {
  const SubscriptionAddScreen({super.key});

  @override
  State<SubscriptionAddScreen> createState() => SubscriptionAddScreenState();
}

class SubscriptionAddScreenState extends State<SubscriptionAddScreen> with UIMixin {
  SubscriptionAddController controller = Get.put(SubscriptionAddController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'SubscriptionAddScreen',
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
                      "Add Subscription",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(
                            route: "/admin/subscription/list",
                            name: 'Subscription'),
                        // MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Add Subscription', active: true),
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
                  child: Form(
                    key: controller.formKey, // ✅ Wrap in Form
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.titleMedium("Subscription Information", fontWeight: 600),
                        MySpacing.height(20),
                        MyFlex(
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                                sizes: 'lg-6 md-6',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonTextFieldSearch( teController: controller.planNameController,title: "Plan Name", hintText: "Plan Name", prefixIcon: Icon(Icons.queue_play_next_sharp, size: 16),dropdownItems: ["Plan1","Plan2","Plan3","Plan4"],),
                                    MySpacing.height(20),
                                    commonTextField(teController: controller.termController,title: "Term", hintText: "Term", prefixIcon: Icon(Icons.date_range, size: 16), numbered: true, length: 10,),
                                    MySpacing.height(20),
                                    commonTextField(teController: controller.remarkController,title: "Remarks", hintText: "Remarks", prefixIcon: Icon(Icons.text_increase_sharp, size: 16), length: 80,isReq: false),

                                    // MyText.bodyMedium("Remarks", fontWeight: 600),
                                    // MySpacing.height(8),
                                    // Theme(
                                    //   data: ThemeData(unselectedWidgetColor: contentTheme.light),
                                    //   child: CheckboxListTile(
                                    //       value: controller.isRemarks,
                                    //       onChanged: controller.onChangeShowCloseIcon,
                                    //       controlAffinity: ListTileControlAffinity.leading,
                                    //       visualDensity: getCompactDensity,
                                    //       contentPadding: MySpacing.zero,
                                    //       activeColor: contentTheme.primary,
                                    //       dense: true,
                                    //       title: MyText.bodyMedium("Remarks", fontWeight: 600)),
                                    // ),
                                    MySpacing.height(20),
                                    commonTextFieldDate(
                                        title: "Start Subscription Date",
                                        hintText: "Select Date",
                                        numbered: true,
                                        prefixIcon: Icon(Icons.calendar_month_outlined, size: 16),
                                        onTap: controller.pickStartDate,
                                        teController: TextEditingController(text: controller.selectedStartDate != null ? dateFormatter.format(controller.selectedStartDate!) : "")),
                                  ],
                                )),
                            MyFlexItem(
                                sizes: 'lg-6 md-6',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MyText.labelMedium("Plan Duration", fontWeight: 600, muted: true),
                                        MySpacing.width(5),
                                        MyText.labelLarge("*", fontWeight: 600,color: Colors.red,),
                                      ],
                                    ),
                                    MySpacing.height(8),
                                    DropdownButtonFormField<PlanDuration>(
                                        value: PlanDuration.values.first, // ✅ Default selected value (0th index)
                                        dropdownColor: contentTheme.background,
                                        isDense: true,
                                        style: MyTextStyle.bodySmall(),
                                        items: PlanDuration.values
                                            .map((category) => DropdownMenuItem<PlanDuration>(
                                          value: category,
                                          child: MyText.bodySmall(category.name.capitalize!),
                                        ))
                                            .toList(),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(LucideIcons.chevron_down, size: 16),
                                        onChanged: (v){
                                          if (v != null) {
                                            String selectedValue = v.name; // ✅ Convert Enum to String
                                            controller.onChangePlan(selectedValue); // Pass the string value
                                          }
                                        },
                                        alignment: Alignment.center,
                                          validator: (value) => controller.validateField(value.toString(), "plan"),
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
                                    MySpacing.height(20),
                                    commonTextField(teController: controller.amountController,title: "Amount", hintText: "Amount", prefixIcon: Icon(Icons.currency_rupee, size: 16),numbered: true,start: 2,end: 8),
                                    MySpacing.height(20),
                                    buildTimeOut(),
                                    MySpacing.height(20),
                                    commonTextFieldDate(
                                        title: "End Subscription Date",
                                        hintText: "Select Date",
                                        numbered: true,
                                        isReq: false,
                                        prefixIcon: Icon(Icons.calendar_month_outlined, size: 16),
                                        onTap: controller.pickEndDate,
                                        teController: TextEditingController(text: controller.selectedEndDate != null ? dateFormatter.format(controller.selectedEndDate!) : "")),
                                  ],
                                )),
                          ],
                        ),
                        MySpacing.height(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyContainer(
                              onTap: (){
                                controller.addSubscription(context);
                              },
                              padding: MySpacing.xy(12, 8),
                              color: contentTheme.primary,
                              borderRadiusAll: 8,
                              child: MyText.labelMedium("Submit", color: contentTheme.onPrimary, fontWeight: 600),
                            ),
                            MySpacing.width(20),
                            MyContainer(
                              onTap: controller.cancelForm,
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
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget commonTextField({String? title, String? hintText, Widget? prefixIcon, void Function()? onTap, TextEditingController? teController, bool numbered = false, int? length,    String? Function(String?)? validator,
    int start = 0,int end = 0,bool isReq = true
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText.labelMedium(title ?? "", fontWeight: 600, muted: true),
            MySpacing.width(5),
            if(isReq)
            MyText.labelLarge("*", fontWeight: 600,color: Colors.red,),
          ],
        ),
        MySpacing.height(8),
        TextFormField(
          onTap: onTap ?? () {},
          controller: teController,
          keyboardType: numbered ? TextInputType.phone : TextInputType.text,
          maxLength: length,
          validator: isReq ? (value) => controller.validateField(value, title.toString(),start: start,end: end) : null,
          inputFormatters: numbered ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : null,
          style: MyTextStyle.bodySmall(),

          decoration: InputDecoration(
            errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
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
  Widget commonTextFieldDate({String? title, String? hintText, Widget? prefixIcon, void Function()? onTap, TextEditingController? teController, bool numbered = false, int? length,bool isReq = true}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText.labelMedium(title ?? "", fontWeight: 600, muted: true),
            MySpacing.width(5),
            if(isReq)
              MyText.labelLarge("*", fontWeight: 600,color: Colors.red,),
          ],
        ),
        MySpacing.height(8),
        TextFormField(
          onTap: onTap ?? () {},
          controller: teController,
          keyboardType: numbered ? TextInputType.phone : null,
          maxLength: length,
          validator: isReq ? (value) => controller.validateField(value, title.toString()) : null,
          inputFormatters: numbered ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),                                    DateTextFormatter(),
            DateTextFormatter(),
          ] : null,
          style: MyTextStyle.bodySmall(),
          decoration: InputDecoration(
            errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
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

  Widget commonTextFieldSearch({
    String? title,
    String? hintText,
    Widget? prefixIcon,
    void Function()? onTap,
    TextEditingController? teController,
    bool numbered = false,
    int? length,
    List<String>? dropdownItems,
  }) {

    teController ??=
        TextEditingController(); // Ensure a controller is always present
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              MyText.labelMedium(title, fontWeight: 600, muted: true),
              MySpacing.width(5),
              MyText.labelLarge("*", fontWeight: 600,color: Colors.red,),
            ],
          ),
        if (title != null)
          MySpacing.height(8),
        CustomSearchField(
          suggestions: dropdownItems ?? [],
          controller: teController,
          hintText: hintText,
          prefixIcon: prefixIcon,
          onTap: onTap,
          numbered: numbered,
          maxLength: length,
          validation: (value) => controller.validateField(value, title.toString()),
          textStyle: MyTextStyle.bodySmall(),
          onItemSelected: (value) {
            teController!.text =
                value; // Update the text field when an item is selected
          },
        ),
      ],
    );
  }


  Widget buildTimeOut() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Subscription", fontWeight: 600),
        Row(
          children: [
            Switch.adaptive(
              applyCupertinoTheme: true,
              value: controller.sticky,
              onChanged: controller.onChangeSticky,
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 10
                ),
                child: MyText.bodyMedium(controller.sticky ? "Is Active" : "Is Not Active", fontWeight: 600)),
          ],
        ),
        // SwitchListTile(
        //     value: controller.sticky,
        //     onChanged: controller.onChangeSticky,
        //     controlAffinity: ListTileControlAffinity.leading,
        //     visualDensity: getCompactDensity,
        //     contentPadding: MySpacing.zero,
        //     dense: true,
        //     title: MyText.bodyMedium(controller.sticky ? "Is Active" : "Is Not Active", fontWeight: 600),
        // ),
      ],
    );
  }
}
