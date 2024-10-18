import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/widget/doctor_image_post.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';

class DoctorPost extends GetView<DoctorProfileController> {
  const DoctorPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Padding(
              padding: EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier),
              child: const LoadingWidget(),
            )
          : controller.contentModelList.value == null
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier),
                  child: const Text(
                    "No Post Found",
                    style: AppTextStyles.bold,
                  ),
                )
              : controller.contentModelList.value!.data.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 20 * SizeConfig.heightMultiplier),
                      child: const Text(
                        "No Post Found",
                        style: AppTextStyles.bold,
                      ),
                    )
                  : ListView.builder(
                      // padding: EdgeInsets.only(bottom: 6 * SizeConfig.heightMultiplier),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.contentModelList.value!.data.length,
                      itemBuilder: (context, index) {
                        return DoctorImagePostContainer(
                          index: index,
                          contentData:
                              controller.contentModelList.value!.data[index],
                        );
                      }),
    );

    // const
  }
}
