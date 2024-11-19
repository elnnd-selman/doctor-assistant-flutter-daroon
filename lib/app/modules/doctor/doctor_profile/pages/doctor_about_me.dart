import 'package:carousel_slider/carousel_slider.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/user_profile_model.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:get/get.dart';

class DoctorAboutMe extends GetView<DoctorProfileController> {
  const DoctorAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.processing.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: LoadingWidget()),
                )
              : controller.userProfileModel.value!.userProfile == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width,
                      child:
                          const Center(child: Text("No Education available ")))
                  : controller.userProfileModel.value!.userProfile!.education
                          .isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                              child: Text("No Education available ")))
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                              ),
                              itemCount: controller.userProfileModel.value!
                                  .userProfile!.education.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return _buildEducationContainer(
                                    context,
                                    controller.userProfileModel.value!
                                        .userProfile!.education[itemIndex]);
                              }),
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
              Obx(() => controller.processing.value
                  ? const LoadingWidget()
                  : Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.checkLanguageExist("en")
                            ? _languageContainer("English")
                            : const SizedBox(),
                        controller.checkLanguageExist("ar")
                            ? _languageContainer("Arabic")
                            : const SizedBox(),
                        controller.checkLanguageExist("ku")
                            ? _languageContainer("Kurdish")
                            : const SizedBox(),
                      ],
                    ))
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
              Obx(
                () => Text(
                  "${controller.processing.value ? '--' : controller.userProfileModel.value == null ? "--" : controller.userProfileModel.value!.userProfile!.biographyEn}",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighttextColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8 * SizeConfig.heightMultiplier),
      ],
    );
  }

  Container _buildEducationContainer(
      BuildContext context, Education education) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
          vertical: MediaQuery.of(context).size.height * 0.018),
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
            education.degreeNameEn!,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackBGColor,
              fontSize: SizeConfig.heightMultiplier * 1.8,
            ),
          ),
          7.verticalSpace,
          Text(
            education.instituteEn!,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.lighttextColor,
              fontSize: SizeConfig.heightMultiplier * 1.8,
            ),
          ),
          Text(
            "${education.fromYear} - ${education.toYear}",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.lighttextColor,
              fontSize: SizeConfig.heightMultiplier * 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Container _languageContainer(String language) {
    return Container(
      margin: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
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
