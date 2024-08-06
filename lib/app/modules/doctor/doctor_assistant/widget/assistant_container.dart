import 'package:flutter/material.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class AssistantContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const AssistantContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5 * SizeConfig.heightMultiplier),
      padding: EdgeInsets.symmetric(
          horizontal: 4 * SizeConfig.widthMultiplier,
          vertical: 1.5 * SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.whiteBGColor,
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.lighttextColor,
                fontSize: 1.7 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
          Text(
            subtitle,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blackBGColor,
              fontSize: 1.7 * SizeConfig.heightMultiplier,
            ),
          ),
        ],
      ),
    );
  }
}
