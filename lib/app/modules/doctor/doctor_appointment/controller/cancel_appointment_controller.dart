import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/controller/doctor_appointment_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/cancel_appointment_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/doctor_appointmet_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelAppointmentController extends GetxController {
  RxInt currentIndex = 0.obs;

  final _processing = false.obs;
  bool get processing => _processing.value;

  final TextEditingController reasonTextField = TextEditingController();

  cancelAppointmentApi(BuildContext context, AppointmentModel appointmentModel,
      String previousCategory) async {
    try {
      _processing.value = true;
      final response = await ApiService.putWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint:
            '${AppTokens.apiURl}/doctors/appointments/${appointmentModel.id}/cancelled',
        body: {
          "cancelledReason": currentIndex.value == 4
              ? reasonTextField.text
              : cancelAppointmentList[currentIndex.value].title,
        },
      );
      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (previousCategory == "requesting") {
            Get.find<DoctorAppointmentController>()
                .requestAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);
          } else if (previousCategory == 'upcoming') {
            Get.find<DoctorAppointmentController>()
                .upcomingAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);
          } else if (previousCategory == "confirmed") {
            Get.find<DoctorAppointmentController>()
                .confirmedAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);
          }

          appointmentModel.cancelledReason = currentIndex.value == 4
              ? reasonTextField.text
              : cancelAppointmentList[currentIndex.value].title;
          Get.find<DoctorAppointmentController>()
              .cancelAppointmentList
              .add(appointmentModel);
          Get.back();
          Get.back();
          showToastMessage(
              message: "Appointment cancelled successfully.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.check);
        }
      }
      _processing.value = false;
    } catch (e) {
      _processing.value = false;
      printInfo(info: e.toString());
    }
    _processing.value = false;
  }
}
