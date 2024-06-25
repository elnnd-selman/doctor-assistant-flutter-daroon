import 'package:flutter/material.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

class DoctorEditSpeciality extends StatelessWidget {
  const DoctorEditSpeciality({super.key});

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
            "Edit speciality",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    );
  }
}
