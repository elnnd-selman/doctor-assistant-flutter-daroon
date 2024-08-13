import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/controller/add_assistant_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DoctorAssistantController extends GetxController {
  RxBool isAppBarOpen = false.obs;

  RxBool isLoading = false.obs;
  Rxn<AssistantModel> assistantModel = Rxn();

  RxList<String> premissionList = ['Manage Appointments', 'Manage Posts'].obs;
  RxList selectedPremissionList = [].obs;

  getAssistantData() async {
    isLoading.value = true;
    try {
      final response = await ApiService.getwithUserToken(
        endPoint: '${AppTokens.apiURl}/assistants',
        userToken: {
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
      );

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        assistantModel.value = AssistantModel.fromJson(jsonData);
      } else {
        print(response.body);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAssistantData();
  }

  RxBool isSearch = false.obs;
  RxList<AssistantElement> assistantSearchList = <AssistantElement>[].obs;

  searchAssitant(String query) {
    assistantSearchList.value = [];
    if (assistantModel.value!.assistants.isNotEmpty) {
      assistantSearchList.value =
          assistantModel.value!.assistants.where((item) {
        return item.assistant!.fullName!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  RxInt selectedIndex = RxInt(-1);
  RxString selectedAddress = "".obs;
  RxString selectedAddressID = "".obs;
  RxBool addressLoader = false.obs;
  updateAssistantAddress({
    required AssistantElement assistantData,
  }) async {
    try {
      addressLoader.value = true;
      final response = await ApiService.pustwithOutHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/assistants/${assistantData.id!}/update',
        body: {
          "permissions": assistantData.permissions,
          "office": selectedAddressID.value,
        },
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = jsonDecode(response.body);
          printError(info: "Update Assistant Address $jsonData");
        } else {
          printInfo(
              info: "Error While Updating Assistant Address ${response.body}");
        }
      }
      addressLoader.value = false;
    } catch (e) {
      addressLoader.value = false;
      printInfo(info: e.toString());
    }
  }

  RxBool premissionLoader = false.obs;
  updateAssistantPremission({
    required AssistantElement assistantData,
    required BuildContext context,
  }) async {
    premissionLoader.value = true;
    try {
      final tempStringList = [];
      for (int i = 0; i < selectedPremissionList.length; i++) {
        tempStringList.add(convertText(selectedPremissionList[i]));
      }
      final response = await ApiService.pustwithOutHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/assistants/${assistantData.id!}/update',
        body: {
          "permissions": tempStringList,
          "office": assistantData.office!.id!,
        },
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = jsonDecode(response.body);
          printError(info: "Update Assistant Premiison $jsonData");
          Get.back();
          showToastMessage(
              message: "Successfully Premission Updated.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body,
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
          printInfo(
              info:
                  "Error While Updating Assistant Premiison ${response.body}");
        }
      }
      premissionLoader.value = false;
    } catch (e) {
      showToastMessage(
          message: "Issue ${e.toString()}",
          context: context,
          color: const Color(0xffEC1C24),
          icon: Icons.close);
      premissionLoader.value = false;
      printInfo(info: e.toString());
    }
  }

  RxBool deleteLoader = false.obs;
  deleteAssistant({
    required AssistantElement assistantData,
    required BuildContext context,
  }) async {
    deleteLoader.value = true;
    try {
      final response = await ApiService.deleteWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint: '${AppTokens.apiURl}/assistants/:${assistantData.id}/delete',
        body: {},
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          printInfo(info: "Suucessfull Delete Assistant");
        } else {
          printInfo(info: "Error While Deleting Assistant ${response.body}");
        }
      }
      deleteLoader.value = false;
    } catch (e) {
      deleteLoader.value = false;
      printInfo(info: e.toString());
    }
  }

  String convertText(String input) {
    List<String> words = input.split(' ');
    String firstWord = words[0].toLowerCase();
    String secondWord = words[1].capitalizeFirstLetter();
    return firstWord + secondWord;
  }
}
