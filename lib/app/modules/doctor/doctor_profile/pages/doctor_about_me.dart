import 'package:flutter/material.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAboutMe extends StatelessWidget {
  const DoctorAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
              color: const Color(0xffE8E8E8).withOpacity(.24),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Education",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.heightMultiplier * 2,
                ),
              ),
              10.verticalSpace,
              Text(
                "Science of Psychiatrist",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackBGColor,
                  fontSize: SizeConfig.heightMultiplier * 1.8,
                ),
              ),
              7.verticalSpace,
              Text(
                "Koya University",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.lighttextColor,
                  fontSize: SizeConfig.heightMultiplier * 1.8,
                ),
              ),
              Text(
                "2020",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.lighttextColor,
                  fontSize: SizeConfig.heightMultiplier * 1.8,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3 * SizeConfig.heightMultiplier),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
              color: const Color(0xffE8E8E8).withOpacity(.24),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Languages",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.heightMultiplier * 2,
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _languageContainer("English"),
                  _languageContainer("Arabic"),
                  _languageContainer("Kurdish"),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 3 * SizeConfig.heightMultiplier),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
              color: const Color(0xffE8E8E8).withOpacity(.24),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Biography",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.heightMultiplier * 2,
                ),
              ),
              10.verticalSpace,
              Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a form of a   form of a  document In publishing and graphic design form of a  document ...",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lighttextColor,
                  fontSize: SizeConfig.heightMultiplier * 1.6,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8 * SizeConfig.heightMultiplier),
      ],
    );
  }

  Container _languageContainer(String language) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 5 * SizeConfig.widthMultiplier, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.06),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
          language,
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.blackBGColor,
            fontSize: SizeConfig.heightMultiplier * 1.8,
          ),
        ),
      ),
    );
  }
}
