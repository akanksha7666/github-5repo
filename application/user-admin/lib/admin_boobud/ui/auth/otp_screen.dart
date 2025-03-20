import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/admin_boobud/controller/auth/otp_controller.dart';
import 'package:medicare/admin_boobud/ui/layout/auth_layout.dart';
import 'package:medicare/helpers/theme/app_themes.dart';
import 'package:medicare/helpers/utils/ui_mixins.dart';
import 'package:medicare/helpers/widgets/my_button.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with UIMixin {
  late OtpController controller;

  @override
  void initState() {
    controller = Get.put(OtpController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
            padding: MySpacing.all(24),
            child: Form(
                key: controller.basicValidator.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.headlineSmall(
                      "Otp ",
                      fontWeight: 600,
                    ),
                    MySpacing.height(20),
                    MyText.bodySmall("Enter the OTP sent to your email.",  muted: true),
                    MySpacing.height(20),
                    MyText.labelMedium("Otp", fontWeight: 600, muted: true),
                    MySpacing.height(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        4,
                            (index) => SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            controller: controller.otpControllers[index],
                            focusNode: controller.otpFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => controller.onOtpChange(index, value),
                          ),
                        ),
                      ),
                    ),
                    MySpacing.height(20),
                    Center(
                      child: MyButton.rounded(
                        onPressed: controller.verifyOtp,
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: contentTheme.primary,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            controller.loading
                                ? SizedBox(
                              height: 14,
                              width: 14,
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.onPrimary,
                                strokeWidth: 1.2,
                              ),
                            )
                                : Container(),
                            if (controller.loading) MySpacing.width(16),
                            MyText.bodySmall(
                              'Submit Otp',
                              color: contentTheme.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: MyButton.text(
                        onPressed: controller.gotoLogIn,
                        elevation: 0,
                        padding: MySpacing.x(16),
                        splashColor: contentTheme.secondary.withOpacity(0.1),
                        child: MyText.labelMedium(
                          'Back To Log In',
                          color: contentTheme.secondary,
                        ),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
