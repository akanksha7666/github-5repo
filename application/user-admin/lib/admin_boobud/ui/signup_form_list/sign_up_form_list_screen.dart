import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/controller/signup_form_list/sign_up_form_list_controller.dart';
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

class SignUpFormListScreen extends StatefulWidget {
  const SignUpFormListScreen({super.key});

  @override
  State<SignUpFormListScreen> createState() => _SignUpFormListScreenState();
}

class _SignUpFormListScreenState extends State<SignUpFormListScreen> with UIMixin {
  SignUpFormListController controller = Get.put(SignUpFormListController());
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'SignUpFormListController',
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
                      "Sign Up Form List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        // MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Sign Up Form List ', active: true),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText.bodyMedium("Sign Up Form List", fontWeight: 600, muted: true),
                          Spacer(),
                          Expanded(child: commonTextField(prefixIcon: Icon(Icons.search))),
                          MyContainer(width: 20,),
                          MyButton(
                            onPressed: controller.addUser,
                            elevation: 0,
                            borderRadiusAll: 8,
                            padding: MySpacing.xy(18, 18),
                            backgroundColor: colorScheme.primary,
                            child: Row(
                              children: [
                                Icon(Icons.add,size: 16,),
                                MyText.labelMedium(
                                  "Add Signup Form",
                                  fontWeight: 600,
                                  color: colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            if (controller.signupModelList.isNotEmpty)
                              Row(
                                children: [
                                  _widgetTableHeadBox(-1, 180, "ID", isFirst: true),
                                  _widgetTableHeadBox(-1, 180, "Name"),
                                  _widgetTableHeadBox(-1, 180, "Slug"),
                                  _widgetTableHeadBox(-1, 180, "Step length"),
                                  _widgetTableHeadBox(-1, 180, "Default"),
                                  _widgetTableHeadBox(-1, 180, "Action", isLast: true),
                                ],
                              ),
                            // Paginated Table Body
                            for (int index = controller.startIndex;
                            index < controller.endIndex;
                            index++)
                              Row(
                                children: [
                                  _widgetTableBody(index, 180, (index + 1).toString(), isFirst: true),
                                  _widgetTableBody(index, 180, controller.signupModelList[index].name.toString()),
                                  _widgetTableBody(index, 180, controller.signupModelList[index].slug.toString()),
                                  _widgetTableBody(index, 180, controller.signupModelList[index].step!.length.toString()),
                                  _widgetTableSwitch(index, 180),
                                  _widgetAction(index, 180,
                                          () => controller.goEditScreen(),
                                          () => controller.goDeleteScreen(),
                                      isLast: true),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if(controller.signupModelList.isNotEmpty)
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
                                      "Showing : 1-10 of 500 Sign Up Form List",
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

  Widget _widgetTableSwitch(int index, double width,{bool isFirst = false,bool isLast = false}) {
    if (index < 0 || index >= controller.signupModelList.length) {
      return SizedBox();
    }
    return MyContainer(
      bordered: true,
      width: width,
      padding: MySpacing.xy(0, 6.5),
      alignment: Alignment.center,
      // color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0),bottomRight: Radius.circular(isLast ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0)),
      child: Switch.adaptive(
        applyCupertinoTheme: true,
        // value: controller.signupModelList[index].isDefault ?? false,
        value: false,
        onChanged: (bool value) {
          controller.toggleDefault(index, value);
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
      child: MyText.labelLarge(title, color: contentTheme.primary),
    );
  }

  _widgetAction(int index,double width,Function edit,Function delete,{bool isFirst = false,bool isLast = false}){
    return MyContainer(
      bordered: true,
      padding: MySpacing.xy(12.1, 12.5),
      // color: contentTheme.primary.withAlpha(40),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isFirst ? index == (controller.selectPageLength - 1) ? 12 : 0.0 : 0.0), bottomRight: Radius.circular(isLast ? index == (controller.selectPageLength-1) ?  12  : 0.0: 0.0)),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
