import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/model/doctor_offer_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorOfferDetailScreen extends StatelessWidget {
  DoctorOfferDetailScreen({super.key});

  final offerData = Get.arguments[0] as DoctorOffersData;

  final Color statusColor = Get.arguments[1] as Color;
  final String statusText = Get.arguments[2] as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: AssetImage("assets/images/temp1.png"),
                    // ),
                  ),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 5 * SizeConfig.heightMultiplier),
                      NetWorkImageLoader(
                          imageURL: offerData.image!.bg!,
                          height: MediaQuery.of(context).size.height * 0.45,
                          boxFit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5 * SizeConfig.heightMultiplier,
                            horizontal: 4 * SizeConfig.widthMultiplier),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColors.whiteBGColor,
                              ),
                            ),
                            Text(
                              "My Offers",
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteBGColor,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                              ),
                            ),
                            _buildMenu(context),
                            // Container(
                            //   height: 7 * SizeConfig.heightMultiplier,
                            //   width: 7 * SizeConfig.widthMultiplier,
                            //   decoration: const BoxDecoration(
                            //     color: Color(0xffFFFFFF),
                            //     shape: BoxShape.circle,
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(5),
                            //     child: SvgPicture.asset(
                            //       "assets/icons/circlurDot.svg",
                            //       colorFilter: const ColorFilter.mode(
                            //           AppColors.primaryColor, BlendMode.srcIn),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.widthMultiplier,
                              top: 13 * SizeConfig.heightMultiplier),
                          width: 24 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("• $statusText",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteBGColor,
                                    fontSize: 12,
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .54,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8 * SizeConfig.widthMultiplier),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6 * SizeConfig.heightMultiplier),
                            Text(
                              offerData.titleEn!,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackBGColor,
                                fontSize: SizeConfig.heightMultiplier * 2.4,
                              ),
                            ),
                            SizedBox(height: 1 * SizeConfig.heightMultiplier),
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
                                    "• ${offerData.discountPercentage}% Off",
                                    Colors.red,
                                    MediaQuery.of(context).size.width * 0.35),
                              ],
                            ),
                            SizedBox(height: 3 * SizeConfig.heightMultiplier),
                            Container(
                              height: 0.5,
                              color: const Color(0xffC4C4C4),
                            ),
                            SizedBox(height: 3 * SizeConfig.heightMultiplier),
                            Text(
                              offerData.descriptionEn!,
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff484848),
                                fontSize: SizeConfig.heightMultiplier * 1.6,
                              ),
                            ),
                            SizedBox(height: 3 * SizeConfig.heightMultiplier),
                            Container(
                              height: 0.5,
                              color: const Color(0xffC4C4C4),
                            ),
                            SizedBox(height: 3 * SizeConfig.heightMultiplier),
                            Text(
                              'Available addresses',
                              style: AppTextStyles.medium.copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff898A8D),
                                fontSize: SizeConfig.heightMultiplier * 2,
                              ),
                            ),
                            SizedBox(height: 2 * SizeConfig.heightMultiplier),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2 * SizeConfig.heightMultiplier,
                                  horizontal: 5 * SizeConfig.widthMultiplier),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xffE8E8E8),
                                      width: 0.5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 12,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff6FCF84)),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        "${offerData.office!.daysOpen.length} days per week",
                                        style: AppTextStyles.medium.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff898A8D),
                                          fontSize:
                                              1.4 * SizeConfig.heightMultiplier,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 2 * SizeConfig.heightMultiplier),
                                  Container(
                                    height: 0.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffE8E8E8),
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 2 * SizeConfig.heightMultiplier),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 42,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: AppColors.primaryColor,
                                              border: Border.all(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                Assets.locationIcon,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        AppColors.whiteBGColor,
                                                        BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          width:
                                              2 * SizeConfig.heightMultiplier),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                              offerData.office!.description!,
                                              maxLines: 2,
                                              style:
                                                  AppTextStyles.black.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blackBGColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 3 * SizeConfig.heightMultiplier),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .387,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColor,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ph_user.svg",
                          height: 20,
                          width: 20,
                        ),
                        10.horizontalSpace,
                        Text(
                          "Booked 30+ times",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteBGColor,
                            fontSize: 1.4 * SizeConfig.heightMultiplier,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (Get.find<DoctorOffersController>().deleteLoader.value) {
              return const LoadingOverlay();
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  _buildMenu(BuildContext context) {
    return CustomPopupMenu(
      arrowColor: Colors.white,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Get.find<DoctorOffersController>()
                  .menuList
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.find<DoctorOffersController>()
                            .controller
                            .hideMenu();

                        if (item == "Delete") {
                          Get.dialog(
                            CustomDialogBox(
                              title: 'Delete Offer',
                              iconPath: Assets.deleteIcon,
                              onPressedConfirm: () {
                                Get.back();
                                Get.find<DoctorOffersController>().deleteOffer(
                                    data: offerData, context: context);
                              },
                              confirmButtonColor: const Color(0xffEC1C24),
                              subTitle:
                                  'Are you sure you want to\ndelete ${offerData.titleEn} ?',
                            ),
                            barrierColor:
                                AppColors.blackBGColor.withOpacity(0.5),
                          );
                        } else {
                          Get.toNamed(Routes.doctorEditOffers, arguments: [
                            offerData,
                          ]);
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: item == "Edit"
                                            ? Colors.black
                                            : const Color(0xffEC1C24)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          item == "Edit"
                              ? Container(
                                  height: .5,
                                  color: const Color(0xffC4C4C4),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: Get.find<DoctorOffersController>().controller,
      child: Container(
        height: 7 * SizeConfig.heightMultiplier,
        width: 7 * SizeConfig.widthMultiplier,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            "assets/icons/circlurDot.svg",
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
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
