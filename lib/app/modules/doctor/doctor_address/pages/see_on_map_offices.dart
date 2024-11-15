import 'package:carousel_slider/carousel_slider.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeeOnMapOffices extends GetView<DoctorAddressController> {
  const SeeOnMapOffices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.symmetric(vertical: 6),
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx(
                () => GoogleMap(
                  markers: Set<Marker>.from(
                    controller.markers.map((marker) => marker),
                  ),
                  mapType: MapType.terrain,
                  initialCameraPosition: controller.kGooglePlex,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController googleCtrl) {
                    controller.completer.complete(googleCtrl);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: SizedBox(
                // color: AppColors.w,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.15,
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: .9,
                    ),
                    itemCount: controller.officeAddressModelList.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return SeeOnMapContainer(
                        officeAddreesModel:
                            controller.officeAddressModelList[itemIndex],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeeOnMapContainer extends StatelessWidget {
  final OfficeAddreesModel officeAddreesModel;
  const SeeOnMapContainer({super.key, required this.officeAddreesModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
          vertical: 2 * SizeConfig.heightMultiplier,
          horizontal: 4 * SizeConfig.widthMultiplier),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.whiteBGColor,
          border: Border.all(color: const Color(0xffE8E8E8), width: 0.5)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff6FCF84)),
              ),
              10.horizontalSpace,
              Text(
                "${officeAddreesModel.daysOpen.length} days per week",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff898A8D),
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
              const Spacer(),
              CupertinoButton(
                pressedOpacity: 0,
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: () => Get.toNamed(
                  Routes.doctorAdressDetail,
                  arguments: [
                    officeAddreesModel,
                  ],
                ),
                child: Text(
                  "See Details",
                  style: AppTextStyles.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              10.horizontalSpace,
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.primaryColor,
              )
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE8E8E8),
                width: .5,
              ),
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Assets.locationIcon,
                        colorFilter: const ColorFilter.mode(
                            AppColors.whiteBGColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2 * SizeConfig.heightMultiplier),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      officeAddreesModel.description!,
                      maxLines: 2,
                      style: AppTextStyles.black.copyWith(
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
    );
  }
}
