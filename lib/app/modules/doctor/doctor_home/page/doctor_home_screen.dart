import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:hezr/app/modules/doctor/doctor_home/widget/custom_optional_toggle_button.dart';
import 'package:hezr/app/modules/doctor/doctor_home/widget/line_chart_graph.dart';
import 'package:hezr/app/modules/doctor/doctor_home/widget/more_offer_container.dart';
import 'package:hezr/app/modules/doctor/doctor_home/widget/upcoming_appointment_container.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/app_text_style.dart';

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
            _buildImageSlider(context),
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
            Text(
              "Upcoming Appointment",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.blackBGColor,
                fontSize: SizeConfig.heightMultiplier * 1.6,
              ),
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            const UpcomingAppointmentContainer(),
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
                Text(
                  "See All",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            const MoreOfferContainer(
                statusColor: Color(0xff5BA66B), statusText: "Published"),
            SizedBox(height: 10 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    );
  }

  Row _buildCirclurContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(3, (int index) {
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
    );
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
      itemCount: 3,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 5 * SizeConfig.heightMultiplier,
        width: 100 * SizeConfig.widthMultiplier,
        padding: EdgeInsets.only(left: 3 * SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage("assets/images/tempImage.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Special for you",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 2.8 * SizeConfig.heightMultiplier),
            Text(
              "Pay More\nReach More !",
              style: AppTextStyles.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteBGColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
