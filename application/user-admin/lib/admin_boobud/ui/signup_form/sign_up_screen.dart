import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/controller/signup_form/sign_up_form_controller.dart';
import 'package:medicare/admin_boobud/dataModel/SignUpModel.dart';
import 'package:medicare/admin_boobud/ui/layout/layout.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/helpers/theme/app_themes.dart';
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

import '../../../app_constant.dart';


class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> with UIMixin {
  SignUpFormController controller = Get.put(SignUpFormController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'SignUpFormController',
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
                      "SignUp Form",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'SignUp'),
                        MyBreadcrumbItem(name: 'SignUp Form', active: true),
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
                        children: [
                          MyText.titleMedium("SignUp Form User", fontWeight: 600),
                          Spacer(),
                          MyButton(
                              padding: MySpacing.all(16),
                              onPressed: (){
                                showAddStepDialog();
                              },
                              elevation: 0,
                              borderRadiusAll: 12,
                              backgroundColor: contentTheme.primary,
                              child: MyText.labelMedium("Add Step", fontWeight: 600, color: contentTheme.onPrimary)),

                          // MyContainer(
                          //   padding: MySpacing.xy(0, 0),
                          //   color: contentTheme.primary,
                          //   borderRadiusAll: 8,
                          //   child: IconButton(
                          //       onPressed: () => showAddStepDialog(),
                          //       icon: Icon(
                          //         Icons.add,
                          //         color: Colors.white,
                          //       )),
                          // ),
                        ],
                      ),
                      MyFlex(
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                                sizes: 'lg-6 md-6',
                                child: commonTextField(title: "Name",prefixIcon: Icon(Icons.format_align_center),teController: controller.nameController,hintText: "Enter a Form Name",)),
                            MyFlexItem(
                            sizes: 'lg-6 md-6',
                            child: commonTextField(title: "Slug",prefixIcon: Icon(Icons.title),teController: controller.slugController,hintText: "Enter a Form Slug",)),

                      ]),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: SizedBox(
                      //     height: 40,
                      //     child: ReorderableListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       shrinkWrap: true,
                      //       buildDefaultDragHandles: false, // 🚀 Hide default drag icon
                      //       physics: NeverScrollableScrollPhysics(),
                      //       itemCount: controller.signModel.step?.length ?? 0,
                      //       onReorder: (oldIndex, newIndex) {
                      //         if (newIndex > oldIndex) newIndex--; // Adjust index properly
                      //
                      //         // Remove and insert at new index
                      //         final step = controller.signModel.step!.removeAt(oldIndex);
                      //         controller.signModel.step!.insert(newIndex, step);
                      //
                      //         // Update step numbers dynamically after reorder
                      //         for (int i = 0; i < controller.signModel.step!.length; i++) {
                      //           controller.signModel.step![i].step = i + 1; // Ensure correct numbering
                      //         }
                      //
                      //         controller.update(); // Refresh UI
                      //       },
                      //       itemBuilder: (context, index) {
                      //         return ReorderableDragStartListener(
                      //           key: ValueKey(controller.signModel.step![index]),
                      //           index: index,
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(12),
                      //             child: InkWell(
                      //               onTap: () {
                      //                 showAddStepDialog(
                      //                   isEdit: true,
                      //                   question: controller.signModel.step![index].title.toString(),
                      //                   nextButton: controller.signModel.step![index].nextButtonText.toString(),
                      //                   preButton: controller.signModel.step![index].previousButtonText.toString(),
                      //                   upIndex: index,
                      //                 );
                      //               },
                      //               child: Container(
                      //                 margin: index == 0 ? MySpacing.only(right: 5) : MySpacing.horizontal(5),
                      //                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   border: Border.all(color: theme.dividerColor, width: 2),
                      //                 ),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     MyText.labelMedium(
                      //                       "Step ${controller.signModel.step![index].step}",
                      //                       fontWeight: 600,
                      //                       muted: true,
                      //                     ),
                      //                     MySpacing.width(8),
                      //                     GestureDetector(
                      //                       onTap: () => controller.alertSignUpBoxData(index),
                      //                       child: Icon(Icons.cancel, size: 16, color: Colors.red),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      MySpacing.height(20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     MyContainer(
                      //       onTap: controller.addSubscription,
                      //       padding: MySpacing.xy(12, 8),
                      //       color: contentTheme.primary,
                      //       borderRadiusAll: 8,
                      //       child: MyText.labelMedium("Submit",
                      //           color: contentTheme.onPrimary,
                      //           fontWeight: 600),
                      //     ),
                      //     MySpacing.width(20),
                      //     MyContainer(
                      //       onTap: controller.cancelForm,
                      //       padding: MySpacing.xy(12, 8),
                      //       borderRadiusAll: 8,
                      //       color: contentTheme.secondary.withAlpha(32),
                      //       child: MyText.labelMedium("Cancel",
                      //           color: contentTheme.secondary,
                      //           fontWeight: 600),
                      //     ),
                      //
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              MySpacing.height(10),
              ReorderableListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.signModel.step!.length,
                buildDefaultDragHandles: false, // 🚀 Hide default drag icon
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--; // Adjust index properly
                  // Remove and insert at new index
                  final step = controller.signModel.step!.removeAt(oldIndex);
                  controller.signModel.step!.insert(newIndex, step);
                  // Update step numbers dynamically after reorder
                  for (int i = 0; i < controller.signModel.step!.length; i++) {
                    controller.signModel.step![i].step = i + 1;  // Step numbers start from 1
                  }
                  controller.update(); // Update UI
                },
                itemBuilder: (context, index) {
                  final stepS = controller.signModel.step![index];
                  return ReorderableDragStartListener(
                    key: ValueKey(stepS), // Ensure uniqueness for reordering
                    index: index, // Required for proper reordering
                    child: _widgetMainStepDragAndDropListManage(stepS, index),
                  );
                },
              ),




              /*if(controller.signModel.step != null &&  controller.signModel.step!.isNotEmpty)
              for(int mainIndex = 0;mainIndex < controller.signModel.step!.length;mainIndex++)
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  paddingAll: 20,
                  borderRadiusAll: 12,
                  margin: MySpacing.vertical(10),
                  // width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.titleMedium("Step ${controller.signModel.step![mainIndex] != null ? controller.signModel.step![mainIndex].step : 0}", fontWeight: 600),
                          if(controller.signModel.step![mainIndex]!= null)
                            Spacer(),
                          if(controller.signModel.step![mainIndex]!= null)
                            MyButton(
                              padding: MySpacing.all(20),
                              onPressed: (){
                                showAddFiledDialog();
                              },
                              elevation: 0,
                              borderRadiusAll: 12,
                              backgroundColor: contentTheme.primary,
                              child: MyText.labelMedium("Add Field", fontWeight: 600, color: contentTheme.onPrimary)),
                        ],
                      ),
                      if(controller.signModel.step![mainIndex]== null)
                        Center(child: Column(
                          children: [
                            MySpacing.height(20),
                            MyText.titleMedium("Please select a Step", fontWeight: 600),
                            MySpacing.height(20),
                          ],
                        )),
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.signModel.step![mainIndex].fields!.length,
                        buildDefaultDragHandles: false, // 🚀 Hide default drag icon
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) newIndex--; // Adjust index properly
                          final field = controller.signModel.step![mainIndex].fields!.removeAt(oldIndex);
                          controller.signModel.step![mainIndex].fields!.insert(newIndex, field);
                          controller.update(); // Update UI
                        },
                        itemBuilder: (context, index) {
                          final field = controller.signModel.step![mainIndex].fields![index];

                          return ReorderableDragStartListener(
                            key: ValueKey(field), // Ensure uniqueness for reordering
                            index: index, // Required for proper reordering
                            child: Column(
                              children: [
                                yourOrder(field, index), // Your custom field UI
                                MySpacing.height(12), // Add spacing
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )*/
            ],
          );
        },
      ),
    );
  }


  _widgetMainStepDragAndDropListManage(SignUpStep stepList,int mainIndex){
    return Padding(
      padding: MySpacing.x(flexSpacing),
      child: MyContainer(
        paddingAll: 20,
        borderRadiusAll: 12,
        margin: MySpacing.vertical(10),
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyText.titleMedium("Step ${controller.signModel.step![mainIndex] != null ? controller.signModel.step![mainIndex].step : 0}", fontWeight: 600),
                if(controller.signModel.step![mainIndex]!= null)
                  Spacer(),
                  MyButton(
                      padding: MySpacing.all(16),
                      onPressed: (){
                        showAddStepDialog(
                          isEdit: true,
                          question: controller.signModel.step![mainIndex].title.toString(),
                          nextButton: controller.signModel.step![mainIndex].nextButtonText.toString(),
                          preButton: controller.signModel.step![mainIndex].previousButtonText.toString(),
                          upIndex: mainIndex,
                        );
                      },
                      elevation: 0,
                      borderRadiusAll: 12,
                      backgroundColor: contentTheme.primary,
                      child: MyText.labelMedium("Edit Step", fontWeight: 600, color: contentTheme.onPrimary)),
                MySpacing.width(10),
                if(controller.signModel.step![mainIndex]!= null)
                  MyButton(
                      padding: MySpacing.all(16),
                      onPressed: (){
                        showAddFiledDialog(mainIndex);
                      },
                      elevation: 0,
                      borderRadiusAll: 12,
                      backgroundColor: contentTheme.primary,
                      child: MyText.labelMedium("Add Field", fontWeight: 600, color: contentTheme.onPrimary)),
                MySpacing.width(10),
                MyButton(
                    padding: MySpacing.all(16),
                    onPressed: (){
                      controller.alertSignUpBoxData(mainIndex);
                    },
                    elevation: 0,
                    borderRadiusAll: 12,
                    backgroundColor: contentTheme.danger,
                    child: MyText.labelMedium("Delete Step", fontWeight: 600, color: contentTheme.onPrimary)),
                MySpacing.width(10),
              ],
            ),
            if(controller.signModel.step![mainIndex]== null)
              Center(child: Column(
                children: [
                  MySpacing.height(20),
                  MyText.titleMedium("Please select a Step", fontWeight: 600),
                  MySpacing.height(20),
                ],
              )),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.signModel.step![mainIndex].fields!.length,
              buildDefaultDragHandles: false, // 🚀 Hide default drag icon
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--; // Adjust index properly
                final field = controller.signModel.step![mainIndex].fields!.removeAt(oldIndex);
                controller.signModel.step![mainIndex].fields!.insert(newIndex, field);
                controller.update(); // Update UI
              },
              itemBuilder: (context, index) {
                final field = controller.signModel.step![mainIndex].fields![index];
                return ReorderableDragStartListener(
                  key: ValueKey(field), // Ensure uniqueness for reordering
                  index: index, // Required for proper reordering
                  child: Column(
                    children: [
                      yourOrder(field, index,mainIndex), // Your custom field UI
                      MySpacing.height(12), // Add spacing
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }



  /// Add Alert Dialog
  void showAddStepDialog({bool isEdit = false,String question = "",String preButton = "",String nextButton = "",int upIndex = -1,}) {
    TextEditingController questionController = TextEditingController(text: question);
    TextEditingController preButtonController = TextEditingController(text: preButton);
    TextEditingController nextButtonController = TextEditingController(text: nextButton);

    Get.dialog(
      AlertDialog(
        title:MyText.titleMedium( isEdit ? "Edit Step": "Add New Step", fontWeight: 600, muted: true,color: theme.colorScheme.primary),
        content: MyContainer(
          width: Get.width *0.3,
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: controller.signUpFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                commonTextField(title: "Question",prefixIcon: Icon(Icons.title),teController: questionController,hintText: "Enter a new Question",),
                if(controller.signModel.step != null && controller.signModel.step!.isNotEmpty)
                  MySpacing.height(12),
                if(controller.signModel.step != null && controller.signModel.step!.isNotEmpty)
                commonTextField(title: "Previous Button Text",prefixIcon: Icon(Icons.navigate_before),teController: preButtonController,hintText: "Enter a Previous Title"),
                MySpacing.height(12),
                commonTextField(title: "Next Button Text",prefixIcon: Icon(Icons.navigate_next),teController: nextButtonController,hintText: "Enter a Next Title"),
                MySpacing.height(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton.outlined(
                        padding: MySpacing.all(20),
                        onPressed: () {
                          Get.back();
                        },
                        borderRadiusAll: 12,
                        borderColor: theme.colorScheme.onSurface.withAlpha(80),
                        backgroundColor: contentTheme.secondary,
                        elevation: 0,
                        child: MyText.labelMedium("Cancel", fontWeight: 600)),
                    MySpacing.width(20),
                    MyButton(
                        padding: MySpacing.all(20),
                        onPressed: (){
                          if(isEdit){
                            controller.addOrEditStep(questionController.text.toString().trim(),preButtonController.text.toString().trim(),nextButtonController.text.toString().trim(),editIndex: upIndex);
                          }else{
                            controller.addOrEditStep(questionController.text.toString().trim(),preButtonController.text.toString().trim(),nextButtonController.text.toString().trim());
                          }
                        },
                        elevation: 0,
                        borderRadiusAll: 12,
                        backgroundColor: contentTheme.primary,
                        child: MyText.labelMedium(isEdit ? "Edit Step":"Add Step", fontWeight: 600, color: contentTheme.onPrimary)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void showAddFiledDialog(int mainIndex,{String type = "",bool isEdit = false,String name = "",String placeholder = "",String label = "",String min = "",String max = "",List<String>? itemsList,int? index,bool isReqed = false}) {
    /// Text Type In use
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController placeholderController = TextEditingController(text: placeholder);
    TextEditingController labelController = TextEditingController(text: label);
    TextEditingController minController = TextEditingController(text: min);
    TextEditingController maxController = TextEditingController(text: max);
    bool isReq = isReqed;

    if(type != ""){
      controller.selectedFiled = type;
    }

    ///DropDown List
    List<TextEditingController> listItems = [TextEditingController()];

    if(itemsList != null  &&  itemsList.isNotEmpty){
      listItems.clear();
      for(int i =0;i<itemsList.length;i++){
        listItems.add(TextEditingController(text: itemsList[i]));
      }
    }
    Get.dialog(
      AlertDialog(
        title:MyText.titleMedium("Add New Field", fontWeight: 600, muted: true,color: theme.colorScheme.primary),
        content: StatefulBuilder(
          builder: (context,setState) {
            return SingleChildScrollView(
              child: MyContainer(
                width: Get.width *0.3,
                borderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Form(
                  key: controller.signUpFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
              
                      /// Main Select a Type Wise Handle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Fields Type", fontWeight: 600, muted: true),
                          MySpacing.height(8),
                          DropdownButtonFormField<String>(
                            value: controller.selectedFiled, // ✅ Track selected value
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.selectedFiled = newValue;
                                controller.update();
                                setState((){});// ✅ Refresh UI
                              }
                            },
                            dropdownColor: contentTheme.background,
                            isDense: true,
                            style: MyTextStyle.bodySmall(),
                            items: (Constant.typeForSignUpFiled ?? [])
                                .map((values) =>
                                DropdownMenuItem<String>(
                                  value: values,
                                  child: MyText.bodySmall(
                                      values.toString() ?? 'Untitled Step'),
                                ))
                                .toList(),
                            padding: EdgeInsets.zero,
                            icon: Icon(LucideIcons.chevron_down,
                                size: 16),
                            // onChanged: (v) {},
                            alignment: Alignment.center,
                            decoration: InputDecoration(
                                errorStyle:
                                MyTextStyle.bodyErrorFiled(
                                    fontWeight: 400,
                                    muted: true,
                                    color: Colors.red,
                                    fontSize: 10),
                                hintText: "Select Filed Type",
                                hintStyle: MyTextStyle.bodySmall(
                                    xMuted: true),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(12)),
                                contentPadding: MySpacing.all(12),
                                isCollapsed: true,
                                isDense: true,
                                prefixIcon: Icon(
                                    Icons.electric_meter_sharp,
                                    size: 16),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never),
                            // onChanged: controller.basicValidator.onChanged<Object?>('plan')
                          ),
                        ],
                      ),
                      MySpacing.height(12),
                      (controller.selectedFiled ==  Constant.text) ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              commonTextField(title: "name",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a Name",),
                              MySpacing.height(12),
                              commonTextField(title: "placeholder",prefixIcon: Icon(Icons.title),teController: placeholderController,hintText: "Enter a Placeholder",),
                              MySpacing.height(12),
                              commonTextField(title: "labelController",prefixIcon: Icon(Icons.title),teController: labelController,hintText: "Enter a Label",),
                              MySpacing.height(8),
                              MyText.labelMedium("Required", fontWeight: 600, muted: true),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: buildIsActiveNotActive(isReq, (bool newValue) {
                                setState(() {
                                  isReq = newValue;
                                });
                                }),
                              ),
                              MySpacing.height(12),
                              MyText.labelLarge("Validation", fontWeight: 600, muted: true),
                              MySpacing.height(12),
                              Row(
                                children: [
                                  Expanded(child: commonTextField(title: "Min length",prefixIcon: Icon(Icons.title),teController: minController,hintText: "Enter a Min length",length: 2,numbered: true)),
                                  MySpacing.width(10),
                                  Expanded(child: commonTextField(title: "Max length",prefixIcon: Icon(Icons.title),teController: maxController,hintText: "Enter a Max length",length: 2,numbered: true)),
                                ],
                              )
                            ],
                          ): (controller.selectedFiled ==  Constant.radioClip) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Radio Clip List", fontWeight: 600, muted: true),
                          MySpacing.height(8),
                          for(int i = 0 ; i < listItems.length ;i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: listItems[i],
                                        validator:  (value) => controller.validateField(value, "Radio Clip List",start: 0,end: 0),
                                        style: MyTextStyle.bodySmall(),

                                        decoration: InputDecoration(
                                          errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          hintText: "Please Enter Radio Clip Item",
                                          counterText: "",
                                          hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                                          isCollapsed: true,
                                          isDense: true,
                                          prefixIcon: Icon(Icons.list),
                                          contentPadding: MySpacing.all(16),
                                        ),
                                      ),
                                    ),
                                    if((listItems.length-1) == i)
                                      MySpacing.width(10),
                                    if((listItems.length-1) == i)
                                      MyContainer(
                                        padding: MySpacing.xy(0, 0),
                                        color: contentTheme.primary,
                                        borderRadiusAll: 8,
                                        child: IconButton(
                                            onPressed: (){
                                              listItems.add(TextEditingController());
                                              setState((){});
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )),
                                      ),

                                  ],
                                ),
                                MySpacing.height(8),
                              ],
                            ),
                          // commonTextField(title: "Radio Title",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a Radio Title",),
                          // MySpacing.height(12),
                          // commonTextField(title: "Icon File Name",prefixIcon: Icon(Icons.title),teController: labelController,hintText: "Enter a Icon file Name",),
                          MySpacing.height(8),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                        ],
                      ) :
                      (controller.selectedFiled ==  Constant.checkBox) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Check Box List", fontWeight: 600, muted: true),
                          MySpacing.height(8),
                          for(int i = 0 ; i < listItems.length ;i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: listItems[i],
                                        validator:  (value) => controller.validateField(value, "Check Box List",start: 0,end: 0),
                                        style: MyTextStyle.bodySmall(),

                                        decoration: InputDecoration(
                                          errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          hintText: "Please Enter Check Box Item",
                                          counterText: "",
                                          hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                                          isCollapsed: true,
                                          isDense: true,
                                          prefixIcon: Icon(Icons.list),
                                          contentPadding: MySpacing.all(16),
                                        ),
                                      ),
                                    ),
                                    if((listItems.length-1) == i)
                                      MySpacing.width(10),
                                    if((listItems.length-1) == i)
                                      MyContainer(
                                        padding: MySpacing.xy(0, 0),
                                        color: contentTheme.primary,
                                        borderRadiusAll: 8,
                                        child: IconButton(
                                            onPressed: (){
                                              listItems.add(TextEditingController());
                                              setState((){});
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )),
                                      ),

                                  ],
                                ),
                                MySpacing.height(8),
                              ],
                            ),
                          // commonTextField(title: "CheckBox Title",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a CheckBox Title",),
                          MySpacing.height(8),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                        ],
                      ) :
                      (controller.selectedFiled ==  Constant.radio) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Radio List", fontWeight: 600, muted: true),
                          MySpacing.height(8),
                          for(int i = 0 ; i < listItems.length ;i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: listItems[i],
                                        validator:  (value) => controller.validateField(value, "Radio List",start: 0,end: 0),
                                        style: MyTextStyle.bodySmall(),

                                        decoration: InputDecoration(
                                          errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          hintText: "Please Enter Radio Item",
                                          counterText: "",
                                          hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                                          isCollapsed: true,
                                          isDense: true,
                                          prefixIcon: Icon(Icons.list),
                                          contentPadding: MySpacing.all(16),
                                        ),
                                      ),
                                    ),
                                    if((listItems.length-1) == i)
                                      MySpacing.width(10),
                                    if((listItems.length-1) == i)
                                      MyContainer(
                                        padding: MySpacing.xy(0, 0),
                                        color: contentTheme.primary,
                                        borderRadiusAll: 8,
                                        child: IconButton(
                                            onPressed: (){
                                              listItems.add(TextEditingController());
                                              setState((){});
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )),
                                      ),

                                  ],
                                ),
                                MySpacing.height(8),
                              ],
                            ),
                          // commonTextField(title: "Radio Title",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a Radio Title",),
                          MySpacing.height(8),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                        ],
                      ) :
                      (controller.selectedFiled ==  Constant.password) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonTextField(title: "Password",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a Password",),
                          MySpacing.height(12),
                          commonTextField(title: "placeholder",prefixIcon: Icon(Icons.title),teController: placeholderController,hintText: "Enter a Placeholder",),
                          MySpacing.height(12),
                          commonTextField(title: "label",prefixIcon: Icon(Icons.title),teController: labelController,hintText: "Enter a Label",),
                          MySpacing.height(8),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                          MyText.labelLarge("Validation", fontWeight: 600, muted: true),
                          MySpacing.height(12),
                          Row(
                            children: [
                              Expanded(child: commonTextField(title: "Min length",prefixIcon: Icon(Icons.title),teController: minController,hintText: "Enter a Min length",length: 2,numbered: true)),
                              MySpacing.width(10),
                              Expanded(child: commonTextField(title: "Max length",prefixIcon: Icon(Icons.title),teController: maxController,hintText: "Enter a Max length",length: 2,numbered: true)),
                            ],
                          )
                        ],
                      ) :
                      (controller.selectedFiled ==  Constant.date) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonTextField(title: "Date Title",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a Date Title",),
                          MySpacing.height(8),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                        ],
                      ) :
                      (controller.selectedFiled ==  Constant.dropDown) ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonTextField(title: "DropDown Title",prefixIcon: Icon(Icons.title),teController: nameController,hintText: "Enter a DropDown Title",),
                          MySpacing.height(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium("Drop Down List", fontWeight: 600, muted: true),
                                MySpacing.height(8),
                                for(int i = 0 ; i < listItems.length ;i++)
                                  Column(
                                    children: [
                                      Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: listItems[i],
                                            validator:  (value) => controller.validateField(value, "Drop Down List",start: 0,end: 0),
                                            style: MyTextStyle.bodySmall(),

                                            decoration: InputDecoration(
                                              errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                              hintText: "Please Enter drop down Item",
                                              counterText: "",
                                              hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                                              isCollapsed: true,
                                              isDense: true,
                                              prefixIcon: Icon(Icons.list),
                                              contentPadding: MySpacing.all(16),
                                            ),
                                          ),
                                        ),
                                        if((listItems.length-1) == i)
                                          MySpacing.width(10),
                                        if((listItems.length-1) == i)
                                        MyContainer(
                                          padding: MySpacing.xy(0, 0),
                                          color: contentTheme.primary,
                                          borderRadiusAll: 8,
                                          child: IconButton(
                                              onPressed: (){
                                                listItems.add(TextEditingController());
                                                setState((){});
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              )),
                                        ),

                                      ],
                                                                      ),
                                      MySpacing.height(8),
                                    ],
                                  ),
                              ],
                            ),
                          MyText.labelMedium("Required", fontWeight: 600, muted: true),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: buildIsActiveNotActive(isReq, (bool newValue) {
                              setState(() {
                                isReq = newValue;
                              });
                            }),
                          ),
                          MySpacing.height(12),
                        ],
                      ) : MyContainer(),
                      MySpacing.height(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyButton.outlined(
                              padding: MySpacing.all(20),
              
                              onPressed: () {
                                Get.back();
                              },
                              borderRadiusAll: 12,
                              borderColor: theme.colorScheme.onSurface.withAlpha(80),
                              backgroundColor: contentTheme.secondary,
                              elevation: 0,
                              child: MyText.labelMedium("Cancel", fontWeight: 600)),
                          MySpacing.width(20),
                          MyButton(
                              padding: MySpacing.all(20),
                              onPressed: (){
                                if(isEdit){
                                  controller.addOrEditField(
                                      nameController.text,
                                      labelController.text,
                                      placeholderController.text,
                                      isReq,
                                      minController.text,
                                      maxController.text , mainIndex,listItems.map((controller) => controller.text).toList(),editIndex: index);
                                }else{
                                  controller.addOrEditField(
                                      nameController.text,
                                      labelController.text,
                                      placeholderController.text,
                                      isReq,
                                      minController.text,
                                      maxController.text,mainIndex,listItems.map((controller) => controller.text).toList());
                                }
                              },
                              elevation: 0,
                              borderRadiusAll: 12,
                              backgroundColor: contentTheme.primary,
                              child: MyText.labelMedium("Add Filed", fontWeight: 600, color: contentTheme.onPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }


  Widget commonTextField({bool isEdit = true, bool isRes =false, String? title, String? hintText, Widget? prefixIcon, void Function()? onTap, TextEditingController? teController, bool numbered = false, int? length,    String? Function(String?)? validator,
    int start = 0,int end = 0,bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText.labelMedium(title ?? "", fontWeight: 600, muted: true),
            if(isRes)
              MyText.titleSmall(" * ",fontWeight: 700,color: contentTheme.danger,),
          ],
        ),
        MySpacing.height(8),
        TextFormField(
          onTap: onTap ?? () {},
          controller: teController,
          enabled: isEdit,
          obscureText: isPassword ? true : false, // Handle password visibility
          keyboardType: numbered ? TextInputType.phone : null,
          maxLength: length,
          validator:  (value) => controller.validateField(value, title.toString(),start: start,end: end),
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
            suffixIcon: isPassword
                ? Icon(
                Icons.visibility_off)
                : null,
          ),
        ),
      ],
    );
  }

  Widget buildIsActiveNotActive(bool values, Function(bool) onChange) {
    return Switch.adaptive(
      applyCupertinoTheme: true,
      value: values,
      onChanged: (bool newValue) {  // Pass newValue to the callback
        onChange.call(newValue);
      },
    );
  }


  Widget yourOrder(Fields fields,int index,int mainIndex) {
    List<String> selectedGenresPageOne = []; // Stores multiple selected genres

    void toggleGenreSelection(String genre) {
      if (selectedGenresPageOne.contains(genre)) {
        selectedGenresPageOne.remove(genre); // Deselect if already selected
      } else {
        selectedGenresPageOne.add(genre); // Select if not already selected
      }
      controller.update();
    }


    return MyContainer(
      paddingAll: 0,
      borderRadiusAll: 12,
      bordered: true,
      margin: MySpacing.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /* Padding(
              padding: MySpacing.only(left: 24,right: 24,top: 10),
              child: MyText.titleMedium("User App-Web Preview",fontWeight: 700)),*/
          (fields.type == Constant.radioClip) ?
          Padding(
            padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Expanded(
                //   child: Container(
                //     alignment: Alignment.centerLeft,
                //     child: FilterChip(
                //       label: Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.min,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           MyText.labelMedium(fields.name.toString(), fontWeight: 600, color: contentTheme.black),
                //           MySpacing.width(7),
                //           SvgPicture.asset(
                //             "assets/images/dummy/travel.svg",
                //             height: 16,
                //             width: 16,
                //           ),
                //         ],
                //       ),
                //       backgroundColor: theme.secondaryHeaderColor,
                //       showCheckmark: false,
                //       // padding: ResponsiveUtil.mediaPadding(1, 0.8, 1, 0.8, context),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10), // Apply rounded corners
                //       ),
                //       selectedColor: theme.primaryColor.withOpacity(0.2), onSelected: (bool value) {
                //     },
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.titleSmall("Radio Clip",fontWeight: 700),
                          if(fields.required == true)
                          MyText.titleSmall(" * ",fontWeight: 700,color: contentTheme.danger,),
                        ],
                      ),
                      MySpacing.height(7),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: fields.itemList!.map((genre) {
                            return FilterChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyText.labelMedium(genre, fontWeight: 600, color: contentTheme.black),
                                  MySpacing.width(7),
                                  SvgPicture.asset(
                                    "assets/images/dummy/travel.svg",
                                    height: 16,
                                    width: 16,
                                  ),
                                ],
                              ),
                              backgroundColor: theme.secondaryHeaderColor,
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Apply rounded corners
                                side: BorderSide(
                                  color: selectedGenresPageOne.contains(genre)
                                      ? theme.secondaryHeaderColor
                                      : Colors.transparent,
                                ),
                              ),
                              selectedColor: theme.secondaryHeaderColor.withOpacity(0.2), // Slight highlight when selected
                              selected: selectedGenresPageOne.contains(genre),
                              onSelected: (bool selected) {
                                toggleGenreSelection(genre);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                MySpacing.width(10),
                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          ) : (fields.type == Constant.checkBox) ? Padding(
                        padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.titleSmall("Check Box",fontWeight: 700),
                          if(fields.required == true)
                            MyText.titleSmall(" * ",fontWeight: 700,color: contentTheme.danger,),
                        ],
                      ),
                      MySpacing.height(7),
                      for(int i = 0 ;i<fields.itemList!.length;i++)
                      GestureDetector(
                        onTap: () {
                          // logic.toggleDiscussionSelection(index);
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: i == 0 ? contentTheme.primary : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: i == 0 ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15, // Icon size
                                  ) : null,
                                ),
                                MySpacing.width(10),
                                MyText.titleMedium(fields.itemList![i].toString())
                              ],
                            ),
                            MySpacing.height(2)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     alignment: Alignment.centerLeft,
                //     child: GestureDetector(
                //       onTap: () {
                //         // logic.toggleDiscussionSelection(index);
                //       },
                //       child: Row(
                //         children: [
                //           Container(
                //             width: 20,
                //             height: 20,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.rectangle,
                //               color:  contentTheme.primary,
                //               border: Border.all(
                //                 color: Colors.black,
                //                 width: 1.2,
                //               ),
                //             ),
                //             child: Icon(
                //               Icons.check,
                //               color: Colors.white,
                //               size: 15, // Icon size
                //             ),
                //           ),
                //           MySpacing.width(10),
                //           MyText.titleMedium(fields.name.toString())
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                MySpacing.width(10),
                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  :

          (fields.type == Constant.radio) ? Padding(
           padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.titleSmall("Radio",fontWeight: 700),
                          if(fields.required == true)
                            MyText.titleSmall(" * ",fontWeight: 700,color: contentTheme.danger,),
                        ],
                      ),
                      MySpacing.height(7),
                      for(int i = 0 ;i<fields.itemList!.length;i++)
                        GestureDetector(
                          onTap: () {
                            // logic.toggleDiscussionSelection(index);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                      Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Padding(
                                      padding: MySpacing.all(1),
                                      // Adjust the inner padding here
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: i == 0 ? contentTheme.primary : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  MySpacing.width(10),
                                  MyText.titleMedium(fields.itemList![i].toString())
                                ],
                              ),
                              MySpacing.height(2)
                            ],
                          ),
                        )
                    ],
                  ),
                ),

