import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/signup/controller/signup_controller.dart';
import 'package:hezr/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/email_validation.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';
import 'package:hezr/global/widgets/common_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends GetView<SignUpCtrl> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBGColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
      ),
      backgroundColor: AppColors.whiteBGColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text("Create account",
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 25,
                    color: AppColors.darkBlackBGColor,
                  )),
              const SizedBox(height: 10),
              Text(
                  "Set up your username and password. You can always change it later.",
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    // fontFamily: ksecondaryFontFamily,
                    color: const Color(0xff707281),
                  )),
              40.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Username",
                controller: controller.userName,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else if (!isEmailValidator(value)) {
                    return "";
                  }
                  return null;
                },
              ),
              15.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Email",
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else if (!isEmailValidator(value)) {
                    return "";
                  }
                  return null;
                },
              ),
              15.verticalSpace,
              _buildPhoneContainer(),
              15.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: true,
                hinttext: "Password",
                controller: controller.password,
                keyboardType: TextInputType.emailAddress,
                showicon: true,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else if (!isEmailValidator(value)) {
                    return "";
                  }
                  return null;
                },
              ),
              15.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: true,
                hinttext: "Confirm Password",
                controller: controller.password,
                keyboardType: TextInputType.emailAddress,
                showicon: true,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else if (!isEmailValidator(value)) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15 * SizeConfig.heightMultiplier,
              ),
              CommonButton(
                  ontap: () {
                    Get.toNamed(Routes.otpScreen);
                  },
                  name: "Next"),
              10.verticalSpace,
              HaveAccount(
                title: "Already have an account? ",
                subtitle: "Log in",
                titleStyle: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff11142D),
                ),
                subtitleStyle: AppTextStyles.bold
                    .copyWith(fontSize: 16, color: AppColors.primaryColor),
                ontap: () {
                  Get.back();
                },
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  _buildPhoneContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xffF7F7F8),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.borderColor,
          )),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {},
        onInputValidated: (bool value) {},
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: AppColors.blackBGColor),
        // scrollPadding: EdgeInsets.zero,
        textFieldController: controller.phone,
        formatInput: false,
        maxLength: 9,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        cursorColor: Colors.black,
        inputDecoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 0, left: 0),
          border: InputBorder.none,
          isCollapsed: true,
          isDense: false,
          hintText: 'Phone Number',
          hintStyle: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xffA0A1AB),
          ),
        ),
        onSaved: (PhoneNumber number) {},
      ),
    );
  }
}
