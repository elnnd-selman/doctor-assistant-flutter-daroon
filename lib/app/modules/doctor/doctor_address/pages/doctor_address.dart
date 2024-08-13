import 'dart:async';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAdressScreen extends GetView<DoctorAddressController> {
  DoctorAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const SpinKitSpinningLines(
              color: AppColors.primaryColor,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    14.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "Your Addresses",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackBGColor,
                            fontSize: SizeConfig.heightMultiplier * 1.8,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "See On Map",
                          style: AppTextStyles.medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            fontSize: 14,
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          markers: Set<Marker>.from(
                            controller.markers.map((marker) => marker),
                          ),
                          mapType: MapType.terrain,
                          initialCameraPosition: controller.kGooglePlex,
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                    Container(
                      height: 0.5,
                      // width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE8E8E8),
                          width: .5,
                        ),
                      ),
                    ),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                    Text(
                      "${controller.officeAddressModelList.length} Addresses",
                      style: AppTextStyles.medium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.lighttextColor,
                        fontSize: SizeConfig.heightMultiplier * 1.8,
                      ),
                    ),
                    SizedBox(height: 1 * SizeConfig.heightMultiplier),
                    controller.officeAddressModelList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: NoDataWidget(
                                backGroundcolor: AppColors.secondaryborderColor,
                                svgIconColor: Colors.white,
                                iconType: true,
                                iconPath: "assets/icons_png/no_location.png",
                                title: "No Address",
                                description: "No office Address Available"),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.officeAddressModelList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(controller
                                      .officeAddressModelList[index].id);

                                  print(Get.find<DoctorHomeController>()
                                      .userModel
                                      .value!
                                      .user!
                                      .id!);
                                  print(Get.find<DoctorHomeController>()
                                      .userModel
                                      .value!
                                      .user!
                                      .id!);
                                  print(Get.find<DoctorHomeController>()
                                      .userModel
                                      .value!
                                      .token);
                                  Get.toNamed(
                                    Routes.doctorAdressDetail,
                                    arguments: [
                                      controller.officeAddressModelList[index],
                                    ],
                                  );
                                },
                                child: AddressContainer(
                                  officeAddreesModel:
                                      controller.officeAddressModelList[index],
                                ),
                              );
                            }),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
            ),
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
}

class AddressContainer extends StatelessWidget {
  final OfficeAddreesModel officeAddreesModel;
  const AddressContainer({
    super.key,
    required this.officeAddreesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
          vertical: 2 * SizeConfig.heightMultiplier,
          horizontal: 5 * SizeConfig.widthMultiplier),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
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
                "${officeAddreesModel.daysOpen!.length} days per week",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff898A8D),
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
              const Spacer(),
              Container(
                height: 22,
                width: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(Assets.moreDotIcon),
              ),
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
