import 'package:flutter/material.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

class DoctorAssistantDetailContainer extends StatelessWidget {
  const DoctorAssistantDetailContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 5 * SizeConfig.widthMultiplier),
            margin: EdgeInsets.only(top: 5.5 * SizeConfig.heightMultiplier),
            // height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color(0xffF2F8FF),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.only(top: 8 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    "Assistant Name",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackBGColor,
                      fontSize: 2 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  Text(
                    "@Username",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.lighttextColor,
                      fontSize: 1.5 * SizeConfig.heightMultiplier,
                    ),
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  _buildAssistantContainer(
                      context: context, title: "Gender", subtitle: "Female"),
                  _buildAssistantContainer(
                      context: context,
                      title: "Phone Number",
                      subtitle: "+963 750 123 4567"),
                  _buildAssistantContainer(
                      context: context,
                      title: "Email",
                      subtitle: "assistant@gmail.com"),
                  SizedBox(height: 2.5 * SizeConfig.heightMultiplier)
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: SizeConfig.heightMultiplier * 12,
              width: SizeConfig.heightMultiplier * 12,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage("assets/images/tempImages.png"),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAssistantContainer({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
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
