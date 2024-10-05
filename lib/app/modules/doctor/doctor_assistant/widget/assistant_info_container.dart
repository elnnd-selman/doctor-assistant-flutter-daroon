import 'package:cached_network_image/cached_network_image.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AssistantInfoContainer extends StatelessWidget {
  final AssistantElement assistantElement;
  final Function()? onTap;
  const AssistantInfoContainer(
      {super.key, required this.assistantElement, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
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
                          shape: BoxShape.circle, color: AppColors.blackBGColor
                          // color: Colors.red,
                          // image: DecorationImage(
                          //   image: AssetImage("assets/images/tempImages.png"),
                          // ),
                          ),
                      child: assistantElement.assistant!.profilePicture == null
                          ? Center(
                              child: FittedBox(
                                child: Text(
                                  '${assistantElement.assistant!.firstName![0].toUpperCase()}${assistantElement.assistant!.lastNameAr![1].toUpperCase()}',
                                  style: AppTextStyles.bold.copyWith(
                                    color: Colors.white,
                                    fontSize: Spaces.fontSize(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: assistantElement
                                  .assistant!.profilePicture!.md!,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: SizeConfig.heightMultiplier * 10,
                                width: SizeConfig.heightMultiplier * 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              height: SizeConfig.heightMultiplier * 10,
                              width: SizeConfig.heightMultiplier * 10,
                              color: AppColors.blackBGColor.withOpacity(0.3),
                              colorBlendMode: BlendMode.darken,
                              errorWidget: (context, url, error) {
                                return Center(
                                  child: FittedBox(
                                    child: Text(
                                      '${assistantElement.assistant!.firstName![0].toUpperCase()}${assistantElement.assistant!.lastNameAr![1].toUpperCase()}',
                                      style: AppTextStyles.bold.copyWith(
                                        color: Colors.white,
                                        fontSize: Spaces.fontSize(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                                // return Padding(
                                //   padding: const EdgeInsets.all(25),
                                //   child: SvgPicture.asset(
                                //     "assets/icons/alert_error.svg",
                                //     colorFilter: ColorFilter.mode(
                                //         Colors.white, BlendMode.srcIn),
                                //   ),
                                // );
                              },
                              placeholder: (context, url) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              },
                              placeholderFadeInDuration: 0.75.seconds,
                            ),
                    )
                  ],
                ),
                SizedBox(width: 4 * SizeConfig.widthMultiplier),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                    SizedBox(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.58,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            assistantElement.assistant!.firstName!,
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
                      assistantElement.assistant!.username!,
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
                assistantElement.permissions.contains("manageAppointments")
                    ? _buldManageAppointmentContainer(
                        "assets/icons/appointmetManage.svg",
                        "Managing Appointments")
                    : const SizedBox(),
                assistantElement.permissions.contains("managePosts")
                    ? _buldManageAppointmentContainer(
                        "assets/icons/postManage.svg", "Managing Posts")
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  checkValueExist() {}

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
