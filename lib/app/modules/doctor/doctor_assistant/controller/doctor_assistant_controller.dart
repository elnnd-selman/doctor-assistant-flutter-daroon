import 'dart:convert';

import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/model/assistant_model.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_home/controller/doctor_home_controller.dart';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:daroon_doctor/services/api.dart';
import 'package:get/get.dart';

class DoctorAssistantController extends GetxController {
  RxBool isAppBarOpen = false.obs;

  RxBool isLoading = false.obs;
  Rxn<AssistantModel> assistantModel = Rxn();

  getAssistantData() async {
    isLoading.value = true;
    final response = await ApiService.getwithUserToken(
      endPoint: '${AppTokens.apiURl}/assistant/get',
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
}
