import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

class NotificationContainer extends StatelessWidget {
  final String iconUrl;
  const NotificationContainer({
    super.key,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
          color: const Color(0xffDED6FF).withOpacity(.63),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: 5 * SizeConfig.heightMultiplier,
            width: 5 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.06),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(iconUrl),
            ),
          ),
          10.horizontalSpace,
          Flexible(
            child: Column(
              children: [
                Text(
                  "Your call appointment with [patient name] started in 20 minutes.",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff50555C),
                    fontSize: 1.6 * SizeConfig.heightMultiplier,
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Text(
                "2min",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lighttextColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
