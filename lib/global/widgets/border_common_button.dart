import 'package:flutter/cupertino.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class BorderCommonButton extends StatelessWidget {
  final VoidCallback ontap;
  final String name;
  const BorderCommonButton(
      {super.key, required this.ontap, required this.name});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: ontap,
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        decoration: BoxDecoration(
          // color: AppColors.primaryColor,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name,
            style: AppTextStyles.bold.copyWith(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
