import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_message_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:get/get.dart';

class DoctorMessageController extends GetxController {
  RxList<DoctorMessageModelData> doctorConversationList =
      <DoctorMessageModelData>[].obs;
  RxList<DoctorMessageModelData> searchDoctorList =
      <DoctorMessageModelData>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  //

  getDoctorAllConversation() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getwithUserToken(
        endPoint: "${AppTokens.apiURl}/doctors/conversations",
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

        doctorConversationList.value = jsonResponse
            .map((data) => DoctorMessageModelData.fromJson(data))
            .toList();
      }
      doctorConversationList
          .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDoctorAllConversation();
  }

  searchUserMessage(String query) {
    searchDoctorList.value = [];
    searchDoctorList.value = doctorConversationList
        .where((message) => message.patient!.firstNameEn!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}
