import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/widget/doctor_drawer_widget.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorHomeAppBar extends StatelessWidget {
  const DoctorHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.locationIcon,
                    height: 17,
                  ),
                  4.horizontalSpace,
                  Text(
                    "Location",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff979797),
                      fontSize: 1.4 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  20.horizontalSpace,
                  SvgPicture.asset(
                    Assets.arrowDownIcon,
                    height: 20,
                  ),
                ],
              ),
              4.verticalSpace,
              Text(
                "Xurmal, salm street, asia b..",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackBGColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
              onTap: () => Get.toNamed(Routes.doctorNotification),
              child: SvgPicture.asset(Assets.notificationIcon,
                  height: 23, width: 23)),
          14.horizontalSpace,
          GestureDetector(
              onTap: () => Get.toNamed(Routes.doctorMessage),
              child:
                  SvgPicture.asset(Assets.messageIcon, height: 23, width: 23)),
          SizedBox(width: 2.5 * SizeConfig.widthMultiplier)
        ],
      ),
      elevation: 0,
      leading: const DoctorDrawerWidget(),
    );
  }
}
