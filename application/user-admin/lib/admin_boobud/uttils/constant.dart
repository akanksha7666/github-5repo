import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/uttils/PreferencesHelper.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/helpers/theme/app_themes.dart';
import 'package:medicare/helpers/widgets/my_button.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';
import 'package:toastification/toastification.dart';

class Constant{

  static doneShankBar(BuildContext context,String msg){
    showToast(context: context,message: msg,type: ToastificationType.success,color: Colors.green);
  }
  static errorShankBar(BuildContext context,String msg){
    showToast(context: context,message: msg,type: ToastificationType.error,color: Colors.red);
  }

  static String getToken(){
    String userdata =  PreferencesHelper.getString(PreferencesHelper.token) ?? "";
    return userdata;
  }


/*  static showToast({
    required BuildContext context,
    required String message,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 2),
      title:MyText.bodyLarge(message),
      // you can also use RichText widget for title and description parameters
      // description: RichText(text: const TextSpan(text: 'This is a sample toast message. ')),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      showIcon: true, // show or hide the icon
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      // closeButton: ToastCloseButton(
      //   showType: CloseButtonShowType.onHover,
      //   buttonBuilder: (context, onClose) {
      //     return OutlinedButton.icon(
      //       onPressed: onClose,
      //       icon: const Icon(Icons.close, size: 20),
      //       label: const Text('Close'),
      //     );
      //   },
      // ),

      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => Debug.printLog('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) => Debug.printLog('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) => Debug.printLog('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => Debug.printLog('Toast ${toastItem.id} dismissed'),
      ),
    );
  }*/



  static showToast({
    required BuildContext context,
    required String message,
    required Color color,
    ToastificationType type = ToastificationType.success,
  }) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 2),
      title:MyText.bodyLarge(message,color: Colors.white,),
      // you can also use RichText widget for title and description parameters
      // description: RichText(text: const TextSpan(text: 'This is a sample toast message. ')),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      backgroundColor: color,
      showIcon: true, // show or hide the icon
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      progressBarTheme: ProgressIndicatorThemeData(
        color: color,
      ),
      icon: Icon(type == ToastificationType.success ? Icons.check_circle_outline_outlined    :Icons.error,color: Colors.white,),
      showProgressBar: true,
      // closeButton: ToastCloseButton(
      //   showType: CloseButtonShowType.onHover,
      //   buttonBuilder: (context, onClose) {
      //     return OutlinedButton.icon(
      //       onPressed: onClose,
      //       icon: const Icon(Icons.close, size: 20),
      //       label: const Text('Close'),
      //     );
      //   },
      // ),

      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => Debug.printLog('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) => Debug.printLog('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) => Debug.printLog('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => Debug.printLog('Toast ${toastItem.id} dismissed'),
      ),
    );
  }


  static shankBarCustomWeb(BuildContext context, String msg) {
    showToast(context: context,message: msg,type: ToastificationType.success,color: Colors.green);
    // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM, // Position: top, center, bottom
    //   textColor: Colors.white,
    //   timeInSecForIosWeb: 2,
    //   fontSize: 18.0,
    //   // fontAsset: GoogleFonts!.poppins,
    //   webBgColor:"linear-gradient(to right, #1470AF, #1470AF)",
    //   webPosition: "right",
    // );
  }

  static showConfirmationDialog(BuildContext context, String title, String message, VoidCallback onConfirm) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actionsPadding: MySpacing.only(bottom: 16, right: 23),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          title: MyText.labelLarge(title),
          content: MyText.bodySmall(
              message,
              fontWeight: 600),
          actions: [
            MyButton(
              onPressed: (){
                Get.back();
              },
              borderRadiusAll: 8,
              elevation: 0,
              padding: MySpacing.xy(20, 16),
              backgroundColor: colorScheme.secondaryContainer,
              child: MyText.labelMedium(
                "Cancel",
                fontWeight: 600,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            MyButton(
              onPressed: onConfirm,
              elevation: 0,
              borderRadiusAll: 8,
              padding: MySpacing.xy(20, 16),
              backgroundColor: colorScheme.primary,
              child: MyText.labelMedium(
                "DELETE",
                fontWeight: 600,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );
  }

  static showAddButtonConfirmationDialog(BuildContext context, String title, String message, VoidCallback onConfirm) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actionsPadding: MySpacing.only(bottom: 16, right: 23),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          title: MyText.labelLarge(title),
          content: MyText.bodySmall(
              message,
              fontWeight: 600),
          actions: [
            MyButton(
              onPressed: (){
                Get.back();
              },
              borderRadiusAll: 8,
              elevation: 0,
              padding: MySpacing.xy(20, 16),
              backgroundColor: colorScheme.secondaryContainer,
              child: MyText.labelMedium(
                "Cancel",
                fontWeight: 600,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            MyButton(
              onPressed: onConfirm,
              elevation: 0,
              borderRadiusAll: 8,
              padding: MySpacing.xy(20, 16),
              backgroundColor: colorScheme.primary,
              child: MyText.labelMedium(
                "Add Step",
                fontWeight: 600,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );
  }


  static const radioClip = "Radio Clip";
  static const checkBox = "Check Box";
  static const radio = "Radio";
  static const text = "Text";
  static const password = "Password";
  static const date = "Date";
  static const dropDown = "DropDown";

  static const success = "success";

  static List<String> typeForSignUpFiled = ["Radio Clip","Check Box","Radio","Text","Password","Date","DropDown"];

}