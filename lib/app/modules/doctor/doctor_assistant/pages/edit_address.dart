import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/common_button.dart';

class DoctorAssistentEditAddress extends StatelessWidget {
  const DoctorAssistentEditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBGColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            Get.arguments["isEditing"] ? "Edit Address" : "Select Address",
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
        child: Column(
          children: [
            SizedBox(
              height: 4 * SizeConfig.heightMultiplier,
            ),
            Text(
              "You can select you want assistant assist you in which address, for better servece patient.",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackBGColor.withOpacity(0.5),
                fontSize: 1.4 * SizeConfig.heightMultiplier,
              ),
            ),
            SizedBox(height: 3 * SizeConfig.heightMultiplier),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 2 * SizeConfig.heightMultiplier,
                  horizontal: 5 * SizeConfig.widthMultiplier),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.secondaryborderColor, width: 0.5)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff6FCF84)),
                      ),
                      10.horizontalSpace,
                      Text(
                        "4 days per week",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff898A8D),
                          fontSize: 1.4 * SizeConfig.heightMultiplier,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: APp
                            border: Border.all(color: AppColors.primaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE8E8E8),
                        width: .5,
                      ),
                    ),
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.primaryColor,
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                Assets.locationIcon,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.whiteBGColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 2 * SizeConfig.heightMultiplier),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              "Sulaymaniyah, Orzdi street, Asa building, floor 3, appartment 30..",
                              maxLines: 2,
                              style: AppTextStyles.black.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackBGColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            CommonButton(ontap: () {}, name: "Save"),
          ],
        ),
      ),
    );
  }
}