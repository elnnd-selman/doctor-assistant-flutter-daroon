import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/widget/assistant_info_container.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/controller/doctor_assistant_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class DoctorAssistantsScreen extends GetView<DoctorAssistantController> {
  const DoctorAssistantsScreen({super.key});

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
            "My Assistants",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => SearchBarAnimation(
                isOriginalAnimation: false,
                buttonColour: controller.isAppBarOpen.value
                    ? const Color(0xffF7F7F8)
                    : AppColors.whiteBGColor,
                searchBoxColour: const Color(0xffF7F7F8).withOpacity(1),
                isSearchBoxOnRightSide: true,
                enableBoxShadow: false,
                enableButtonShadow: false,
                hintText: "Search Assistants",
                buttonBorderColour: Colors.black45,
                searchBoxWidth: MediaQuery.of(context).size.width * 0.94,
                onFieldSubmitted: (String value) {
                  debugPrint('onFieldSubmitted value $value');
                },
                onPressButton: (open) {
                  controller.isAppBarOpen.value = open;
                },
                textEditingController: TextEditingController(),
                trailingWidget: SvgPicture.asset(
                  Assets.serachIcon,
                  colorFilter: const ColorFilter.mode(
                      Color(0xff979797), BlendMode.srcIn),
                ),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    controller.isSearch.value = true;
                    controller.searchAssitant(val);
                  } else {
                    controller.isSearch.value = false;
                  }
                },
                secondaryButtonWidget: const Icon(Icons.close),
                buttonWidget: SvgPicture.asset(Assets.serachIcon),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              Row(
                children: [
                  Obx(
                    () => Text(
                      controller.isLoading.value
                          ? '--'
                          : controller.assistantModel.value == null
                              ? '0 Assistants'
                              : "${controller.isLoading.value ? '--' : controller.isSearch.value ? controller.assistantSearchList.length : controller.assistantModel.value!.assistants.length} Assistants",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff979797),
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "+ ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      fontSize: 17,
                    ),
                  ),
                  CustomCupertinoButton(
                    onTap: () => Get.toNamed(Routes.adddoctorAssistant),
                    child: Text(
                      "Add Assistant",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              Obx(
                () => controller.isLoading.value
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: 30 * SizeConfig.heightMultiplier),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blackBGColor,
                          ),
                        ),
                      )
                    : controller.isSearch.value
                        ? controller.assistantSearchList.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 30 * SizeConfig.heightMultiplier),
                                child: Text(
                                  "No Assistant found",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBGColor,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    controller.assistantSearchList.length,
                                itemBuilder: (context, index) {
                                  return AssistantInfoContainer(
                                    assistantElement:
                                        controller.assistantSearchList[index],
                                    onTap: () {
                                      Get.toNamed(Routes.doctorAssistantDetail,
                                          arguments: [
                                            controller
                                                .assistantSearchList[index],
                                          ]);
                                    },
                                  );
                                },
                              )
                        : controller.assistantModel.value == null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 30 * SizeConfig.heightMultiplier),
                                child: Text(
                                  "No Assistant available",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBGColor,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : controller
                                    .assistantModel.value!.assistants.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: 30 * SizeConfig.heightMultiplier),
                                    child: Text(
                                      "No Assistant available",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackBGColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.assistantModel.value!
                                        .assistants.length,
                                    itemBuilder: (context, index) {
                                      return AssistantInfoContainer(
                                        assistantElement: controller
                                            .assistantModel
                                            .value!
                                            .assistants[index],
                                        onTap: () {
                                          Get.toNamed(
                                            Routes.doctorAssistantDetail,
                                            arguments: [
                                              controller.assistantModel.value!
                                                  .assistants[index],
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
