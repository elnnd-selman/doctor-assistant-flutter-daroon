import 'dart:convert';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/global/constants/capital_first_letter.dart';
import 'package:daroon_doctor/global/utils/json_message_extension.dart';
import 'package:daroon_doctor/global/widgets/toast_message.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:flutter/material.dart';
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
      } else {}
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
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
        return item.assistant!.firstName!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  RxInt selectedIndex = RxInt(-1);
  RxString selectedAddress = "".obs;
  RxString selectedAddressID = "".obs;
  RxBool addressLoader = false.obs;
  updateAssistantAddress(
      {required AssistantElement assistantData,
      required BuildContext context}) async {
    try {
      addressLoader.value = true;
      final response = await ApiService.putWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint:
            '${AppTokens.apiURl}/assistants/${assistantData.id!}/offices/${selectedAddressID.value}/update',
        body: {
          "permissions": assistantData.permissions,
          "office": selectedAddressID.value,
        },
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = jsonDecode(response.body);
          Get.back();
          Get.back();
          printError(info: "Update Assistant Address $jsonData");
          getAssistantData();
          showToastMessage(
              message: "Update Assistant Address.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body.extractErrorMessage(),
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
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
      final response = await ApiService.putWithHeader(
        userToken: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer ${Get.find<DoctorHomeController>().userModel.value!.token!}",
        },
        endPoint:
            '${AppTokens.apiURl}/assistants/${assistantData.id!}/offices/${selectedAddressID.value}/update',
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
          Get.back();

          getAssistantData();
          showToastMessage(
              message: "Successfully Premission Updated.",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          showToastMessage(
              message: response.body.extractErrorMessage(),
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

        // https://development-api.daroon.krd/assistants/:assistantId/:officeId/delete
        endPoint:
            '${AppTokens.apiURl}/assistants/${assistantData.id}/${assistantData.office!.id}/delete',
        body: {},
      );

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          printInfo(info: "Suucessfull Delete Assistant");
          assistantModel.value!.assistants
              .removeWhere((item) => item.id == assistantData.id);
          assistantModel.refresh();
          Get.back();
          showToastMessage(
              message: "Suucessfully Delete Assistant",
              context: context,
              color: const Color(0xff5BA66B),
              icon: Icons.check);
        } else {
          printInfo(info: "Error While Deleting Assistant ${response.body}");
          showToastMessage(
              message: response.body.extractErrorMessage(),
              context: context,
              color: const Color(0xffEC1C24),
              icon: Icons.close);
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
