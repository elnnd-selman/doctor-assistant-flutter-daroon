import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/speciality_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorEditSpecialityController extends GetxController {
  RxList<SpecialityData> specialityDataList = <SpecialityData>[].obs;
  RxInt selectedIndex = RxInt(-1);

  RxBool isLoading = false.obs;

  getSpecialityData() async {
    isLoading.value = true;
    final response = await ApiService.getwithUserToken(
      endPoint: '${AppTokens.apiURl}/users/speciality',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      specialityDataList.value = List<SpecialityData>.from(
          jsonData["data"]!.map((x) => SpecialityData.fromJson(x)));
    } else if (response.statusCode == 401) {
      final jsonData = jsonDecode(response.body);
      if (jsonData["message"] == "unauthorized") {
        Get.find<DoctorHomeController>().signOutUser();
      }
    }
    isLoading.value = false;
  }

  updateDoctorSpeciality({
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;
      final response = await ApiService.putWithHeader(
          userToken: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
          },
          endPoint: '${AppTokens.apiURl}/doctors',
          body: {
            "speciality": specialityDataList[selectedIndex.value].id,
          });

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.back();
          Get.find<DoctorEditProfileController>().getUserProfileData();
          Get.find<DoctorEditProfileController>().imageUrl.value = '';
          showToastMessage(
              message: "Update Level Successfully",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
          printInfo(info: "Error While Updating  Level  ${response.body}");
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSpecialityData();
  }
}
