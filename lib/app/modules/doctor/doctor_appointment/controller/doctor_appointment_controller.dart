import 'dart:convert';

import 'package:daroon_doctor/app/controllers/local_storage_controller.dart';
import 'package:daroon_doctor/app/model/user_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/model/doctor_appointmet_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAppBarOpen = false.obs;

  RxList<AppointmentModel> appointmentModelList = RxList();

  RxList<AppointmentModel> cancelAppointmentList = RxList();
  RxList<AppointmentModel> upcomingAppointmentList = RxList();
  RxList<AppointmentModel> confirmedAppointmentList = RxList();
  RxList<AppointmentModel> completedAppointmentList = RxList();
  RxList<AppointmentModel> pendingAppointmentList = RxList();

// const APPOINTMENTS_STATUS = {
//   PENDING: "pending",
//   CONFIRMED: "confirmed",
//   CANCELLED: "cancelled",
//   UPCOMING: "upcoming",
//   COMPLETED: "completed",
// }

  getDoctorAppointments() async {
    isLoading.value = true;

    final response = await ApiService.getwithUserToken(
      endPoint: "${AppTokens.apiURl}/appointment",
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
          if (appointmentModelList[i].status == "pending") {
            pendingAppointmentList.add(appointmentModelList[i]);
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
      pendingAppointmentList
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
}
