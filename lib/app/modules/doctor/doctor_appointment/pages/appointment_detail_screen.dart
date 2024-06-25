import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/border_common_button.dart';
import 'package:hezr/global/widgets/common_button.dart';
import 'package:hezr/global/widgets/toast_message.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBGColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Details",
          style: AppTextStyles.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.blackBGColor,
            fontSize: 2 * SizeConfig.heightMultiplier,
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
                Get.arguments["title"],
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lighttextColor,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 9 * SizeConfig.heightMultiplier,
                    width: 18 * SizeConfig.widthMultiplier,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/images/Rectangle 25.png")),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  6.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Patient Name",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier),
                      Text(
                        "For her mother",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff737373),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 7 * SizeConfig.heightMultiplier,
                        width: 7 * SizeConfig.widthMultiplier,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/icons/messageIcons.svg",
                            colorFilter: const ColorFilter.mode(
                                AppColors.whiteBGColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffC4C4C4).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.verticalSpace,
                    Text(
                      "Schedule Information",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lighttextColor,
                        fontSize: 15,
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 0.4,
                      color: const Color(0xffC4C4C4),
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        20.horizontalSpace,
                        SvgPicture.asset(
                          "assets/icons/clock.svg",
                          height: 20,
                        ),
                        14.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date & Time",
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.lighttextColor,
                                fontSize: 14,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              "Sun, Jan 15, 09.00am - 12.00am",
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Get.arguments["textColor"],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        20.horizontalSpace,
                        SvgPicture.asset(
                          Assets.locationIcon,
                          colorFilter: const ColorFilter.mode(
                              Color(0xff979797), BlendMode.srcIn),
                          height: 20,
                        ),
                        14.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.lighttextColor,
                                fontSize: 14,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              "Sulaymaniyah, Orzdi street,floor ..",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffC4C4C4).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.verticalSpace,
                    Text(
                      "Patient Information",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lighttextColor,
                        fontSize: 15,
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 0.4,
                      color: const Color(0xffC4C4C4),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient name",
                            style: AppTextStyles.medium.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackBGColor,
                              fontSize: 16,
                            ),
                          ),
                          Wrap(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _patientDetailContainer(
                                "assets/icons/offerBookIcon.svg",
                                "My father",
                              ),
                              _patientDetailContainer(
                                "assets/icons/genderIcon.svg",
                                "Male",
                              ),
                              _patientDetailContainer(
                                Assets.calendarIcon,
                                "21 Oct,2002",
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          Text(
                            "Extra Information",
                            style: AppTextStyles.medium.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff898A8D),
                              fontSize: 15,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a form of a   form of a  document ...More",
                            style: AppTextStyles.medium.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.lighttextColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Get.arguments["showButton"]
                  ? CommonButton(
                      ontap: () {
                        showToastMessage(
                            message: "Appointment completed successfully.",
                            context: context,
                            color: const Color(0xff5BA66B),
                            icon: Icons.check);
                      },
                      name: Get.arguments["buttonName"])
                  : const SizedBox(),
              10.verticalSpace,
              Get.arguments["showButton"]
                  ? BorderCommonButton(
                      ontap: () {
                        Get.toNamed(Routes.cancelAppointment);
                      },
                      name: "Cancel")
                  : const SizedBox(),
              14.verticalSpace,
              Get.arguments["isReschedule"]
                  ? Center(
                      child: Text(
                        "Change Schedule?",
                        style: AppTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : const SizedBox(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Container _patientDetailContainer(String icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffC4C4C4).withOpacity(0.15),
          border: Border.all(
              color: const Color(0xffC4C4C4).withOpacity(0.5), width: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 18,
            colorFilter:
                const ColorFilter.mode(Color(0xff979797), BlendMode.srcIn),
          ),
          6.horizontalSpace,
          Text(
            text,
            maxLines: 1,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
