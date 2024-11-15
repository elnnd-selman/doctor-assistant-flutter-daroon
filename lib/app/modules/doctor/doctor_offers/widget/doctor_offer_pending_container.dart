import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/more_offer_container.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/controller/doctor_offers_controller.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorOfferPendingContainer extends GetView<DoctorOffersController> {
  const DoctorOfferPendingContainer({super.key});

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
                        return CupertinoButton(
                          pressedOpacity: 0,
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () => Get.toNamed(
                              Routes.doctorOffersDetails,
                              arguments: [
                                controller.offerSearchList[index],
                                const Color(0xffFFC000),
                                "Pending"
                              ]),
                          child: MoreOfferContainer(
                              offersData: controller.offerSearchList[index],
                              statusColor: const Color(0xffFFC000),
                              statusText: "Pending"),
                        );
                      },
                    )
              : controller.doctorOfferPendingModel.isEmpty
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
                      itemCount: controller.doctorOfferPendingModel.length,
                      itemBuilder: (context, index) {
                        return CupertinoButton(
                          pressedOpacity: 0,
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () => Get.toNamed(
                              Routes.doctorOffersDetails,
                              arguments: [
                                controller.doctorOfferPendingModel[index],
                                const Color(0xffFFC000),
                                "Pending"
                              ]),
                          child: MoreOfferContainer(
                              offersData:
                                  controller.doctorOfferPendingModel[index],
                              statusColor: const Color(0xffFFC000),
                              statusText: "Pending"),
                        );
                      },
                    ),
    );
  }
}
