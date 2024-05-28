import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/common_button.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTextStyles.semiBold
          .copyWith(fontSize: 15, color: AppColors.darkBlackBGColor),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F8),
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: const Color(0xffF7F7F8),
      border: Border.all(
        color: AppColors.borderColor,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xffF7F7F8),
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text("Enter verification code",
                style: AppTextStyles.bold.copyWith(
                  fontSize: 25,
                  color: AppColors.darkBlackBGColor,
                )),
            const SizedBox(height: 10),
            Text(
              "Please enter verification code we sent to your email elnndselman@gmail.com.",
              textAlign: TextAlign.center,
              style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff707281),
              ),
            ),
            40.verticalSpace,
            Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (pin) {}),
            const Spacer(),
            CommonButton(
                ontap: () {
                  Get.offAllNamed(Routes.login);
                },
                name: "Verify"),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
