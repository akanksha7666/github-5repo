import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/dataModel/SignUpModel.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/views/my_controller.dart';

class SignUpFormController extends MyController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>(); // ✅ Form Key

  String? selectedFiled;

  TextEditingController slugController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  signupModel signModel = signupModel();

  String? validateField(String? value, String fieldName,
      {int start = 0, int end = 0}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (start != 0 || end != 0) {
      if (isValidAmount(value)) {
        return "amount must be a $start between $end";
      }
    }
    return null;
  }

  bool isValidAmount(String value) {
    RegExp regex = RegExp(r'^\d{1,6}(\.\d{1,2})?$');
    return regex.hasMatch(value);
  }

  void cancelForm() {
    Get.offAndToNamed("/admin/subscription/list");
  }

  void addSubscription() {
    if (signUpFormKey.currentState!.validate()) {
      print("Form has validation !");
      Constant.shankBarCustomWeb(
          Get.context!, "Subscription Plan added Successfully");
      Get.offAndToNamed("/admin/subscription/list");
    } else {
      print("Form has validation errors!");
      Constant.shankBarCustomWeb(
          Get.context!, "Please Enter a valid Information");
    }
  }

  @override
  void onInit() {
    addOrEditStep("questio.toString().trim()","text.toString().trim()","text.toString().trim()",);
    // addOrEditStep("questio.toString().trim()","text.toString().trim()","text.toString().trim()",);
    // addOrEditStep("questio.toString().trim()","text.toString().trim()","text.toString().trim()",);
    // addOrEditStep("questio.toString().trim()","text.toString().trim()","text.toString().trim()",);
    update();
    super.onInit();
  }

  /// Step List Code

  void addOrEditStep(String question, String previous, String next, {int? editIndex}) {
    signModel.step ??= [];

    if (editIndex != null && editIndex >= 0 && editIndex < signModel.step!.length) {
      // 📝 Editing an existing step
      signModel.step![editIndex] = SignUpStep(
        title: question,
        fields: signModel.step![editIndex].fields, // Keep existing fields
        nextButtonText: next,
        previousButtonText: previous,
        step: signModel.step![editIndex].step, // Keep the same step number
      );
      print("✏️ Edited step at index: $editIndex");
    } else {
      // ➕ Adding a new step
      int newStepNumber = signModel.step!.length + 1;

      SignUpStep newStep = SignUpStep(
        title: question,
        fields: [],
        nextButtonText: next,
        previousButtonText: previous,
        step: newStepNumber,
      );

      signModel.step!.add(newStep);
      print("➕ Added new step");
    }

    Get.back();
    update(); // Notify UI about changes
  }

  void addOrEditField(String name, String label, String placeholder, bool required, String min, String max, int mainIndex, List<String> itemList ,{int? editIndex}) {
    try {
      // Ensure `selectedFiled` is set
      if (selectedFiled == null || selectedFiled!.isEmpty) {
        print("❌ Error: Field type is not selected!");
        return;
      }

      // Parse min & max safely
      int? minLength = int.tryParse(min.trim());
      int? maxLength = int.tryParse(max.trim());

      // Create a new field object
      Fields newField = Fields(
        type: selectedFiled!,
        name: name,
        label: label,
        placeholder: placeholder,
        required: required,
        itemList: itemList,
        validation: Validation(
          minLength: minLength,
          maxLength: maxLength,
        ),
      );

      // Ensure `fields` is initialized
      // selectedStep!.fields ??= [];

      if (editIndex != null && editIndex >= 0 && editIndex < signModel.step![mainIndex].fields!.length) {
        // Editing existing field
        signModel.step![mainIndex].fields![editIndex] = newField;
        print("✏️ Edited field at index: $editIndex");
      } else {
        // Adding a new field
        signModel.step![mainIndex].fields!.add(newField);
        print("➕ Added new field");
      }

      // Find the index of the selected step in `signModel`
      int stepIndex = signModel.step!.indexWhere((element) => element.step == signModel.step![mainIndex].step);

      if (stepIndex != -1) {
        // Update `signModel` with the modified step
        signModel.step![stepIndex] = signModel.step![mainIndex];
      } else {
        print("❌ Error: Selected step not found in signModel!");
      }

      Get.back();
      selectedFiled = null;
      update(); // Notify UI about changes
    } catch (e) {
      print("❌ Exception: $e");
    }
  }

  void deleteField(int mainIndex, int deleteIndex) {
    try {
      if (signModel.step == null || signModel.step!.isEmpty) {
        print("❌ Error: No steps available!");
        return;
      }

      // Ensure valid step and field index
      if (mainIndex < 0 || mainIndex >= signModel.step!.length) {
        print("❌ Error: Invalid step index!");
        return;
      }

      if (signModel.step![mainIndex].fields == null || signModel.step![mainIndex].fields!.isEmpty) {
        print("❌ Error: No fields available in this step!");
        return;
      }

      if (deleteIndex < 0 || deleteIndex >= signModel.step![mainIndex].fields!.length) {
        print("❌ Error: Invalid field index!");
        return;
      }

      // Remove the field
      signModel.step![mainIndex].fields!.removeAt(deleteIndex);
      print("🗑️ Deleted field at index: $deleteIndex");

      // Update the UI
      update();
    } catch (e) {
      print("❌ Exception: $e");
    }
  }


  void removeStep(int index) {
    if (signModel.step != null && index < signModel.step!.length) {
      signModel.step!.removeAt(index); // ✅ Remove from step list
      update(); // ✅ Refresh UI
    }
  }



  /// Step Alert Dialog
  void alertSignUpBoxData(int index) {
    Constant.showConfirmationDialog(Get.context!, "Delete Step?",
        "Are you sure you want to delete this Step?", () {
      // ✅ If confirmed, delete the step
      removeStep(index);
      Get.back();
        }
    );
  }
  /// Step Alert Dialog
  void alertFiledDelete(int mainIndex,int index) {
    Constant.showConfirmationDialog(Get.context!, "Delete Field?",
        "Are you sure you want to delete this Field?", () {
      // ✅ If confirmed, delete the step
      deleteField(mainIndex,index);
      Get.back();
        }
    );
  }
}

