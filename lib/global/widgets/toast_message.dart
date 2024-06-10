import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

showToastMessage({
  required String message,
  required BuildContext context,
}) {
  FToast().init(context);
  FToast().showToast(
    child: Container(
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteBGColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 5 * SizeConfig.heightMultiplier,
            width: 10 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
              color: const Color(0xff5BA66B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3 * SizeConfig.heightMultiplier,
                  width: 3 * SizeConfig.heightMultiplier,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteBGColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Color(0xff5BA66B),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Text(
            message,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blackBGColor,
              fontSize: 14,
            ),
          )
        ],
      ),
    ),
    gravity: ToastGravity.TOP,
  );
}
