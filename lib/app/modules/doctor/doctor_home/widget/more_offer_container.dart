import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

class MoreOfferContainer extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  const MoreOfferContainer(
      {super.key, required this.statusColor, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    top: 0,
                    right: 14,
                    child: Container(
                      height: 7 * SizeConfig.heightMultiplier,
                      width: 7 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF).withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: SvgPicture.asset("assets/icons/circlurDot.svg"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2 * SizeConfig.heightMultiplier,
                    left: 14,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 14),
                        // height: 7 * SizeConfig.heightMultiplier,
                        // width: 7 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(20)
                            // shape: BoxShape.circle,
                            ),
                        child: Row(
                          children: [
                            Text("• $statusText",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteBGColor,
                                  fontSize: 12,
                                )),
                          ],
                        )),
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
                        )),
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
                12.verticalSpace,
              ],
            ),
          ),
        ],
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
