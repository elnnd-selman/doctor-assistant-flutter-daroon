import 'package:cached_network_image/cached_network_image.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/global/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:get/get.dart';

class DoctorAssistantDetailContainer extends StatelessWidget {
  final AssistantElement assistantElement;
  const DoctorAssistantDetailContainer(
      {super.key, required this.assistantElement});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 5 * SizeConfig.widthMultiplier),
            margin: EdgeInsets.only(top: 5.5 * SizeConfig.heightMultiplier),
            // height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color(0xffF2F8FF),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.only(top: 8 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    assistantElement.assistant!.fullName!,
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackBGColor,
                      fontSize: 2 * SizeConfig.heightMultiplier,
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
                  _buildAssistantContainer(
                      context: context,
                      title: "Gender",
                      subtitle:
                          assistantElement.assistant!.gender!.toUpperCase()),
                  _buildAssistantContainer(
                      context: context,
                      title: "Phone Number",
                      subtitle: assistantElement.assistant!.phone!.number!),
                  _buildAssistantContainer(
                      context: context,
                      title: "Email",
                      subtitle: assistantElement.assistant!.email!),
                  SizedBox(height: 2.5 * SizeConfig.heightMultiplier)
                ],
              ),
            ),
          ),
          // Center(
          //   child: Container(
          //     height: SizeConfig.heightMultiplier * 12,
          //     width: SizeConfig.heightMultiplier * 12,
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         // color: Colors.red,
          //         image: DecorationImage(
          //           image: AssetImage("assets/images/tempImages.png"),
          //         )),
          //   ),
          // ),
          Center(
            child: Container(
              height: SizeConfig.heightMultiplier * 12,
              width: SizeConfig.heightMultiplier * 12,
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
                          '${assistantElement.assistant!.name![0].toUpperCase()}${assistantElement.assistant!.fullName![1].toUpperCase()}',
                          style: AppTextStyles.bold.copyWith(
                            color: Colors.white,
                            fontSize: Spaces.fontSize(fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: assistantElement.assistant!.profilePicture!.md!,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        height: SizeConfig.heightMultiplier * 12,
                        width: SizeConfig.heightMultiplier * 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      height: SizeConfig.heightMultiplier * 12,
                      width: SizeConfig.heightMultiplier * 12,
                      color: AppColors.blackBGColor.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                      errorWidget: (context, url, error) {
                        return Center(
                          child: FittedBox(
                            child: Text(
                              '${assistantElement.assistant!.name![0].toUpperCase()}${assistantElement.assistant!.fullName![1].toUpperCase()}',
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
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAssistantContainer({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5 * SizeConfig.heightMultiplier),
      padding: EdgeInsets.symmetric(
          horizontal: 4 * SizeConfig.widthMultiplier,
          vertical: 1.5 * SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.whiteBGColor,
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.lighttextColor,
                fontSize: 1.7 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
          Text(
            subtitle,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blackBGColor,
              fontSize: 1.7 * SizeConfig.heightMultiplier,
            ),
          ),
        ],
      ),
    );
  }
}
