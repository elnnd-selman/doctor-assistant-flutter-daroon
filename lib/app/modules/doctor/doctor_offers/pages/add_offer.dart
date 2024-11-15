import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/add_offer_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/widget/image_video_pick.dart';
import 'package:daroon_doctor/global/utils/timestamp_extention.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/widget/date_picker.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/auth_text_field.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:get/get.dart';

class DoctorAddOfferScreen extends GetView<AddOfferController> {
  const DoctorAddOfferScreen({super.key});

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
            "Add Offer",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Text(
                "You can add new offer, to do that complete the following requirements.",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lighttextColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              Text(
                "Offers Detail",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lighttextColor,
                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                ),
              ),
              10.verticalSpace,
              CupertinoButton(
                pressedOpacity: 0,
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: () => addOfferPhoto(context),
                child: Obx(
                  () => Container(
                      height: 20 * SizeConfig.heightMultiplier,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffF7F7F8),
                        image: controller.imageUrl.value == ''
                            ? null
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(controller.imageUrl.value),
                                )),
                        border: Border.all(
                          color: const Color(0xffE7E8EA),
                        ),
                      ),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.imageUrl.value == ""
                                ? SvgPicture.asset("assets/icons/gallery.svg")
                                : const SizedBox(),
                            controller.imageUrl.value == ""
                                ? 10.verticalSpace
                                : const SizedBox(),
                            controller.imageUrl.value == ""
                                ? Text(
                                    "Choose image",
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.lighttextColor,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      )),
                ),
              ),
              16.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Title-Ku",
                controller: controller.titleKu,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Title-Ku";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Title-En",
                controller: controller.titleEn,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Title";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Title-Ar",
                controller: controller.titleAR,
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Title";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildTimeContainer(
                        title: controller.startTime.value == null
                            ? "Start with"
                            : controller
                                .formatDate(controller.startTime.value!),
                        ontap: () async {
                          FocusScope.of(context).unfocus();
                          final Timestamp pickDate =
                              await showModalBottomSheet<dynamic>(
                            context: context,
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(
                              context,
                            ).size.width),
                            builder: (context) => const DcotorOfferDateTime(),
                            isScrollControlled: true,
                          );
                          controller.startTime.value =
                              pickDate.timeStampToDateTime;
                        },
                      ),
                    ),
                    SizedBox(width: 3 * SizeConfig.widthMultiplier),
                    Expanded(
                      child: _buildTimeContainer(
                        title: controller.endTime.value == null
                            ? "End with"
                            : controller.formatDate(controller.endTime.value!),
                        ontap: () async {
                          FocusScope.of(context).unfocus();
                          final Timestamp pickDate =
                              await showModalBottomSheet<dynamic>(
                            context: context,
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(
                              context,
                            ).size.width),
                            builder: (context) => const DcotorOfferDateTime(),
                            isScrollControlled: true,
                          );
                          controller.endTime.value =
                              pickDate.timeStampToDateTime;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CommonTextfeild(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "Current price",
                      controller: controller.currentPrice,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Current price";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 3 * SizeConfig.widthMultiplier),
                  Expanded(
                    child: CommonTextfeild(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "Discount percentage",
                      controller: controller.discountPrice,
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Discount percentage";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              CommonTextfeild(
                maxLine: 2,
                scanIcons: false,
                obscuretext: false,
                hinttext: "Description-KU",
                controller: controller.descriptionKu,
                keyboardType: TextInputType.name,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Description";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonTextfeild(
                maxLine: 2,
                scanIcons: false,
                obscuretext: false,
                hinttext: "Description-EN",
                controller: controller.descriptionEN,
                keyboardType: TextInputType.name,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Description";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonTextfeild(
                maxLine: 2,
                scanIcons: false,
                obscuretext: false,
                hinttext: "Description-AR",
                controller: controller.descriptionAR,
                keyboardType: TextInputType.name,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Description";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonButton(
                  ontap: () {
                    controller.checkValidation(context);
                  },
                  name: "Next"),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  CustomCupertinoButton _buildTimeContainer({
    required String title,
    required Function()? ontap,
  }) {
    return CustomCupertinoButton(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF7F7F8),
          border: Border.all(
            color: const Color(0xffE7E8EA),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.calendarIcon,
              height: 2 * SizeConfig.heightMultiplier,
            ),
            SizedBox(width: 2 * SizeConfig.widthMultiplier),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.heightMultiplier * 1.5,
                  color: const Color(0xff535353),
                ),
              ),
            ),
            const Spacer(),
            SvgPicture.asset("assets/icons/downIcon.svg"),
          ],
        ),
      ),
    );
  }
}
