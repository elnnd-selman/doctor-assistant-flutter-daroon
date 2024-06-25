import 'package:flutter/material.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

class EditAssistantProfile extends StatelessWidget {
  const EditAssistantProfile({super.key});

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
            "Edit Assistant",
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
            child: Text(
              "Save",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                fontSize: 1.4 * SizeConfig.heightMultiplier,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              Center(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 12 * SizeConfig.heightMultiplier,
                      width: 12 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.17),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/tempImages.png"),
                          )),
                      // child: Obx(
                      //   () => controller.isNoPhoto.value
                      //       ? Padding(
                      //           padding: const EdgeInsets.all(50),
                      //           child: Image.asset(
                      //             "assets/images/noProfile.png",
                      //           ),
                      //         )
                      //       : Padding(
                      //           padding: const EdgeInsets.all(25),
                      //           child: Image.file(
                      //             File(controller.selectedimageName!.value),
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      // ),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 8,
                      child: Container(
                        alignment: Alignment.center,
                        height: 3 * SizeConfig.heightMultiplier,
                        width: 3 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            border: Border.all(
                                color: AppColors.whiteBGColor, width: 2.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.edit,
                            color: AppColors.whiteBGColor,
                            size: 1.5 * SizeConfig.heightMultiplier,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              _profileTextField(
                  context: context,
                  title: "Name",
                  subtitle: "Elnnd selman",
                  showIcon: false,
                  hintText: "UserName"),
              SizedBox(height: 6 * SizeConfig.heightMultiplier),
              Text(
                "Private Information",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff11142D),
                  fontSize: 2 * SizeConfig.heightMultiplier,
                ),
              ),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              _profileTextField(
                  context: context,
                  title: "Email",
                  subtitle: "saki@momento.network",
                  showIcon: false,
                  hintText: "Email"),
              SizedBox(height: 1 * SizeConfig.heightMultiplier),
              _profileTextField(
                  context: context,
                  title: "Phone",
                  subtitle: "+964 770 687 2770",
                  showIcon: false,
                  hintText: "Phone"),
              SizedBox(height: 1 * SizeConfig.heightMultiplier),
              _profileTextField(
                  context: context,
                  title: "Username",
                  subtitle: "Saki",
                  showIcon: false,
                  hintText: "Username"),
              SizedBox(height: 1 * SizeConfig.heightMultiplier),
              _profileTextField(
                  context: context,
                  title: "Gender",
                  subtitle: "Female",
                  showIcon: true,
                  hintText: "Gender"),
            ],
          ),
        ),
      ),
    );
  }

  Row _profileTextField({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String hintText,
    required bool showIcon,
  }) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            title,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xff707281),
              fontSize: 1.8 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xff11142D),
            ),
            initialValue: subtitle,
            cursorColor: AppColors.blackBGColor,
            // cursorHeight: 10,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              fillColor: AppColors.whiteBGColor,
              filled: true,
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              suffixIcon: showIcon
                  ? const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryColor,
                      size: 18,
                    )
                  : const SizedBox(),
              isDense: true,
              hintText: hintText,
              hintStyle: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xffA0A1AB),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
