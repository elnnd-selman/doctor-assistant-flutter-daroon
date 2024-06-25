import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hezr/app/modules/doctor/doctor_assistant/controller/doctor_assistant_controller.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class DoctorAssistantsScreen extends GetView<DoctorAssistantController> {
  const DoctorAssistantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBGColor,
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
        child: Column(
          children: [
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            Row(
              children: [
                Text(
                  "4 Assistants",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff979797),
                    fontSize: 17,
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
                GestureDetector(
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
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.doctorAssistantDetail);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 3 * SizeConfig.widthMultiplier,
                    vertical: 2 * SizeConfig.heightMultiplier),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xffE8E8E8),
                    width: .5,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 10,
                              width: SizeConfig.heightMultiplier * 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.red,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tempImages.png"),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(width: 2 * SizeConfig.widthMultiplier),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 2 * SizeConfig.heightMultiplier),
                            SizedBox(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.58,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Assistant Name",
                                    style: AppTextStyles.medium.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackBGColor,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffe3f0ff),
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "@Username",
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.lighttextColor,
                                fontSize: 1.5 * SizeConfig.heightMultiplier,
                              ),
                            ),
                            SizedBox(height: 2 * SizeConfig.heightMultiplier),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width * 0.58,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffE8E8E8),
                                  width: .5,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                    Wrap(
                      children: [
                        _buldManageAppointmentContainer(
                            "assets/icons/appointmetManage.svg",
                            "Managing Appointments"),
                        _buldManageAppointmentContainer(
                            "assets/icons/postManage.svg", "Managing Posts"),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buldManageAppointmentContainer(String icon, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: .5 * SizeConfig.heightMultiplier),
      padding: EdgeInsets.symmetric(
          vertical: 1 * SizeConfig.heightMultiplier,
          horizontal: 3 * SizeConfig.widthMultiplier),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor.withOpacity(0.05),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 2 * SizeConfig.heightMultiplier,
            width: 2 * SizeConfig.widthMultiplier,
          ),
          SizedBox(width: 2 * SizeConfig.widthMultiplier),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
              fontSize: 1.5 * SizeConfig.heightMultiplier,
            ),
          ),
        ],
      ),
    );
  }
}
