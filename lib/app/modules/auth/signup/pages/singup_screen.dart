import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/signup/controller/signup_controller.dart';
import 'package:hezr/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/email_validation.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';
import 'package:hezr/global/widgets/common_button.dart';
import 'package:hezr/global/widgets/socail_container.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends GetView<SignUpCtrl> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              20.verticalSpace,
              CommonButton(
                  ontap: () {
                    Get.toNamed(Routes.emailPhoneNumber);
                  },
                  name: "Continue"),
              20.verticalSpace,
              Row(
                children: [
                  _dividerContainer(size),
                  const SizedBox(width: 10),
                  Text(
                    "Or continue with",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA0A1AB),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _dividerContainer(size),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocailContainer(
                    imageUrl: Assets.googleLogo,
                    height: 40,
                    ontap: () {},
                  ),
                  SocailContainer(
                    imageUrl: Assets.appleLogo,
                    height: 40,
                    ontap: () {},
                  ),
                  SocailContainer(
                    imageUrl: Assets.facebookLogo,
                    height: 40,
                    ontap: () {},
                  ),
                ],
              ),
              50.verticalSpace,
              HaveAccount(
                title: "Already have an account? ",
                subtitle: "Sign in",
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
            ],
          ),
        ),
      ),
    );
  }

  Container _dividerContainer(Size size) {
    return Container(
      height: 0.5,
      width: size.width / 3.6,
      color: const Color(0xffE7E8EA),
    );
  }

  _buildPhoneContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xff6C5DD3),
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
            color: AppColors.primaryColor),
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
