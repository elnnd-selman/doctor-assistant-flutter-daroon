import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/controller/doctor_custom_navi_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class DoctorProfileAppBar extends GetView<DoctorCustomNaviController> {
  const DoctorProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      // leading: const SizedBox(),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          "Profile",
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.blackBGColor,
            fontSize: 2 * SizeConfig.heightMultiplier,
          ),
        ),
      ),
      actions: [
        CustomCupertinoButton(
          onTap: () => Get.toNamed(Routes.doctorEditProfile),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Edit",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                fontSize: 1.6 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
        )
      ],
    );
  }
}
