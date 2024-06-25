import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

class CustomOptionalToggleButton extends StatelessWidget {
  const CustomOptionalToggleButton({
    super.key,
    this.leftText = 'Option 0',
    this.centreText = 'Option 1',
    this.rightText = 'Option 2',
    required this.value,
    required this.onValueChange,
    this.blackWidth,
  });

  final int value;
  final String leftText;
  final String rightText;
  final String centreText;
  final ValueChanged<int> onValueChange;
  final double? blackWidth;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(Get.context!).size.width -
        SizeConfig.widthMultiplier * 35;
    final widgetWidth = deviceWidth - 40;
    final capsuleWidth = widgetWidth * 0.33;
    return SizedBox(
      height: 5 * SizeConfig.heightMultiplier,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: SizeConfig.heightMultiplier * 5,
            width: widgetWidth,
            decoration: BoxDecoration(
              color: const Color(0xff979797).withOpacity(0.08),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            // top: 3,
            left: value == 0
                ? 0
                : value == 1
                    ? deviceWidth * SizeConfig.widthMultiplier * 0.4 -
                        capsuleWidth * SizeConfig.widthMultiplier * 0.18
                    : null,
            right: value == 2 ? 0 : null,
            child: Container(
              width: capsuleWidth,
              height: SizeConfig.heightMultiplier * 5,
              decoration: BoxDecoration(
                // color: AppColors.blackBGColor,
                border: Border.all(
                    color: const Color(0xffC4C4C4).withOpacity(.5), width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
              ),
            ),
          ),
          SizedBox(
            width: widgetWidth,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onValueChange(0),
                    child: Center(
                      child: Text(
                        leftText,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 1.4 * SizeConfig.heightMultiplier,
                          color: value == 0
                              ? AppColors.blackBGColor
                              : const Color(0xff979797),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onValueChange(1),
                    child: Text(
                      centreText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.semiBold.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 1.4 * SizeConfig.heightMultiplier,
                        color: value == 1
                            ? AppColors.blackBGColor
                            : const Color(0xff979797),
                      ),
                    ),
                  ),
                ),
                // .horizontalSpace,
                Expanded(
                  child: GestureDetector(
                    onTap: () => onValueChange(2),
                    child: Center(
                      child: Text(
                        rightText,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 1.4 * SizeConfig.heightMultiplier,
                          color: value == 2
                              ? AppColors.blackBGColor
                              : const Color(0xff979797),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
