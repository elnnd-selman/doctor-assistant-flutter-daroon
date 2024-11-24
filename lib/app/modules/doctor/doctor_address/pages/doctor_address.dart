import 'package:daroon_doctor/app/modules/doctor/doctor_address/widget/address_container.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:daroon_doctor/global/widgets/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';

class DoctorAdressScreen extends GetView<DoctorAddressController> {
  const DoctorAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const SpinKitSpinningLines(
              color: AppColors.primaryColor,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                        CupertinoButton(
                          pressedOpacity: 0,
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () => Get.toNamed(Routes.seeOnMapOffices),
                          child: Text(
                            "See On Map",
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
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
                          )),
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
                    Obx(
                      () => controller.isDeleting.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 100),
                              child: LoadingWidget(),
                            )
                          : controller.officeAddressModelList.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: NoDataWidget(
                                      title: "No office Address Available"),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.officeAddressModelList.length,
                                  itemBuilder: (context, index) {
                                    return CupertinoButton(
                                      pressedOpacity: 0,
                                      padding: EdgeInsets.zero,
                                      minSize: 0,
                                      onPressed: () {
                                        Get.toNamed(
                                          Routes.doctorAdressDetail,
                                          arguments: [
                                            controller
                                                .officeAddressModelList[index],
                                          ],
                                        );
                                      },
                                      child: AddressContainer(
                                        officeAddreesModel: controller
                                            .officeAddressModelList[index],
                                      ),
                                    );
                                  }),
                    ),
                    SizedBox(height: 10 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
            ),
    );
  }
}
