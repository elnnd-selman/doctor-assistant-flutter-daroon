import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/post_like_user_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/like_user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostLikeUserDetail extends GetView<PostLikeUserController> {
  PostLikeUserDetail({super.key});

  final postData = Get.arguments[0] as ContentData;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostLikeUserController>(initState: (_) {
      controller.setPostData(postData);
    }, builder: (_) {
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
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: LoadingWidget(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6 * SizeConfig.widthMultiplier),
                  child: Column(
                    children: [
                      SearchTextfeild(
                        obscuretext: false,
                        hinttext: "Search User",
                        validations: null,
                        controller: controller.userName,
                        borderColor: Colors.transparent,
                        keyboardType: TextInputType.emailAddress,
                        showicon: true,
                        scanIcons: false,
                        onChange: (val) {
                          if (val.isNotEmpty) {
                            controller.isSearch.value = true;
                            controller.searchUser(val);
                          } else {
                            controller.isSearch.value = false;
                          }
                        },
                      ),
                      SizedBox(height: 3 * SizeConfig.heightMultiplier),
                      controller.isSearch.value
                          ? controller.searchUserList.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      "No User Found",
                                      style: AppTextStyles.bold,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.searchUserList.length,
                                      itemBuilder: (context, index) {
                                        return UserDetailContainer(
                                          likeUserModelData:
                                              controller.searchUserList[index],
                                        );
                                      }),
                                )
                          : controller.likeUserModelList.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      "No User Found",
                                      style: AppTextStyles.bold,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.likeUserModelList.length,
                                    itemBuilder: (context, index) {
                                      return UserDetailContainer(
                                        likeUserModelData:
                                            controller.likeUserModelList[index],
                                      );
                                    },
                                  ),
                                )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}

class UserDetailContainer extends StatelessWidget {
  final LikeUserModelData likeUserModelData;
  const UserDetailContainer({
    super.key,
    required this.likeUserModelData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            children: [
              likeUserModelData.profilePicture == null
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
                            '${likeUserModelData.firstName![0].toUpperCase()}${likeUserModelData.firstName![1].toUpperCase()}',
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: NetWorkImageLoader(
                                containerColor: Colors.black54,
                                imageURL: likeUserModelData.profilePicture!.md!,
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
                likeUserModelData.firstName!.toUpperCase(),
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackBGColor,
                  fontSize: 1.8 * SizeConfig.heightMultiplier,
                ),
              ),
              // Text(
              //   "Female",
              //   style: AppTextStyles.medium.copyWith(
              //     fontWeight: FontWeight.w400,
              //     color: AppColors.lighttextColor,
              //     fontSize: 1.6 * SizeConfig.heightMultiplier,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
