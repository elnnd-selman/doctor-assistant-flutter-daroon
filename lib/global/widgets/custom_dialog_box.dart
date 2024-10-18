import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? iconPath;
  final String? cancelButtonText;
  final Color? cancelButtonColor;
  final Color? confirmButtonColor;
  final String? confirmButtonText;
  final Function()? onPressedCancel;
  final Function() onPressedConfirm;
  final bool? isloading;

  const CustomDialogBox({
    super.key,
    required this.title,
    this.iconPath = Assets.infoIcon,
    this.onPressedCancel,
    required this.onPressedConfirm,
    required this.subTitle,
    this.cancelButtonColor,
    this.confirmButtonColor,
    this.cancelButtonText,
    this.confirmButtonText,
    this.isloading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          SvgPicture.asset(
            iconPath!,
          ),
          10.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bold.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.verticalSpace,
        ],
      ),
      content: Text(
        subTitle,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xff979797),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedCancel ?? () => Get.back(),
          child: Text(
            cancelButtonText ?? 'Cancel',
            style: AppTextStyles.bold.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cancelButtonColor ?? const Color(0xff717171),
            ),
          ),
        ),
        TextButton(
          onPressed: onPressedConfirm,
          child: Text(
            confirmButtonText ?? 'Yes !',
            style: AppTextStyles.bold.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: confirmButtonColor ?? AppColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
