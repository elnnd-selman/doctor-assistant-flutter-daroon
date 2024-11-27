import 'dart:convert';

import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/doctor_appointmet_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAppBarOpen = false.obs;

  RxList<AppointmentModel> appointmentModelList = RxList();

  RxList<AppointmentModel> cancelAppointmentList = RxList();
  RxList<AppointmentModel> upcomingAppointmentList = RxList();
  RxList<AppointmentModel> confirmedAppointmentList = RxList();
  RxList<AppointmentModel> completedAppointmentList = RxList();
  // RxList<AppointmentModel> pendingAppointmentList = RxList();
  RxList<AppointmentModel> requestAppointmentList = RxList();

// const APPOINTMENTS_STATUS = {
//   PENDING: "pending",
//   CONFIRMED: "confirmed",
//   CANCELLED: "cancelled",
//   UPCOMING: "upcoming",
//   COMPLETED: "completed",
// }

  getDoctorAppointments() async {
    isLoading.value = true;
    cancelAppointmentList.value = [];

    upcomingAppointmentList.value = [];
    confirmedAppointmentList.value = [];

    completedAppointmentList.value = [];
    requestAppointmentList.value = [];

    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/doctors/appointments",
      userToken: {
        "Authorization": "Bearer ${userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      appointmentModelList.value =
          jsonResponse.map((data) => AppointmentModel.fromJson(data)).toList();

      if (appointmentModelList.isNotEmpty) {
        for (int i = 0; i < appointmentModelList.length; i++) {
          if (appointmentModelList[i].status == "requesting") {
            requestAppointmentList.add(appointmentModelList[i]);
          } else if (appointmentModelList[i].status == "confirmed") {
            confirmedAppointmentList.add(appointmentModelList[i]);
          } else if (appointmentModelList[i].status == "cancelled") {
            cancelAppointmentList.add(appointmentModelList[i]);
          } else if (appointmentModelList[i].status == "upcoming") {
            upcomingAppointmentList.add(appointmentModelList[i]);
          } else {
            completedAppointmentList.add(appointmentModelList[i]);
          }
        }
      }

      upcomingAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      cancelAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      completedAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      confirmedAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      requestAppointmentList
          .sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));

      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Rxn<UserModel> userModel = Rxn();
  @override
  Future<void> onInit() async {
    super.onInit();

    userModel.value = await Get.find<LocalStorageController>()
        .daroonBox!
        .get("userModel", defaultValue: UserModel);
    await getDoctorAppointments();
  }

/////////////////
  RxInt currentIndex = RxInt(-1);

  RxList<String> weekDaysList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ].obs;

  RxInt currentTimeIndex = RxInt(-1);

  RxList<String> timeDaysList = [
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
  ].obs;

  RxList<String> weekDaysListFull = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday"
  ].obs;

  RxBool processing = false.obs;
  // reScheduleAppointment(
  //   AppointmentModel appointmentModel,
  //   BuildContext context,
  // ) async {
  //   try {
  //     processing.value = true;
  //     final response = await ApiService.putWithHeader(
  //         userToken: {
  //           'Content-Type': 'application/json',
  //           "Authorization":
  //               "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
  //         },
  //         endPoint:
  //             '${AppTokens.apiURl}/doctors/appointments/${appointmentModel.id}/reschedule',
  //         body: {
  //           "selectedDay": weekDaysListFull[currentIndex.value],
  //           "selectedTime": timeDaysList[currentTimeIndex.value],
  //         });

  //     if (response != null) {
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         print(response.body);
  //       } else {
  //         print(response.body);
  //         showToastMessage(
  //             message: response.body,
  //             // ignore: use_build_context_synchronously
  //             context: context,
  //             color: const Color(0xffEC1C24),
  //             icon: Icons.close);
  //       }
  //     }
  //     processing.value = false;
  //   } catch (e) {
  //     processing.value = false;
  //     printInfo(info: e.toString());
  //   }
  // }

  RxString selectedTime = "".obs;

  reScheduleAppointment(
    AppointmentModel appointmentModel,
    BuildContext context,
    String appointmetType,
  ) async {
    try {
      processing.value = true;
      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint:
              '${AppTokens.apiURl}/appointments/${appointmentModel.id}/reschedule',
          body: {
            "selectedDay": weekDaysListFull[currentIndex.value],
            "selectedTime": selectedTime.value,
          });

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (appointmetType.toLowerCase() == "completed") {
            completedAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);

            requestAppointmentList.add(appointmentModel);
          }
          Get.back();
          successTextMessage(
              message:
                  'You send a request for appointment with Dr.${appointmentModel.doctor!.firstName!}',
              // ignore: use_build_context_synchronously

              color: const Color(0xffEC1C24),
              icon: Icons.close);
        } else {
          successTextMessage(
              message: response.body,
              // ignore: use_build_context_synchronously

              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      }
      processing.value = false;
    } catch (e) {
      processing.value = false;
      printInfo(info: e.toString());
    }
  }

  final _confirmProcessing = false.obs;
  bool get confirmProcessing => _confirmProcessing.value;
  confirmAppointment(
    AppointmentModel appointmentModel,
    BuildContext context,
    String status,
    bool isMainPage,
  ) async {
    try {
      _confirmProcessing.value = true;
      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint:
              '${AppTokens.apiURl}/doctors/appointments/${appointmentModel.id}/$status',
          body: {});

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (status == "confirmed") {
            upcomingAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);
            confirmedAppointmentList.add(appointmentModel);
            // Get.back();
            successTextMessage(
                message: "Successfully confirmed appointmetnt",
                // ignore: use_build_context_synchronously

                color: const Color(0xff5BA66B),
                icon: Icons.check);
          } else if (status == "completed") {
            confirmedAppointmentList
                .removeWhere((item) => item.id == appointmentModel.id);
            completedAppointmentList.add(appointmentModel);
            // Get.back();
            successTextMessage(
                message: "Successfully complete appointmetnt",
                // ignore: use_build_context_synchronously

                color: const Color(0xff5BA66B),
                icon: Icons.check);
          }
          if (!isMainPage) {
            Get.back();
          }
        } else {
          successTextMessage(
              message: response.body.extractErrorMessage(),
              // ignore: use_build_context_synchronously

              color: const Color(0xffEC1C24),
              icon: Icons.close);
        }
      }
      _confirmProcessing.value = false;
    } catch (e) {
      print(e.toString());
      _confirmProcessing.value = false;
    }
  }

  ////////////////
  RxList<Day> appointmentTimeList = <Day>[].obs;
  setAppointmentData(AppointmentTimes appointmentTimes) {
    appointmentTimeList.value = [];

    if (currentIndex.value == 0) {
      appointmentTimeList.value = appointmentTimes.sunday;
    } else if (currentIndex.value == 1) {
      appointmentTimeList.value = appointmentTimes.monday;
    } else if (currentIndex.value == 2) {
      appointmentTimeList.value = appointmentTimes.tuesday;
    } else if (currentIndex.value == 3) {
      appointmentTimeList.value = appointmentTimes.wednesday;
    } else if (currentIndex.value == 4) {
      appointmentTimeList.value = appointmentTimes.thursday;
    } else if (currentIndex.value == 5) {
      appointmentTimeList.value = appointmentTimes.friday;
    } else if (currentIndex.value == 6) {
      appointmentTimeList.value = appointmentTimes.saturday;
    }
  }
}
