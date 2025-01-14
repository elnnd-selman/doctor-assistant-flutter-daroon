import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_level_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/level_model.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';

class DoctorEditLevel extends GetView<DoctorEditLevelCtrl> {
  const DoctorEditLevel({super.key});

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
      body: Obx(
        () => controller.isLoading.value
            ? const LoadingWidget()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 6 * SizeConfig.widthMultiplier),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3 * SizeConfig.heightMultiplier),
                    Text(
                      "Please Indicate Your Training or Specialization Level.",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff707281),
                        fontSize: 1.6 * SizeConfig.heightMultiplier,
                      ),
                    ),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                    DropdownButtonFormField2<LevelData>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF7F7F8),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: Text(
                        'Choose level',
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color(0xffA0A1AB),
                        ),
                      ),
                      items: controller.levelDataList
                          .map<DropdownMenuItem<LevelData>>((LevelData level) {
                        return DropdownMenuItem<LevelData>(
                          value: level,
                          child: Text(level.levelEn!),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return '   Please Choose level';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedLevel.value = value!.id!;
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.only(
                            right: 4 * SizeConfig.widthMultiplier),
                      ),
                      iconStyleData: IconStyleData(
                        icon: SvgPicture.asset("assets/icons/downIcon.svg"),
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
                    CommonButton(
                        ontap: () {
                          if (controller.selectedLevel.value == '') {
                            showToastMessage(
                                message: 'Please Select Level',
                                context: context,
                                color: const Color(0xffEC1C24),
                                icon: Icons.close);
                          } else {
                            controller.updateDoctorLevel(
                                data: Get.find<DoctorEditProfileController>()
                                    .userProfileModel
                                    .value!
                                    .userProfile!,
                                context: context);
                          }
                        },
                        name: "Save"),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
      ),
    );
  }
}
