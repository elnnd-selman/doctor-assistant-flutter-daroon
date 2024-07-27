import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/widget/doctor_image_post.dart';
import 'package:hezr/global/widgets/loading_overlay.dart';

class DoctorPost extends GetView<DoctorProfileController> {
  const DoctorPost({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.isLoading.value
        ? LoadingOverlay()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.contentModelList.value!.data.length,
            itemBuilder: (context, index) {
              return DoctorImagePostContainer(
                contentData: controller.contentModelList.value!.data[index],
              );
            });

    // const
  }
}
