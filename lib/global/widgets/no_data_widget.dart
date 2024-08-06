import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    this.backGroundcolor = Colors.white,
    this.svgIconColor = Colors.white,
    this.iconBgColor = AppColors.blackBGColor,
    this.iconType = false,
  });

  final String iconPath, title, description;
  final Color? backGroundcolor;
  final Color iconBgColor, svgIconColor;
  final bool iconType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(Get.context!).size.height * 0.3),
        // height: MediaQuery.of(Get.context!).size.height * 0.3,
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
          color: backGroundcolor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(14.0),
              child: iconType
                  ? Image.asset(
                      iconPath,
                      height: 12.0,
                      width: 12.0,
                      color: svgIconColor,
                    )
                  : SvgPicture.asset(
                      iconPath,
                      colorFilter:
                          ColorFilter.mode(svgIconColor, BlendMode.srcIn),
                      height: 12.0,
                      width: 12.0,
                    ),
            ),
            16.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bold.copyWith(
                fontSize: 20,
                letterSpacing: -0.9,
              ),
            ),
            12.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.normal.copyWith(
                  fontSize: 14,
                  color: AppColors.greyColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
