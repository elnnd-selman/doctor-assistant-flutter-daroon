import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:get/get.dart';

class DoctorProfileHeadrer extends GetView<DoctorProfileController> {
  const DoctorProfileHeadrer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.processing.value
            ? const LoadingWidget()
            : controller.userProfileModel.value!.userProfile!.profilePicture ==
                    null
                ? Container(
                    height: 10 * SizeConfig.heightMultiplier,
                    width: 10 * SizeConfig.heightMultiplier,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.blackBGColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          '${controller.userProfileModel.value!.userProfile!.username![0].toUpperCase()}${controller.userProfileModel.value!.userProfile!.firstName![0].toUpperCase()}',
                          style: AppTextStyles.bold.copyWith(
                            color: Colors.white,
                            fontSize: Spaces.fontSize(fontSize: 18),
                          ),
                        ),
                      ),
                    ))
                : ClipOval(
                    child: NetWorkImageLoader(
                      imageURL: controller.userProfileModel.value!.userProfile!
                          .profilePicture!.md!,
                      height: 10 * SizeConfig.heightMultiplier,
                      width: 10 * SizeConfig.heightMultiplier,
                      boxFit: BoxFit.cover,
                      shape: BoxShape.circle,
                    ),
                  ),
        14.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * SizeConfig.heightMultiplier),
            Text(
              Get.find<DoctorHomeController>().userModel.value!.user!.username!,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blackBGColor,
                fontSize: SizeConfig.heightMultiplier * 1.8,
              ),
            ),
            4.verticalSpace,
            Text(
              "${controller.processing.value ? '--' : controller.userProfileModel.value == null ? "--" : controller.userProfileModel.value!.userProfile!.speciality == null ? "--" : controller.userProfileModel.value!.userProfile!.speciality!.specialityEn}",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.lighttextColor,
                fontSize: SizeConfig.heightMultiplier * 1.6,
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(
                  Assets.levelIcon,
                  height: 15,
                ),
                10.horizontalSpace,
                Text(
                  "${controller.processing.value ? '--' : controller.userProfileModel.value == null ? "--" : controller.userProfileModel.value!.userProfile!.level == null ? "--" : controller.userProfileModel.value!.userProfile!.level!.levelEn}",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighttextColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
