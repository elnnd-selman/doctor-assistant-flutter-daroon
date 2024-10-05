import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/more_offer_container.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/widget/offer_toggle_button.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

import 'package:searchbar_animation/searchbar_animation.dart';

class DoctorOffersPage extends GetView<DoctorOffersController> {
  const DoctorOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "My Offers",
            style: AppTextStyles.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackBGColor,
              fontSize: 2 * SizeConfig.heightMultiplier,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => SearchBarAnimation(
                isOriginalAnimation: false,
                buttonColour: controller.isAppBarOpen.value
                    ? const Color(0xffF7F7F8)
                    : AppColors.whiteBGColor,
                searchBoxColour: const Color(0xffF7F7F8).withOpacity(1),
                isSearchBoxOnRightSide: true,
                enableBoxShadow: false,
                enableButtonShadow: false,
                hintText: "Search Offer",
                buttonBorderColour: Colors.black45,
                searchBoxWidth: MediaQuery.of(context).size.width * 0.94,
                onFieldSubmitted: (String value) {
                  debugPrint('onFieldSubmitted value $value');
                },
                onPressButton: (open) {
                  controller.isAppBarOpen.value = open;
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    controller.isSearch.value = true;
                    controller.searchOffer(val);
                  } else {
                    controller.isSearch.value = false;
                  }
                },
                textEditingController: TextEditingController(),
                trailingWidget: SvgPicture.asset(
                  Assets.serachIcon,
                  colorFilter: const ColorFilter.mode(
                      Color(0xff979797), BlendMode.srcIn),
                ),
                secondaryButtonWidget: const Icon(Icons.close),
                buttonWidget: SvgPicture.asset(Assets.serachIcon),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 6 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Obx(() => OfferCustomOptionalToggleButton(
                    leftText: 'Published',
                    centreText: 'Pending',
                    value: controller.selectedTab,
                    onValueChange: controller.selectTab,
                  )),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Row(
                children: [
                  Text(
                    // "21 Published offers",
                    controller.isLoading.value
                        ? '--'
                        : controller.doctorOfferModel.value == null
                            ? '0 Published offers'
                            : "${controller.isLoading.value ? '--' : controller.isSearch.value ? controller.offerSearchList.length : controller.doctorOfferModel.value!.data.length} Published offers",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff979797),
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "+ ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.doctorAddOffers),
                    child: Text(
                      "Add Offer",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3 * SizeConfig.heightMultiplier),
              Obx(
                () => controller.selectedTab == 0
                    ? const DoctorOfferPublishedContainer()
                    //  GestureDetector(
                    //     onTap: () => Get.toNamed(Routes.doctorOffersDetails),
                    //     child: const MoreOfferContainer(
                    //         statusColor: Color(0xff5BA66B),
                    //         statusText: "Published"),
                    //   )
                    : const SizedBox(),
                // const MoreOfferContainer(
                //     statusColor: Color(0xffFFC000), statusText: "Pending"))
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorOfferPublishedContainer extends GetView<DoctorOffersController> {
  const DoctorOfferPublishedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Padding(
              padding: EdgeInsets.only(top: 30 * SizeConfig.heightMultiplier),
              child: const Center(child: LoadingWidget()),
            )
          : controller.isSearch.value
              ? controller.offerSearchList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 30 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Offer found",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBGColor,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.offerSearchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(Routes.doctorOffersDetails,
                              arguments: [
                                controller.offerSearchList[index],
                              ]),
                          child: MoreOfferContainer(
                              offersData: controller.offerSearchList[index],
                              statusColor: const Color(0xff5BA66B),
                              statusText: "Published"),
                        );
                        // return AssistantInfoContainer(
                        //   assistantElement:
                        //       controller.assistantSearchList[index],
                        //   onTap: () {
                        //     Get.toNamed(Routes.doctorAssistantDetail,
                        //         arguments: [
                        //           controller.assistantSearchList[index],
                        //         ]);
                        //   },
                        // );
                      },
                    )
              : controller.doctorOfferModel.value == null
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 30 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Offer available",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBGColor,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : controller.doctorOfferModel.value!.data.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: 30 * SizeConfig.heightMultiplier),
                          child: Text(
                            "No Offer available",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackBGColor,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              controller.doctorOfferModel.value!.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.toNamed(
                                  Routes.doctorOffersDetails,
                                  arguments: [
                                    controller
                                        .doctorOfferModel.value!.data[index],
                                  ]),
                              child: MoreOfferContainer(
                                  offersData: controller
                                      .doctorOfferModel.value!.data[index],
                                  statusColor: const Color(0xff5BA66B),
                                  statusText: "Published"),
                            );
                            // return AssistantInfoContainer(
                            //   assistantElement: controller
                            //       .assistantModel.value!.assistants[index],
                            //   onTap: () {
                            //     Get.toNamed(
                            //       Routes.doctorAssistantDetail,
                            //       arguments: [
                            //         controller.assistantModel.value!
                            //             .assistants[index],
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                        ),
    );
  }
}
