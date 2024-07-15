import 'package:flutter/material.dart';
import 'package:hezr/app/modules/doctor/doctor_notification/widget/notification_conatiner.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

class DoctorNotificationScreen extends StatelessWidget {
  const DoctorNotificationScreen({super.key});

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
            "Notifications",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              Row(
                children: [
                  Text(
                    "Today",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.lighttextColor,
                      fontSize: 2 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Mark all as read",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontSize: 1.6 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              const NotificationContainer(iconUrl: Assets.locationIcon),
              const NotificationContainer(iconUrl: Assets.cameraIcon),
              const NotificationContainer(iconUrl: Assets.calendarIcon),
              const NotificationContainer(iconUrl: Assets.phone),
              const NotificationContainer(iconUrl: Assets.commentIcon),
            ],
          ),
        ),
      ),
    );
  }
}
