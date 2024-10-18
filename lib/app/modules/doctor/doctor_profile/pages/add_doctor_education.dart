import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/add_education_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddDoctorEducation extends GetView<AddEducationController> {
  const AddDoctorEducation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Edit Level",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3 * SizeConfig.heightMultiplier),
                  Text(
                    "Please Add you Ecducation",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff707281),
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 1,
                    hinttext: "Degree Name-Ku",
                    controller: controller.degreeKU,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Degree Name-ku";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 1,
                    hinttext: "Degree Name-En",
                    controller: controller.degreeEN,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Degree Name-En";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 1,
                    hinttext: "Degree Name-Ar",
                    controller: controller.degreeAR,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Degree Name-Ar";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 3,
                    hinttext: "Institute Name-Ku...",
                    controller: controller.instituteKu,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Institute Name-Ku...";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 3,
                    hinttext: "Institute Name-En...",
                    controller: controller.instituteEN,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Institute Name-En...";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  CommonTextfeild(
                    scanIcons: false,
                    obscuretext: false,
                    borderColor: Colors.transparent,
                    maxLine: 3,
                    hinttext: "Institute Name-AR...",
                    controller: controller.instituteAR,
                    keyboardType: TextInputType.emailAddress,
                    showicon: false,
                    validations: (value) {
                      if (value!.isEmpty) {
                        return "Enter Institute Name-AR...";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Row(
                    children: [
                      Expanded(
                          child: Obx(
                        () => _buildTimeContainer(
                          title: controller.fromYear.value == null
                              ? "From Year"
                              : controller
                                  .formatDate(controller.fromYear.value!),
                          ontap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: const BoxDecoration(
                                    color: AppColors.whiteBGColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        "Done",
                                        style: AppTextStyles.bold.copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        itemExtent: 100,
                                        initialDateTime: DateTime.now(),
                                        backgroundColor: AppColors.whiteBGColor,
                                        mode: CupertinoDatePickerMode.monthYear,
                                        onDateTimeChanged: (date) {
                                          controller.fromYear.value = date;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Obx(
                          () => _buildTimeContainer(
                            title: controller.toYear.value == null
                                ? "To Year"
                                : controller
                                    .formatDate(controller.toYear.value!),
                            ontap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: const BoxDecoration(
                                      color: AppColors.whiteBGColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          "Done",
                                          style: AppTextStyles.bold.copyWith(
                                              color: AppColors.primaryColor,
                                              fontSize: 18),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          itemExtent: 100,
                                          initialDateTime: DateTime.now(),
                                          backgroundColor:
                                              AppColors.whiteBGColor,
                                          mode:
                                              CupertinoDatePickerMode.monthYear,
                                          onDateTimeChanged: (date) {
                                            controller.toYear.value = date;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3 * SizeConfig.heightMultiplier),
                  CommonButton(
                      ontap: () => controller.checkValidation(context),
                      name: "Save"),
                  SizedBox(height: 4 * SizeConfig.heightMultiplier),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.processing) {
              return const LoadingOverlay();
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  GestureDetector _buildTimeContainer({
    required String title,
    required Function()? ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier, vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF7F7F8),
          border: Border.all(
            color: const Color(0xffE7E8EA),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 2 * SizeConfig.widthMultiplier),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.heightMultiplier * 1.5,
                  color: const Color(0xff535353),
                ),
              ),
            ),
            const Spacer(),
            SvgPicture.asset("assets/icons/downIcon.svg"),
          ],
        ),
      ),
    );
  }
}
