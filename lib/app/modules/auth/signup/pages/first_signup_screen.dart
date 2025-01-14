import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/auth/signup/controller/signup_controller.dart';
import 'package:daroon_doctor/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';

class FirstSignupScreen extends GetView<SignUpCtrl> {
  const FirstSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
        ),
        backgroundColor: AppColors.whiteBGColor,
        body: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: form,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          Text("create account to use app features.",
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                // fontFamily: ksecondaryFontFamily,
                                color: const Color(0xffA0A1AB),
                              )),
                          40.verticalSpace,
                          CommonTextfeild(
                            scanIcons: false,
                            obscuretext: false,
                            hinttext: "First name",
                            controller: controller.firstName,
                            keyboardType: TextInputType.emailAddress,
                            showicon: false,
                            validations: (value) {
                              if (value!.isEmpty) {
                                return "Enter First name";
                              }
                              return null;
                            },
                          ),
                          15.verticalSpace,
                          CommonTextfeild(
                            scanIcons: false,
                            obscuretext: false,
                            hinttext: "Last name",
                            controller: controller.lastName,
                            keyboardType: TextInputType.emailAddress,
                            showicon: false,
                            validations: (value) {
                              if (value!.isEmpty) {
                                return "Enter Last name";
                              }
                              return null;
                            },
                          ),
                          15.verticalSpace,
                          DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffF7F7F8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            hint: Text(
                              'Select Your Gender',
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color(0xffA0A1AB),
                              ),
                            ),
                            items: controller.genderList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: AppColors.blackBGColor,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return '   Please select gender';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.selectedGender.value =
                                  value.toString();
                            },
                            onSaved: (value) {
                              controller.selectedGender.value =
                                  value.toString();
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.only(
                                  right: 4 * SizeConfig.widthMultiplier),
                            ),
                            iconStyleData: IconStyleData(
                              icon:
                                  SvgPicture.asset("assets/icons/downIcon.svg"),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 0,
                              decoration: BoxDecoration(
                                color: const Color(0xffF7F7F8),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                          const Spacer(),
                          // SizedBox(
                          //   height: 35 * SizeConfig.heightMultiplier,
                          // ),
                          CommonButton(
                              ontap: () {
                                if (form.currentState!.validate()) {
                                  // controller.userModel.value!.fullName !=
                                  //     "${controller.firstName.text} ${controller.lastName.text}";
                                  // controller.userModel.value!.gender !=
                                  //     controller.selectedGender.value;
                                  Get.toNamed(Routes.singup);
                                }
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
                            subtitleStyle: AppTextStyles.bold.copyWith(
                                fontSize: 16, color: AppColors.primaryColor),
                            ontap: () {
                              Get.back();
                            },
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )

        //  Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Form(
        //     key: form,
        //     child: SingleChildScrollView(
        //       child:
        //     ),
        //   ),
        // ),
        );
  }
}
