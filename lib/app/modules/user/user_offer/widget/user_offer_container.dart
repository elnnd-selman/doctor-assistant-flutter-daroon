import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';
import 'package:hezr/global/widgets/common_button.dart';

class UserOfferContainer extends StatelessWidget {
  const UserOfferContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.userOffersDetails),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffE8E8E8),
              width: 0.5,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 24 * SizeConfig.heightMultiplier,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/circlurDot.png"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Stack(
                  children: [
                    Positioned(
                      top: 2 * SizeConfig.heightMultiplier,
                      right: 14,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: AppColors.whiteBGColor.withOpacity(0.43),
                            shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.whiteBGColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2 * SizeConfig.heightMultiplier,
                      left: 14,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              width: 5 * SizeConfig.heightMultiplier,
                              decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tempImages.png"),
                                  ),
                                  shape: BoxShape.circle),
                            ),
                            10.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. Doctor Name",
                                  style: AppTextStyles.medium.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteBGColor,
                                    fontSize: SizeConfig.heightMultiplier * 1.7,
                                  ),
                                ),
                                Text(
                                  "Specialist",
                                  style: AppTextStyles.medium.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteBGColor,
                                    fontSize: SizeConfig.heightMultiplier * 1.5,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2 * SizeConfig.heightMultiplier,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 14),
                        // height: 7 * SizeConfig.heightMultiplier,
                        // width: 7 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.88),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20))
                            // shape: BoxShape.circle,
                            ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/offerBookIcon.svg",
                                height: 14),
                            10.horizontalSpace,
                            Text("Booked 30+ times",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackBGColor,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offer Title",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackBGColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "In publishing and graphic design...",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyBGColor.withOpacity(0.6),
                      fontSize: 15,
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 0.2,
                    color: const Color(0xffC4C4C4),
                  ),
                  4.verticalSpace,
                  Wrap(
                    children: [
                      _moreOfferContainer(
                          "assets/icons/calendar.svg",
                          "• 31 Oct - 15 Nov",
                          AppColors.primaryColor,
                          MediaQuery.of(context).size.width * 0.47),
                      5.horizontalSpace,
                      _moreOfferContainer(
                          "assets/icons/key.svg",
                          "• 12BC4",
                          AppColors.primaryColor,
                          MediaQuery.of(context).size.width * 0.35),
                      _moreOfferContainer(
                          "assets/icons/newoffer.svg",
                          "• 40% Off",
                          Colors.red,
                          MediaQuery.of(context).size.width * 0.35),
                    ],
                  ),
                  4.verticalSpace,
                  CommonButton(ontap: () {}, name: "Book")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _moreOfferContainer(
      String icon, String text, Color color, double width) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 10),
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffC4C4C4).withOpacity(0.15),
          border: Border.all(
              color: const Color(0xffC4C4C4).withOpacity(0.5), width: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 18,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          6.horizontalSpace,
          Text(
            text,
            maxLines: 1,
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w400,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
