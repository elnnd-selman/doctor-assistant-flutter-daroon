import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostLikeUserDetail extends StatelessWidget {
  const PostLikeUserDetail({super.key});

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
            "Likes",
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
            SearchTextfeild(
              obscuretext: false,
              hinttext: "Search User",
              validations: null,
              controller: TextEditingController(),
              borderColor: Colors.transparent,
              keyboardType: TextInputType.emailAddress,
              showicon: true,
              scanIcons: false,
              onChange: (val) {},
            ),
            SizedBox(height: 3 * SizeConfig.heightMultiplier),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Get.find<DoctorHomeController>()
                                  .userModel
                                  .value!
                                  .user!
                                  .profilePicture ==
                              null
                          ? Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              width: 5 * SizeConfig.heightMultiplier,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.blackBGColor,
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    '${Get.find<DoctorHomeController>().userModel.value!.user!.firstName![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.lastNameEn![0].toUpperCase()}',
                                    style: AppTextStyles.bold.copyWith(
                                      color: Colors.white,
                                      fontSize: Spaces.fontSize(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              width: 5 * SizeConfig.heightMultiplier,
                              // padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // color: AppColors.blackBGColor,
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: NetWorkImageLoader(
                                        containerColor: Colors.black54,
                                        imageURL:
                                            Get.find<DoctorHomeController>()
                                                .userModel
                                                .value!
                                                .user!
                                                .profilePicture!
                                                .md!,
                                        height: 5 * SizeConfig.heightMultiplier,
                                        width: 5 * SizeConfig.heightMultiplier),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Get.find<DoctorHomeController>().userModel.value!.user!.firstName!.toUpperCase()} ${Get.find<DoctorHomeController>().userModel.value!.user!.lastNameEn!.toUpperCase()}',
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackBGColor,
                          fontSize: 1.8 * SizeConfig.heightMultiplier,
                        ),
                      ),
                      Text(
                        "Female",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.lighttextColor,
                          fontSize: 1.6 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
