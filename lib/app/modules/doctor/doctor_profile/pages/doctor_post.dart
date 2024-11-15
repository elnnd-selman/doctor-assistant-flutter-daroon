import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/doctor_image_post.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';

class DoctorPost extends GetView<DoctorProfileController> {
  const DoctorPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            hint: Text(
              'All Posts',
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xff535353),
              ),
            ),
            items: controller.getPostType.map<DropdownMenuItem<String>>((val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val.capitalizeFirst!,
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.blackBGColor,
                  ),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return '   Please Choose Country';
              }
              return null;
            },
            onChanged: (value) {
              controller.selecetdPostType.value = value!;
              controller.getDoctorPost(postType: value);
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.only(right: 4 * SizeConfig.widthMultiplier),
            ),
            iconStyleData: IconStyleData(
              icon: SvgPicture.asset("assets/icons/downIcon.svg"),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              decoration: BoxDecoration(
                color: const Color(0xffF7F7F8),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        24.verticalSpace,
        Obx(
          () => controller.isLoading.value
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier),
                  child: const LoadingWidget(),
                )
              : controller.contentModelList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 20 * SizeConfig.heightMultiplier),
                      child: const Text(
                        "No Post Found",
                        style: AppTextStyles.bold,
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.reFetchLoader.value
                          ? controller.contentModelList.length + 1
                          : controller.contentModelList.length,
                      itemBuilder: (context, index) {
                        if (index < controller.contentModelList.length) {
                          return DoctorImagePostContainer(
                            index: index,
                            contentData: controller.contentModelList[index],
                          );
                        } else {
                          return const Center(
                            child: LoadingWidget(),
                          );
                        }
                      },
                    ),
        ),
      ],
    );

    // const
  }
}
