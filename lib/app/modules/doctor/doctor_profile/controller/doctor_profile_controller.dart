import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/model/post_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:intl/intl.dart';

class DoctorProfileController extends GetxController {
  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;
  RxInt currentPage = 0.obs;
  RxInt totalPages = 1.obs;
  RxBool isLoading = false.obs;

  void selectTab(int value) {
    _selectedTab.value = value;
  }

  Rxn<ContentModel> contentModelList = Rxn();

  getDoctorPost() async {
    isLoading.value = true;

    try {
      if (kDebugMode) {
        print(Get.find<DoctorHomeController>().userModel.value!.user!.id);
        print(Get.find<DoctorHomeController>().userModel.value!.token!);
      }

      final response = await ApiService.getwithUserToken(
        endPoint:
            '${AppTokens.apiURl}/content/my-contents?pagination=1&limit=10&contentType=post',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        contentModelList.value = ContentModel.fromJson(jsonData);
        totalPages.value = contentModelList.value!.paginationCount!;
      } else {
        printError(info: response.body);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getDoctorPost();
  }

  String convertDateToformat(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd-MMM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  updateLikeOnPost() {}
}
