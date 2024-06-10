import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hezr/app/modules/doctor/doctor_home/widget/upcoming_appointment_container.dart';
import 'package:hezr/app/routes/app_routes.dart';
import 'package:hezr/global/constants/size_config.dart';
import 'package:hezr/global/utils/widget_spacing.dart';

class UpcomingAppointment extends StatelessWidget {
  const UpcomingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 3 * SizeConfig.widthMultiplier, vertical: 10),
      child: Column(
        children: [
          30.verticalSpace,
          InkWell(
            onTap: () {
              Get.toNamed(Routes.doctorAppointmentDetail, arguments: {
                "buttonName": "Confirm",
                "type": "upcoming",
                "textColor": const Color(0xffFFC000),
                "isReschedule": true,
                "title": "Upcoming Appointment",
                "showButton": true,
              });
            },
            child: const UpcomingAppointmentContainer(),
          ),
        ],
      ),
    );
  }
}
