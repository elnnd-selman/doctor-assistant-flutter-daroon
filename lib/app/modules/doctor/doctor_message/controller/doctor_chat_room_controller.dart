import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/model/doctor_chat_model.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorChatRoomController extends GetxController {
  RxList<DoctorChatModel> userChatList = <DoctorChatModel>[].obs;
  RxBool isLoading = false.obs;
  Rx<ScrollController> scrollController = ScrollController().obs;

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
      userChatList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

      isLoading.value = false;
      await movetoEnd();
    } catch (e) {
      isLoading.value = false;
      printInfo(info: e.toString());
    }
  }

  RxBool hasScrolled = false.obs;

  movetoEnd() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.value.hasClients) {
        if (!hasScrolled.value) {
          scrollController.value.animateTo(
            scrollController.value.position.maxScrollExtent + 100,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );

          hasScrolled.value = true;
        }
      }
    });
  }
}
