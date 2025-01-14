import 'dart:io';

import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/gender_dialog_box.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/uplaod_profile_pic_dialog.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class DoctorEditProfile extends GetView<DoctorEditProfileController> {
  const DoctorEditProfile({super.key});

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
            "Edit Profile",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 24),
        //     child: Text(
        //       "Save",
        //       style: AppTextStyles.medium.copyWith(
        //         fontWeight: FontWeight.w600,
        //         color: AppColors.primaryColor,
        //         fontSize: 1.4 * SizeConfig.heightMultiplier,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const LoadingWidget()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 6 * SizeConfig.widthMultiplier),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4 * SizeConfig.heightMultiplier),
                      Center(
                        child: Stack(
                          children: [
                            controller.imageUrl.value != ""
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 10 * SizeConfig.heightMultiplier,
                                    width: 10 * SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.7),
                                      image: controller.imageUrl.value == ''
                                          ? null
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(controller.imageUrl.value),
                                              )),
                                      border: Border.all(
                                        color: const Color(0xffE7E8EA),
                                      ),
                                    ),
                                  )
                                : controller.userProfileModel.value!
                                            .userProfile!.profilePicture ==
                                        null
                                    ? Container(
                                        alignment: Alignment.center,
                                        height:
                                            10 * SizeConfig.heightMultiplier,
                                        width: 10 * SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              '${controller.userProfileModel.value!.userProfile!.username![0].toUpperCase()}${controller.userProfileModel.value!.userProfile!.firstName![0].toUpperCase()}',
                                              style:
                                                  AppTextStyles.bold.copyWith(
                                                color: Colors.white,
                                                fontSize: Spaces.fontSize(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ))
                                    : ClipOval(
                                        child: NetWorkImageLoader(
                                          imageURL: controller
                                              .userProfileModel
                                              .value!
                                              .userProfile!
                                              .profilePicture!
                                              .bg!,
                                          height:
                                              10 * SizeConfig.heightMultiplier,
                                          width:
                                              10 * SizeConfig.heightMultiplier,
                                          shape: BoxShape.circle,
                                          boxFit: BoxFit.cover,
                                          containerColor:
                                              Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                            Positioned(
                              bottom: 3,
                              right: 8,
                              child: CupertinoButton(
                                pressedOpacity: 0,
                                padding: EdgeInsets.zero,
                                minSize: 0,
                                onPressed: () => updateProfilePhoto(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 3 * SizeConfig.heightMultiplier,
                                  width: 3 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor,
                                      border: Border.all(
                                          color: AppColors.whiteBGColor,
                                          width: 2.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.whiteBGColor,
                                      size: 1.5 * SizeConfig.heightMultiplier,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Name",
                        subtitle: controller
                            .userProfileModel.value!.userProfile!.username!,
                        showIcon: false,
                        hintText: "UserName",
                        onTap: () {},
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Specialist",
                        subtitle: controller.userProfileModel.value!
                                    .userProfile!.speciality ==
                                null
                            ? '--'
                            : controller.userProfileModel.value!.userProfile!
                                .speciality!.specialityEn!,
                        showIcon: true,
                        hintText: "Specialist Name",
                        onTap: () => Get.toNamed(Routes.doctorEditSpeciality),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Level",
                        subtitle: controller.userProfileModel.value!
                                    .userProfile!.level ==
                                null
                            ? '--'
                            : controller.userProfileModel.value!.userProfile!
                                .level!.levelEn!,
                        showIcon: true,
                        hintText: "Level",
                        onTap: () => Get.toNamed(Routes.doctorEditLevel),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Education",
                        subtitle: controller.userProfileModel.value!
                                    .userProfile!.level ==
                                null
                            ? '--'
                            : controller.userProfileModel.value!.userProfile!
                                    .education.isEmpty
                                ? "--"
                                : controller.userProfileModel.value!
                                    .userProfile!.education[0].degreeNameEn!,
                        showIcon: true,
                        hintText: "Level",
                        onTap: () => Get.toNamed(Routes.addEducation),
                      ),
                      // SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      // _profileTextField(
                      //   context: context,
                      //   title: "Language",
                      //   subtitle: controller.userProfileModel.value!
                      //           .userProfile!.languages.isEmpty
                      //       ? '--'
                      //       : controller.splitAppLanguage(controller
                      //           .userProfileModel
                      //           .value!
                      //           .userProfile!
                      //           .languages),
                      //   showIcon: true,
                      //   hintText: "Language",
                      //   onTap: () => Get.toNamed(Routes.doctorchangeLanguage),
                      // ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Bio",
                        subtitle: controller.userProfileModel.value!
                                    .userProfile!.biographyEn ==
                                null
                            ? "--"
                            : controller.userProfileModel.value!.userProfile!
                                .biographyEn!,
                        showIcon: true,
                        hintText: "-",
                        onTap: () {},
                      ),
                      SizedBox(height: 6 * SizeConfig.heightMultiplier),
                      Text(
                        "Private Information",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff11142D),
                          fontSize: 2 * SizeConfig.heightMultiplier,
                        ),
                      ),
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Email",
                        subtitle: controller
                            .userProfileModel.value!.userProfile!.email!,
                        showIcon: true,
                        hintText: "Email",
                        onTap: () => Get.toNamed(Routes.doctorChangeEmail),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Phone",
                        subtitle: controller.userProfileModel.value!
                            .userProfile!.phone!.number!,
                        showIcon: false,
                        hintText: "Phone",
                        onTap: () {},
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      _profileTextField(
                        context: context,
                        title: "Username",
                        subtitle: controller
                            .userProfileModel.value!.userProfile!.username!,
                        showIcon: true,
                        hintText: "Username",
                        onTap: () => Get.toNamed(Routes.doctorChangeUserName),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),

                      GetBuilder<DoctorEditProfileController>(
                          initState: (ctrl) {},
                          builder: (ctrl) {
                            return _profileTextField(
                              context: context,
                              title: "Gender",
                              subtitle: ctrl
                                  .userProfileModel.value!.userProfile!.gender!
                                  .toUpperCase(),
                              showIcon: true,
                              hintText: "Gender",
                              onTap: () {
                                if (ctrl.userProfileModel.value!.userProfile!
                                        .gender ==
                                    "male") {
                                  ctrl.selectedGender.value = 0;
                                } else {
                                  ctrl.selectedGender.value = 1;
                                }

                                Get.dialog(
                                  barrierDismissible: false,
                                  const GenderDialogBox(),
                                  barrierColor:
                                      AppColors.blackBGColor.withOpacity(0.5),
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Row _profileTextField({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String hintText,
    required Function()? onTap,
    required bool showIcon,
  }) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            title,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xff707281),
              fontSize: 1.8 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        Expanded(
          child: CustomCupertinoButton(
            onTap: onTap,
            child: TextFormField(
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xff11142D),
              ),
              initialValue: subtitle,
              cursorColor: AppColors.blackBGColor,
              // cursorHeight: 10,
              decoration: InputDecoration(
                enabled: false,
                contentPadding: const EdgeInsets.only(top: 10, bottom: 20),
                fillColor: Colors.white,
                filled: true,
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                suffixIcon: showIcon
                    ? CustomCupertinoButton(
                        onTap: onTap,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        ),
                      )
                    : const SizedBox(),
                isDense: true,
                hintText: hintText,
                hintStyle: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xffA0A1AB),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
