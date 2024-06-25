import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/user/user_bottom_navi_bar/widget/user_drawer_widget.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

class UserHomeAppBar extends StatelessWidget {
  const UserHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.whiteBGColor,
      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.doctorNotification),
          child:
              SvgPicture.asset(Assets.notificationIcon, height: 23, width: 23),
        ),
        14.horizontalSpace,
        GestureDetector(
            onTap: () => Get.toNamed(Routes.doctorMessage),
            child: SvgPicture.asset(Assets.messageIcon, height: 23, width: 23)),
        SizedBox(width: 2.5 * SizeConfig.widthMultiplier)
      ],
      elevation: 0,
      leading: const UserDrawerWidget(),
    );
  }
}