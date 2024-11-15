import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_add_post/controller/doctor_update_post_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_add_post/widget/update_post_image.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DoctorUpdatePost extends GetView<DoctorUpdatePostController> {
  DoctorUpdatePost({super.key});

  final postData = Get.arguments[0] as ContentData;
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorUpdatePostController>(
      initState: (_) {
        controller.setEditPostData(postData);
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: IconButton(
                onPressed: () {
                  Get.dialog(CustomDialogBox(
                    title: "Edit Post",
                    subTitle: "Do you want to discard the change?",
                    cancelButtonText: "Discard",
                    confirmButtonText: "Continue",
                    onPressedCancel: () {
                      Get.back();
                      Get.back();
                    },
                    onPressedConfirm: () {
                      Get.back();
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (form.currentState!.validate()) {
                        controller.updateContantPost(context);
                      }
                    },
                  ));
                },
                icon: const Icon(Icons.arrow_back)),
            title: Row(
              children: [
                Get.find<DoctorHomeController>()
                            .userModel
                            .value!
                            .user!
                            .profilePicture ==
                        null
                    ? Container(
                        height: 4 * SizeConfig.heightMultiplier,
                        width: 4 * SizeConfig.heightMultiplier,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: AppColors.blackBGColor,
                            shape: BoxShape.circle),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              '${Get.find<DoctorHomeController>().userModel.value!.user!.username![0].toUpperCase()}${Get.find<DoctorHomeController>().userModel.value!.user!.firstName![0].toUpperCase()}',
                              style: AppTextStyles.bold.copyWith(
                                color: Colors.white,
                                fontSize: Spaces.fontSize(fontSize: 18),
                              ),
                            ),
                          ),
                        ))
                    : CircleAvatar(
                        radius: 14,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: Get.find<DoctorHomeController>()
                                .userModel
                                .value!
                                .user!
                                .profilePicture,
                            fit: BoxFit.cover,
                            height: 4 * SizeConfig.heightMultiplier,
                            width: 4 * SizeConfig.heightMultiplier,
                          ),
                        ),
                      ),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Get.find<DoctorHomeController>()
                          .userModel
                          .value!
                          .user!
                          .username!,
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackBGColor,
                        fontSize: SizeConfig.heightMultiplier * 1.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4 * SizeConfig.widthMultiplier,
                      vertical: 3 * SizeConfig.heightMultiplier),
                  child: Form(
                    key: form,
                    child: Column(
                      children: [
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 1,
                          hinttext: "Title-Ku",
                          controller: controller.titleKU,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title-ku";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 1,
                          hinttext: "Title-En",
                          controller: controller.titleEN,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title-En";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 1,
                          hinttext: "Title-Ar",
                          controller: controller.titleAR,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title-Ar";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 3,
                          hinttext: "Share your thoughts in Ku...",
                          controller: controller.descKU,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 3,
                          hinttext: "Share your thoughts in En...",
                          controller: controller.descEN,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                        CommonTextfeild(
                          scanIcons: false,
                          obscuretext: false,
                          borderColor: Colors.transparent,
                          maxLine: 3,
                          hinttext: "Share your thoughts in Ar...",
                          controller: controller.descAR,
                          keyboardType: TextInputType.emailAddress,
                          showicon: false,
                          validations: (value) {
                            if (value!.isEmpty) {
                              return "Enter Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 4 * SizeConfig.heightMultiplier),
                        Container(
                          alignment: Alignment.center,
                          height: 25 * SizeConfig.heightMultiplier,
                          width: 100 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffF7F7F8),
                          ),
                          child: Obx(
                            () => controller.imageList.isEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/gallery.svg"),
                                      10.verticalSpace,
                                      Text(
                                        "Choose image",
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lighttextColor,
                                          fontSize:
                                              1.5 * SizeConfig.heightMultiplier,
                                        ),
                                      ),
                                    ],
                                  )
                                : GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 18,
                                      childAspectRatio: 0.75,
                                    ),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    itemCount: controller.imageList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(controller
                                                    .imageList[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: CupertinoButton(
                                                pressedOpacity: 0,
                                                padding: EdgeInsets.zero,
                                                minSize: 0,
                                                onPressed: () => controller
                                                    .removeImage(index),
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .blackBGColor
                                                          .withOpacity(.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color:
                                                        AppColors.whiteBGColor,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        SizedBox(height: 4 * SizeConfig.heightMultiplier),
                        Container(
                          alignment: Alignment.center,
                          height: 25 * SizeConfig.heightMultiplier,
                          width: 100 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffF7F7F8),
                          ),
                          child: Obx(
                            () => controller.videoList.isEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/gallery.svg"),
                                      10.verticalSpace,
                                      Text(
                                        "Choose video",
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lighttextColor,
                                          fontSize:
                                              1.5 * SizeConfig.heightMultiplier,
                                        ),
                                      ),
                                    ],
                                  )
                                : GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 18,
                                      childAspectRatio: 0.75,
                                    ),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    itemCount: controller.videoList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            SvgPicture.asset(
                                              Assets.videoIcon,
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: CupertinoButton(
                                                pressedOpacity: 0,
                                                padding: EdgeInsets.zero,
                                                minSize: 0,
                                                onPressed: () => controller
                                                    .removeVideo(index),
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .blackBGColor
                                                          .withOpacity(.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color:
                                                        AppColors.whiteBGColor,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        SizedBox(height: 6 * SizeConfig.heightMultiplier),
                        Row(
                          children: [
                            CupertinoButton(
                              pressedOpacity: 0,
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                updatePostPhoto(context);
                              },
                              child: SvgPicture.asset(
                                Assets.gallery,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.primaryColor, BlendMode.srcIn),
                              ),
                            ),
                            10.horizontalSpace,
                            CupertinoButton(
                              pressedOpacity: 0,
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                updatePostVideo(context);
                              },
                              child: SvgPicture.asset(
                                Assets.cameraIcon,
                                height: 20,
                              ),
                            ),
                            const Spacer(),
                            CupertinoButton(
                              pressedOpacity: 0,
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () {
                                if (form.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.updateContantPost(context);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: AppTextStyles.bold.copyWith(
                                      fontSize: 16,
                                      color: AppColors.whiteBGColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3 * SizeConfig.heightMultiplier),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (controller.processing) {
                  return const LoadingOverlay();
                }
                return const SizedBox();
              }),
            ],
          ),
        );
      },
    );
  }
}
