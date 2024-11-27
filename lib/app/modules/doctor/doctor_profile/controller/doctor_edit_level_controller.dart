import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/controller/doctor_edit_profile_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/level_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/user_profile_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorEditLevelCtrl extends GetxController {
  RxList<LevelData> levelDataList = <LevelData>[].obs;
  RxString selectedLevel = ''.obs;

  RxBool isLoading = false.obs;

  getLevelData() async {
    isLoading.value = true;
    final response = await ApiService.getwithUserToken(
      endPoint: '${AppTokens.apiURl}/users/levels',
      userToken: {
        "Authorization":
            "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
      },
    );
    if (response!.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      levelDataList.value = List<LevelData>.from(
          jsonData["data"]!.map((x) => LevelData.fromJson(x)));
    } else if (response.statusCode == 401) {
      final jsonData = jsonDecode(response.body);
      if (jsonData["message"] == "unauthorized") {
        Get.find<DoctorHomeController>().signOutUser();
      }
    }
    isLoading.value = false;
  }

  updateDoctorLevel({
    required UserProfileData data,
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
            "level": selectedLevel.value,
          });

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.back();
          Get.find<DoctorEditProfileController>().getUserProfileData();
          Get.find<DoctorEditProfileController>().imageUrl.value = '';
          showToastMessage(
              message: "Update Speciality Successfully",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body.extractErrorMessage(),
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
          printInfo(info: "Error While Updating  Speciality  ${response.body}");
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
    getLevelData();
  }
}
