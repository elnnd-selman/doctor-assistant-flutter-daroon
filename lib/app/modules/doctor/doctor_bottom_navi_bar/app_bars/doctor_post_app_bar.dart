import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/controller/doctor_custom_navi_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorPostAppBar extends GetView<DoctorCustomNaviController> {
  const DoctorPostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Get.find<DoctorHomeController>()
                      .userModel
                      .value!
                      .user!
                      .profilePicture ==
                  null
              ? Container(
                  height: 5 * SizeConfig.heightMultiplier,
                  width: 5 * SizeConfig.heightMultiplier,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: AppColors.blackBGColor, shape: BoxShape.circle),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.firstName![0].toUpperCase()}',
                        style: AppTextStyles.bold.copyWith(
                          color: Colors.white,
                          fontSize: Spaces.fontSize(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 14,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: Get.find<DoctorHomeController>()
                          .userModel
                          .value!
                          .user!
                          .profilePicture,
                      fit: BoxFit.cover,
                      height: 5 * SizeConfig.heightMultiplier,
                      width: 5 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ),
          14.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Get.find<DoctorHomeController>()
                    .userModel
                    .value!
                    .user!
                    .username!,
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
