import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_chat_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:get/get.dart';

class DoctorChatRoomController extends GetxController {
  RxList<DoctorChatModel> userChatList = <DoctorChatModel>[].obs;
  RxBool isLoading = false.obs;
  //

  getUserChatConversation(String chatID) async {
    try {
      isLoading.value = true;
      final response = await ApiService.getwithUserToken(
        endPoint: "${AppTokens.apiURl}/doctors/conversations/$chatID/messages",
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );
      if (response!.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

        userChatList.value =
            jsonResponse.map((data) => DoctorChatModel.fromJson(data)).toList();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
  }
}
