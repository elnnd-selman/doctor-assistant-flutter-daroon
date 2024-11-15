import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_about_me.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_post.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_reviews.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/doctor_profile_header.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/doctor_profile_header_row.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/doctor_profile_toggle_button.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';

class DoctorProfileScreen extends GetView<DoctorProfileController> {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 4 * SizeConfig.widthMultiplier,
          vertical: 3 * SizeConfig.heightMultiplier),
      child: ListView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        children: [
          const DoctorProfileHeadrer(),
          SizedBox(height: 5 * SizeConfig.heightMultiplier),
          const DoctorProfileHeaderRow(),
          SizedBox(height: 5 * SizeConfig.heightMultiplier),
          Obx(
            () => DoctorProfileToggleButton(
              leftText: 'About Me',
              centreText: 'Posts',
              rightText: 'Reviews',
              value: controller.selectedTab,
              onValueChange: controller.selectTab,
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Obx(
            () => controller.selectedTab == 0
                ? const DoctorAboutMe()
                : controller.selectedTab == 1
                    ? const DoctorPost()
                    : const DoctorReviews(),
          ),
          SizedBox(height: 6 * SizeConfig.heightMultiplier),
        ],
      ),
    );
  }
}
