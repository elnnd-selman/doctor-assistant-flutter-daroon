import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

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
        Container(
          height: 10 * SizeConfig.heightMultiplier,
          width: 10 * SizeConfig.heightMultiplier,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/tempImages.png"),
              ),
              shape: BoxShape.circle),
        ),
        14.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * SizeConfig.heightMultiplier),
            Text(
              "Dr. Doctor Name",
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
