import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hezr/app/modules/doctor/doctor_offers/widget/date_picker.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/auth_text_field.dart';
import 'package:hezr/global/widgets/common_button.dart';

class DoctorAddOfferScreen extends StatelessWidget {
  const DoctorAddOfferScreen({super.key});

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
            "Add Offer",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
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
                "You can add new offer, to do that complete the following requirements.",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lighttextColor,
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
              Text(
                "Offers Detail",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lighttextColor,
                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                ),
              ),
              10.verticalSpace,
              Container(
                height: 20 * SizeConfig.heightMultiplier,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffF7F7F8),
                  border: Border.all(
                    color: const Color(0xffE7E8EA),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/gallery.svg"),
                    10.verticalSpace,
                    Text(
                      "Choose image",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.lighttextColor,
                        fontSize: 1.5 * SizeConfig.heightMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              CommonTextfeild(
                scanIcons: false,
                obscuretext: false,
                hinttext: "Title..",
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Title";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: _buildTimeContainer(
                        title: "Start with",
                        ontap: () async {
                          await showModalBottomSheet<dynamic>(
                            context: context,
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(
                              context,
                            ).size.width),
                            builder: (context) => const DcotorOfferDateTime(),
                            isScrollControlled: true,
                          );
                        }),
                  ),
                  SizedBox(width: 3 * SizeConfig.widthMultiplier),
                  Expanded(
                    child: _buildTimeContainer(title: "End with", ontap: () {}),
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CommonTextfeild(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "Current price",
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Current price";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 3 * SizeConfig.widthMultiplier),
                  Expanded(
                    child: CommonTextfeild(
                      scanIcons: false,
                      obscuretext: false,
                      hinttext: "Discount percentage",
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      showicon: false,
                      validations: (value) {
                        if (value!.isEmpty) {
                          return "Enter Discount percentage";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              CommonTextfeild(
                maxLine: 5,
                scanIcons: false,
                obscuretext: false,
                hinttext: "Description...",
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                showicon: false,
                validations: (value) {
                  if (value!.isEmpty) {
                    return "Enter Description";
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              CommonButton(ontap: () {}, name: "Next"),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildTimeContainer({
    required String title,
    required Function()? ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF7F7F8),
          border: Border.all(
            color: const Color(0xffE7E8EA),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.calendarIcon,
              height: 2 * SizeConfig.heightMultiplier,
            ),
            SizedBox(width: 2 * SizeConfig.widthMultiplier),
            Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.heightMultiplier * 1.5,
                color: const Color(0xff535353),
              ),
            ),
            const Spacer(),
            SvgPicture.asset("assets/icons/downIcon.svg"),
          ],
        ),
      ),
    );
  }
}
