import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_speciality_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/edit_doctor_specialist.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:get/get.dart';

class DoctorEditSpeciality extends GetView<DoctorEditSpecialityController> {
  const DoctorEditSpeciality({super.key});

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
            "Edit speciality",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          CupertinoButton(
            pressedOpacity: 0,
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: () {
              if (controller.selectedIndex.value == -1) {
                showToastMessage(
                    message: 'Please Select Speciality',
                    context: context,
                    color: const Color(0xffEC1C24),
                    icon: Icons.close);
              } else {
                controller.updateDoctorSpeciality(context: context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Text(
                "Save",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const LoadingWidget()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 4 * SizeConfig.widthMultiplier),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3 * SizeConfig.heightMultiplier),
                    const DoctorSpecialtyContainer(),
                  ],
                ),
              ),
      ),
    );
  }
}
