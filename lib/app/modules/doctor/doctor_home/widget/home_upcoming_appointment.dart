import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/upcoming_appointment_container.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUpcomingAppointment extends GetView<DoctorHomeController> {
  const HomeUpcomingAppointment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 7 * SizeConfig.heightMultiplier),
              child: const LoadingWidget(),
            )
          : controller.upcomingAppointmentList.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 7 * SizeConfig.heightMultiplier),
                    child: Text(
                      "No Upcoming appointment\nis found.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackBGColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  // padding:
                  //     EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return UpcomingAppointmentContainer(
                      isPadding: false,
                      appointmentModel:
                          controller.upcomingAppointmentList[index],
                    );
                  },
                ),
    );
  }
}
