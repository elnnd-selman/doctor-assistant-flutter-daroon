import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/controller/doctor_custom_navi_controller.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

class DoctorPostAppBar extends GetView<DoctorCustomNaviController> {
  const DoctorPostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteBGColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5 * SizeConfig.heightMultiplier,
            width: 5 * SizeConfig.heightMultiplier,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/tempImages.png"),
                ),
                shape: BoxShape.circle),
          ),
          14.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Dr. Doctor Name",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackBGColor,
                  fontSize: SizeConfig.heightMultiplier * 1.8,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
