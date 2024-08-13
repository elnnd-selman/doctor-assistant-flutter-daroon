import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/controller/doctor_appointment_controller.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/widget/upcoming_appointment_container.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';

class UpcomingAppointment extends GetView<DoctorAppointmentController> {
  const UpcomingAppointment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 3 * SizeConfig.widthMultiplier, vertical: 10),
      child: controller.isLoading.value
          ? const LoadingWidget()
          : controller.upcomingAppointmentList.isEmpty
              ? const Text("fffrr")
              : ListView.builder(
                  padding:
                      EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier),
                  shrinkWrap: true,
                  itemCount: controller.upcomingAppointmentList.length,
                  itemBuilder: (context, index) {
                    return UpcomingAppointmentContainer(
                      appointmentModel:
                          controller.upcomingAppointmentList[index],
                    );
                  }),
      // InkWell(
      //   onTap: () {
      //     Get.toNamed(Routes.doctorAppointmentDetail, arguments: {
      //       "buttonName": "Confirm",
      //       "type": "upcoming",
      //       "textColor": const Color(0xffFFC000),
      //       "isReschedule": true,
      //       "title": "Upcoming Appointment",
      //       "showButton": true,
      //     });
      //   },
      //   child: const UpcomingAppointmentContainer(),
      // ),
    );
  }
}
