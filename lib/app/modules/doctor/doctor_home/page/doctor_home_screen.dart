import 'package:carousel_slider/carousel_slider.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/home_upcoming_appointment.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/more_offer_container.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/network_image_loader.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/custom_optional_toggle_button.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/line_chart_graph.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';

class DoctorHomeScreen extends GetView<DoctorHomeController> {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 4 * SizeConfig.widthMultiplier,
          vertical: 3 * SizeConfig.heightMultiplier),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.isAdsLoading.value
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          color: AppColors.lightgreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: LoadingWidget()),
                    )
                  : controller.publicADSList.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              color: AppColors.lightgreyColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: NoDataWidget(title: "No Ads available")))
                      : _buildImageSlider(context),
            ),
            SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
            _buildCirclurContainer(),
            SizedBox(height: 4 * SizeConfig.heightMultiplier),
            Row(
              children: [
                Text(
                  "Appointments\nOverview",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackBGColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => CustomOptionalToggleButton(
                    leftText: 'Weekly',
                    centreText: 'Monthly',
                    rightText: 'Yearly',
                    value: controller.selectedTab,
                    onValueChange: controller.selectTab,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4 * SizeConfig.heightMultiplier),
            const LineChartGraph(),
            SizedBox(height: 3 * SizeConfig.heightMultiplier),
            Row(
              children: [
                Text(
                  "Upcoming Appointment",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackBGColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                ),
                20.horizontalSpace,
                Container(
                  height: 3 * SizeConfig.heightMultiplier,
                  width: 3 * SizeConfig.heightMultiplier,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Obx(
                    () => Text(
                      controller.isLoading.value
                          ? "0"
                          : controller.upcomingAppointmentList.length
                              .toString(),
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteBGColor,
                        fontSize: SizeConfig.heightMultiplier * 1.5,
                      ),
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            const HomeUpcomingAppointment(),
            SizedBox(height: 3 * SizeConfig.heightMultiplier),
            Row(
              children: [
                Text(
                  "Most Booked Offer",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackBGColor,
                    fontSize: SizeConfig.heightMultiplier * 1.6,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () => Get.toNamed(Routes.doctorOffers),
                  child: Text(
                    "See All",
                    style: AppTextStyles.medium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontSize: 1.7 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            Obx(
              () => controller.processing.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 7 * SizeConfig.heightMultiplier),
                      child: const Center(child: LoadingWidget()),
                    )
                  : controller.doctorOfferPublishedModel.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 7 * SizeConfig.heightMultiplier),
                          child: const Center(
                              child: NoDataWidget(title: "No Offer available")),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return CupertinoButton(
                              pressedOpacity: 0,
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () => Get.toNamed(
                                  Routes.doctorOffersDetails,
                                  arguments: [
                                    controller.doctorOfferPublishedModel[index],
                                    const Color(0xff5BA66B),
                                    "Published"
                                  ]),
                              child: MoreOfferContainer(
                                  offersData: controller
                                      .doctorOfferPublishedModel[index],
                                  statusColor: const Color(0xff5BA66B),
                                  statusText: "Published"),
                            );
                          },
                        ),
            ),
            SizedBox(height: 10 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    );
  }

  Obx _buildCirclurContainer() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(controller.publicADSList.length, (int index) {
              return Obx(() => Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: controller.isSelected.value == index ? 8 : 8,
                    width: controller.isSelected.value == index ? 8 : 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.isSelected.value == index
                            ? AppColors.primaryColor
                            : Colors.black.withOpacity(0.12)),
                  ));
            }),
          ],
        ));
  }

  CarouselSlider _buildImageSlider(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.2,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: false,
        enlargeFactor: 0,
        scrollDirection: Axis.horizontal,
        onPageChanged: (val, v) {
          controller.isSelected.value = val;
        },
      ),
      itemCount: controller.publicADSList.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        height: MediaQuery.of(context).size.height * 0.2,
        width: 100 * SizeConfig.widthMultiplier,
        padding: EdgeInsets.only(left: 2 * SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: NetWorkImageLoader(
                boxFit: BoxFit.cover,
                imageURL: controller.publicADSList[itemIndex].image!.md!,
                height: MediaQuery.of(context).size.height * 0.2,
                width: 100 * SizeConfig.widthMultiplier,
              ),
            ),
            // SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
            //   child: Text(
            //     "Special for you",
            //     style: AppTextStyles.medium.copyWith(
            //       fontWeight: FontWeight.w500,
            //       color: AppColors.primaryColor,
            //       fontSize: 12,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 2.8 * SizeConfig.heightMultiplier),
            Positioned(
              bottom: 5 * SizeConfig.heightMultiplier,
              left: 6 * SizeConfig.widthMultiplier,
              child: Text(
                controller.publicADSList[itemIndex].titleAr!,
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteBGColor,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 2 * SizeConfig.heightMultiplier,
              left: 6 * SizeConfig.widthMultiplier,
              child: Text(
                controller.publicADSList[itemIndex].descriptionEn!,
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightgreyColor,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
