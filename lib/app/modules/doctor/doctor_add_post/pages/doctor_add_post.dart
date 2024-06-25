import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_add_post/controller/doctor_add_post_controller.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';

class DoctorAddPostScreen extends GetView<DoctorAddPostController> {
  const DoctorAddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 4 * SizeConfig.widthMultiplier,
          vertical: 3 * SizeConfig.heightMultiplier),
      child: Column(
        children: [
          CommonTextfeild(
            scanIcons: false,
            obscuretext: false,
            borderColor: Colors.transparent,
            maxLine: 4,
            hinttext: "Share your thoughts...",
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
            showicon: false,
            validations: (value) {
              if (value!.isEmpty) {
                return "Enter Password";
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
              // shape: BoxShape.circle,
              color: const Color(0xffF7F7F8),
            ),
            child: Obx(
              () => controller.isNoPhoto.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/gallery.svg"),
                        10.verticalSpace,
                        Text(
                          "Choose image",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.lighttextColor,
                            fontSize: 1.5 * SizeConfig.heightMultiplier,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image.file(
                        File(controller.selectedimageName!.value),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () => addPhoto(context),
                child: SvgPicture.asset(
                  Assets.gallery,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
              ),
              10.horizontalSpace,
              SvgPicture.asset(
                Assets.cameraIcon,
                height: 20,
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
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
            ],
          ),
          SizedBox(height: 7 * SizeConfig.heightMultiplier),
        ],
      ),
    );
  }

  Future<void> addPhoto(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                controller.getGalleryImage();
                Navigator.pop(context);
              },
              child: Text('Gallery Image',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    // fontFamily: ksecondaryFontFamily,
                    color: AppColors.blackBGColor,
                  )),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                controller.getCameraImage();
                Navigator.pop(context);
              },
              child: Text('Camera Image',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    // fontFamily: ksecondaryFontFamily,
                    color: AppColors.blackBGColor,
                  )),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  // fontFamily: ksecondaryFontFamily,
                  color: AppColors.blackBGColor,
                )),
          ),
        );
      },
    );
  }
}