/*
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        // logic.toggleDiscussionSelection(index);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: Padding(
                              padding: MySpacing.all(1),
                              // Adjust the inner padding here
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: contentTheme.primary, // Inner circle or content color
                                ),
                              ),
                            ),
                          ),

                          MySpacing.width(10),
                          MyText.titleMedium(fields.name.toString())
                        ],
                      ),
                    ),
                  ),
                ),*/
                MySpacing.width(10),

                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  :
          (fields.type == Constant.text) ? Padding(
                        padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: commonTextField(isEdit: false,isRes: fields.required ?? false,title: fields.name,prefixIcon: Icon(Icons.format_align_center),teController: TextEditingController(text: ""),hintText: fields.label,),
                  ),
                ),
                Spacer(),
                MySpacing.width(10),

                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  :
          (fields.type == Constant.password) ? Padding(
                        padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: commonTextField(isPassword: true,isRes: fields.required ?? false,isEdit: false,title: fields.name,prefixIcon: Icon(Icons.format_align_center),teController: TextEditingController(text: fields.name.toString()),hintText: fields.label,),
                  ),
                ),
                Spacer(),
                MySpacing.width(10),
                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  :
          (fields.type == Constant.date) ? Padding(
                        padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: commonTextField(isEdit: false,isRes: fields.required ?? false,title: fields.name,prefixIcon: Icon(Icons.calendar_month_outlined),teController: TextEditingController(text: dateFormatter.format(DateTime.now())),hintText: fields.label,),
                  ),
                ),
                Spacer(),
                MySpacing.width(10),

                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  :
          (fields.type == Constant.dropDown) ? Padding(
            padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText.labelMedium(fields.name.toString(), fontWeight: 600, muted: true),
                          if(fields.required == true)
                            MyText.titleSmall(" * ",fontWeight: 700,color: contentTheme.danger,),
                        ],
                      ),
                      MySpacing.height(8),
                      DropdownButtonFormField<String>(
                        value: fields.itemList!.first, // ✅ Default selected value (0th index)
                        dropdownColor: contentTheme.background,
                        isDense: true,
                        style: MyTextStyle.bodySmall(),
                        items: fields.itemList!.map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: MyText.bodySmall(category),
                        )).toList(),
                        padding: EdgeInsets.zero,
                        icon: Icon(LucideIcons.chevron_down, size: 16),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // Handle dropdown value change
                            Debug.printLog("Selected: $newValue");
                            // You can update a controller variable here if needed
                          }
                        },
                        alignment: Alignment.center,
                        validator: (value) => controller.validateField(value.toString(), "plan"),
                        decoration: InputDecoration(
                          errorStyle: MyTextStyle.bodyErrorFiled(
                              fontWeight: 400, muted: true, color: Colors.red, fontSize: 10
                          ),
                          hintText: "Select Type",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          contentPadding: MySpacing.all(12),
                          isCollapsed: true,
                          isDense: true,
                          prefixIcon: Icon(LucideIcons.calendar_days, size: 16),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),

                    ],
                  )
                ),
                Spacer(),
                MySpacing.width(10),
                addFiledButton(mainIndex,fields,index),
                MySpacing.width(10),
                deleteFiledButton(mainIndex,fields,index),
              ],
            ),
          )  : Container(),
          /*Padding(
                        padding: MySpacing.only(left: 20,right: 20,bottom: 20,top: 10),

            child: Row(
              children: [
                Expanded(child: MyText.titleMedium("Fields ${index+1} and Type is ${fields.type.toString()} ", fontWeight: 600)),
                MyButton(
                    padding: MySpacing.all(16),
                    onPressed: (){
                      showAddFiledDialog(mainIndex,type: fields.type ?? "", isEdit: true,label: fields.label ?? "",max: fields.validation!.minLength.toString()  ?? "",min: fields.validation!.minLength.toString() ?? "",name: fields.name ?? "",placeholder: fields.placeholder ?? "",index:
                      index,isReqed: fields.required ?? false,dropDownList: fields.dropDownList);
                    },
                    elevation: 0,
                    borderRadiusAll: 12,
                    backgroundColor: contentTheme.primary,
                    child: MyText.labelMedium("Edit Field", fontWeight: 600, color: contentTheme.onPrimary)),
              ],
            ),
          ),*/
          // Divider(height: 0),
         /* Padding(
              padding: MySpacing.only(left: 24,right: 24,top: 10),
              child: MyText.titleMedium("Admin Preview",fontWeight: 700)),
          Padding(
            padding: MySpacing.xy(24,20),
            child:MyFlex(
                contentPadding: false,
                children: [
                  if(fields.name != null && fields.name.toString() != "")
                    MyFlexItem(
                      sizes: 'lg-6 md-6',
                      child: commonTextField(isEdit: false,title: "Name",prefixIcon: Icon(Icons.format_align_center),teController: TextEditingController(text: fields.name),hintText: "Enter a Filed Name",)),
                  if(fields.placeholder != null && fields.placeholder.toString() != "")
                    MyFlexItem(
                      sizes: 'lg-6 md-6',
                      child: commonTextField(isEdit: false,title: "Placeholder",prefixIcon: Icon(Icons.title),teController: TextEditingController(text: fields.placeholder),hintText: "Enter a Placeholder",)),
                  if(fields.label != null && fields.label.toString() != "")
                    MyFlexItem(
                      sizes: 'lg-6 md-6',
                      child: commonTextField(isEdit: false,title: "Label",prefixIcon: Icon(Icons.title),teController: TextEditingController(text: fields.label),hintText: "Enter a Label",)),
                  if(fields.validation != null && fields.validation!.minLength.toString() != "null")
                    MyFlexItem(
                      sizes: 'lg-6 md-6',
                      child: commonTextField(isEdit: false,title: "Min Value",prefixIcon: Icon(Icons.title),teController: TextEditingController(text: fields.validation!.minLength.toString()),hintText: "Enter a Label",)),
                  if(fields.validation != null && fields.validation!.maxLength.toString() != "null")
                    MyFlexItem(
                      sizes: 'lg-6 md-6',
                      child: commonTextField(isEdit: false,title: "Max Value",prefixIcon: Icon(Icons.title),teController: TextEditingController(text: fields.validation!.maxLength.toString()),hintText: "Enter a Label",)),
                  if(fields.type == Constant.dropDown)
                    if(fields.dropDownList != null && fields.dropDownList!.isNotEmpty)
                      for(int d = 0;d< fields.dropDownList!.length;d++)
                        MyFlexItem(
                          sizes: 'lg-6 md-6',
                          child: commonTextField(isEdit: false,title: "Item ${d+1}",prefixIcon: Icon(Icons.title),teController: TextEditingController(text: fields.dropDownList![d].toString()),hintText: "Enter a Drop down Item",)),
                ]),
          ),
          Divider(height: 0),
          Padding(
            padding: MySpacing.xy(24,20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium("Required",fontWeight: 700),
                MyText.bodyMedium(fields.required == true ? "Yes":"No",fontWeight: 700),
              ],
            ),
          ),*/
        ],
      ),
    );
  }


  addFiledButton(int mainIndex,Fields fields,int index){
    return           MyContainer(
      onTap: () {
        showAddFiledDialog(mainIndex,type: fields.type ?? "", isEdit: true,label: fields.label ?? "",max: fields.validation!.minLength.toString()  ?? "",min: fields.validation!.minLength.toString() ?? "",name: fields.name ?? "",placeholder: fields.placeholder ?? "",index:
        index,isReqed: fields.required ?? false,itemsList: fields.itemList);
        },
      padding: MySpacing.xy(8, 8),
      color: contentTheme.primary.withAlpha(36),
      child: Icon(
        LucideIcons.pencil,
        size: 16,
        color: contentTheme.primary,
      ),
    );
    MyButton(
        padding: MySpacing.all(16),
        onPressed: (){
          showAddFiledDialog(mainIndex,type: fields.type ?? "", isEdit: true,label: fields.label ?? "",max: fields.validation!.minLength.toString()  ?? "",min: fields.validation!.minLength.toString() ?? "",name: fields.name ?? "",placeholder: fields.placeholder ?? "",index:
          index,isReqed: fields.required ?? false,itemsList: fields.itemList);
        },
        elevation: 0,
        borderRadiusAll: 12,
        backgroundColor: contentTheme.primary,
        child: MyText.labelMedium("Edit Field", fontWeight: 600, color: contentTheme.onPrimary));
  }

  deleteFiledButton(int mainIndex,Fields fields,int index){
    return MyContainer(
      onTap: () {
          controller.alertFiledDelete(mainIndex,index);
          // controller.deleteField(mainIndex,index);
      },
      padding: MySpacing.xy(8, 8),
      color: contentTheme.danger.withAlpha(36),
      child: Icon(
        LucideIcons.trash_2,
        size: 16,
        color: contentTheme.danger,
      ),
    );
    MyButton(
        padding: MySpacing.all(16),
        onPressed: (){
          controller.deleteField(mainIndex,index);
        },
        elevation: 0,
        borderRadiusAll: 12,
        backgroundColor: contentTheme.danger,
        child: MyText.labelMedium("Delete Field", fontWeight: 600, color: contentTheme.onPrimary));
  }



}



