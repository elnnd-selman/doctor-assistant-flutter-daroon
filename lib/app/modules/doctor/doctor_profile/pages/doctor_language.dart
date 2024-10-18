import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_language_controller.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class DoctorLanguageScreen extends GetView<DoctorLanguageController> {
  const DoctorLanguageScreen({super.key});

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
            "Language",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              "Save",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                fontSize: 1.5 * SizeConfig.heightMultiplier,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              _buildLanguageTExtField(),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.languageList.length,
                  itemBuilder: (context, index) {
                    return languageContainer(
                        controller.languageList[index], index, () {
                      controller.selectedIndex.value = index;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector languageContainer(
    String title,
    int index,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackBGColor,
                fontSize: 1.8 * SizeConfig.heightMultiplier,
              ),
            ),
            const Spacer(),
            Obx(
              () => Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == index
                      ? AppColors.primaryColor
                      : const Color(0xff898A8D).withOpacity(.22),
                  border: Border.all(
                      color: controller.selectedIndex.value == index
                          ? Colors.transparent
                          : AppColors.lighttextColor.withOpacity(.3)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: controller.selectedIndex.value == index
                      ? AppColors.whiteBGColor
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildLanguageTExtField() {
    return TextFormField(
      style: AppTextStyles.medium.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.blackBGColor,
      ),
      cursorColor: Colors.black12,
      cursorWidth: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
        fillColor: const Color(0xffF7F7F8),
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: SvgPicture.asset(
            Assets.serachIcon,
            colorFilter: const ColorFilter.mode(
                AppColors.lighttextColor, BlendMode.srcIn),
          ),
        ),
        isDense: true,
        hintText: "Search Language",
        hintStyle: AppTextStyles.medium.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: const Color(0xff787B80),
        ),
      ),
    );
  }
}
