import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/widget/doctor_assistant_detail_container.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAssistantDetailScreen extends StatelessWidget {
  DoctorAssistantDetailScreen({super.key});

  final assistantData = Get.arguments[0] as AssistantElement;
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
            assistantData.assistant!.fullName!,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.doctorAssistantEditProfile),
              child: Text(
                "Edit",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              DoctorAssistantDetailContainer(assistantElement: assistantData),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              _buildAddress(context: context, office: assistantData.office!),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              premissionContainer(context),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/removeAssistant.svg",
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  14.horizontalSpace,
                  Text(
                    "Remove Assistant",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffFF0000),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
            ],
          ),
        ),
      ),
    );
  }

  Container premissionContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 2 * SizeConfig.heightMultiplier,
          horizontal: 5 * SizeConfig.widthMultiplier),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Permissions",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff979797),
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.addIconRound,
                height: 2 * SizeConfig.heightMultiplier,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
              4.horizontalSpace,
              Text(
                "Add Permission",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Container(
            height: 0.5,
            // width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE8E8E8),
                width: .5,
              ),
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          assistantData.permissions.contains("manageAppointments")
              ? Row(
                  children: [
                    SvgPicture.asset(
                      Assets.removeIcon,
                      height: 2.4 * SizeConfig.heightMultiplier,
                    ),
                    14.horizontalSpace,
                    _buldManageAppointmentContainer(
                        "assets/icons/appointmetManage.svg",
                        "Managing Appointments"),
                  ],
                )
              : const SizedBox(),
          assistantData.permissions.contains("manageAppointments")
              ? SizedBox(height: 1 * SizeConfig.heightMultiplier)
              : const SizedBox(),
          assistantData.permissions.contains("managePosts")
              ? Row(
                  children: [
                    SvgPicture.asset(
                      Assets.removeIcon,
                      height: 2.4 * SizeConfig.heightMultiplier,
                    ),
                    14.horizontalSpace,
                    _buldManageAppointmentContainer(
                        "assets/icons/managePost.svg", "Managing Posts"),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Container _buildAddress({
    required BuildContext context,
    required Office office,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 2 * SizeConfig.heightMultiplier,
          horizontal: 5 * SizeConfig.widthMultiplier),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.locationIcon,
                height: 2 * SizeConfig.heightMultiplier,
                colorFilter: const ColorFilter.mode(
                    AppColors.lighttextColor, BlendMode.srcIn),
              ),
              8.horizontalSpace,
              Text(
                "Address",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff979797),
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.editIcon,
                height: 2 * SizeConfig.heightMultiplier,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
              4.horizontalSpace,
              GestureDetector(
                onTap: () => Get.toNamed(Routes.doctorAssistantEditAddress,
                    arguments: {"isEditing": true}),
                child: Text(
                  "Edit Address",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Container(
            height: 0.5,
            // width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE8E8E8),
                width: .5,
              ),
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Text(
            office.description!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
          ),
        ],
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
