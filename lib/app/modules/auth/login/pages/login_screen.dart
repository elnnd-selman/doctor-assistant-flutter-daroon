import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/login/controller/login_controller.dart';
import 'package:hezr/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/app_constants.dart';
import 'package:hezr/global/constants/email_validation.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';
import 'package:hezr/global/widgets/common_button.dart';
import 'package:hezr/global/widgets/socail_container.dart';

class LoginScreen extends GetView<LoginCtrl> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.whiteBGColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    Assets.appLogo,
                    width: 35,
                  ),
                  const SizedBox(width: 6),
                  Text("Hezr",
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 25,
                        fontFamily: ksecondaryFontFamily,
                        color: AppColors.blackBGColor,
                      )),
                ],
              ),
              const SizedBox(height: 60),
              Text("Log in to make your memories.",
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    // fontFamily: ksecondaryFontFamily,
                    color: AppColors.blackBGColor,
                  )),
              const SizedBox(height: 30),
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Username, email or phone number",
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.forgetPassword);
                  },
                  child: Text("Forgot password?",
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 14,
                        // fontFamily: ksecondaryFontFamily,
                        color: AppColors.primaryColor,
                      )),
                ),
              ),
              20.verticalSpace,
              CommonButton(
                ontap: () {},
                name: "Log In",
              ),
              20.verticalSpace,
              HaveAccount(
                title: "Don’t have an account? ",
                subtitle: "Sign up",
                titleStyle: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff11142D),
                ),
                subtitleStyle: AppTextStyles.bold
                    .copyWith(fontSize: 16, color: AppColors.primaryColor),
                ontap: () {
                  Get.toNamed(Routes.singup);
                },
              ),
              35.verticalSpace,
              Row(
                children: [
                  _dividerContainer(size),
                  const SizedBox(width: 10),
                  Text(
                    "Or login with",
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
              35.verticalSpace,
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
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Container _dividerContainer(Size size) {
    return Container(
      height: 0.5,
      width: size.width / 3.4,
      color: const Color(0xffE7E8EA),
    );
  }
}
