import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:get/get.dart';

class DoctorProfileHeadrer extends StatelessWidget {
  const DoctorProfileHeadrer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Get.find<DoctorHomeController>()
                    .userModel
                    .value!
                    .user!
                    .profilePicture ==
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
                      '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.firstName![0].toUpperCase()}',
                      style: AppTextStyles.bold.copyWith(
                        color: Colors.white,
                        fontSize: Spaces.fontSize(fontSize: 18),
                      ),
                    ),
                  ),
                ))
            : CircleAvatar(
                radius: 14,
                child: ClipOval(
                  child: NetWorkImageLoader(
                    imageURL: Get.find<DoctorHomeController>()
                        .userModel
                        .value!
                        .user!
                        .profilePicture,
                    height: 10 * SizeConfig.heightMultiplier,
                    width: 10 * SizeConfig.heightMultiplier,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
        // Container(
        //   height: 10 * SizeConfig.heightMultiplier,
        //   width: 10 * SizeConfig.heightMultiplier,
        //   decoration: const BoxDecoration(
        //       image: DecorationImage(
        //         image: AssetImage("assets/images/tempImages.png"),
        //       ),
        //       shape: BoxShape.circle),
        // ),
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
              "Specialist",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.lighttextColor,
                fontSize: SizeConfig.heightMultiplier * 1.6,
              ),
            ),
            4.verticalSpace,
            // SizedBox(height: 0.5 * SizeConfig.heightMultiplier),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.levelIcon,
                  height: 15,
                ),
                10.horizontalSpace,
                Text(
                  "Level name",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighttextColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
